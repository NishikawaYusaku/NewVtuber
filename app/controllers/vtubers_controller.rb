class VtubersController < ApplicationController
  before_action :require_login, except: %i[index show]

  def index; end

  def show
    @vtuber = Vtuber.find(params[:id])
    @comment = Comment.new
    @comments = @vtuber.comments
    @youtube = VtuberYoutube.find_by(vtuber_id: @vtuber.id)
  end

  def autocomplete_names
    normalized_term = params[:term]
      .then { |t| Moji.zen_to_han(t) }
      .then { |t| Moji.kata_to_hira(t) }
      .then { |t| Moji.upcase(t) }

    names = Vtuber.pluck(:name).select do |name|
      normalized_name = name
        .then { |n| Moji.zen_to_han(n) }
        .then { |n| Moji.kata_to_hira(n) }
        .then { |n| Moji.upcase(n) }
      normalized_name.include?(normalized_term)
    end

    render json: names
  end

  def name_input
    @vtuber = Vtuber.find_by(name: params[:name])

    if @vtuber
      redirect_to action: 'edit', id: @vtuber.id
    else
      redirect_to action: 'new', name: params[:name]
    end
  end

  def new
    @vtuber = Vtuber.new(name: params[:name])
    @vtuber_place = @vtuber.vtuber_places.new
  end

  def edit
    @vtuber = Vtuber.find_by(id: params[:id])
    @tag = @vtuber.tags.pluck(:name).join('、')
  end

  def create
    @vtuber = current_user.vtubers.new(vtuber_params)

    @youtube_channel_id = is_platform_youtube

    params[:vtuber][:name_x].slice!(0) if params[:vtuber][:name_x][0] == "@"

    if @vtuber.save
      VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id).save

      tag_list = params[:vtuber][:tag].split(/[、,　 ]/)
      @vtuber.save_tags(tag_list)

      if @youtube_channel_id.present?
        youtube_channel_id_check = VtuberYoutube.find_by(channel_id: @youtube_channel_id)
        @vtuber.save_youtube_information(@vtuber.id, @youtube_channel_id) if youtube_channel_id_check.nil?

        @vtuber.get_profile_icon_from_youtube(@vtuber, @youtube_channel_id) if @vtuber.image.identifier.nil?
      end

      redirect_to vtuber_path(@vtuber)
      flash[:success] = "VTuberを登録しました"
    else
      flash.now[:danger] = "VTuberを登録できませんでした"
      render :new
    end
  end

  def update
    @vtuber = Vtuber.find(params[:id])

    latest_version = @vtuber.version
    if latest_version != params[:vtuber][:version].to_i
      flash[:danger] = "他の人が先にプロフィールを更新しましたので、内容を確認して再編集してください。"
      redirect_to vtuber_path(@vtuber)
    end

    @youtube_channel_id = is_platform_youtube

    if @vtuber.update(vtuber_params)
      VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id).save

      tag_list = params[:vtuber][:tag].split(/[、,　 ]/)
      @vtuber.save_tags(tag_list)

      if @youtube_channel_id.present?
        @vtuber.save_youtube_information(@vtuber.id, @youtube_channel_id)

        @vtuber.get_profile_icon_from_youtube(@vtuber, @youtube_channel_id) if @vtuber.image.identifier.nil?
      end

      @vtuber.notification_update(current_user)
      @vtuber.update(version: @vtuber.version + 1)

      flash[:success] = "VTuberを更新しました"
      redirect_to vtuber_path(@vtuber)
    else
      flash.now[:danger] = "VTuberを更新できませんでした"
      render :edit
    end
  end

  private

  def vtuber_params
    params.require(:vtuber).permit(:name, :affiliation, :name_x, :gender, :language, :birthday, :height, :blood_type, :debut_date, :like, :unlike, :image, :remove_image, vtuber_places_attributes: [:place_id, :url, :_destroy, :id], content_ids: [])
  end

  def is_platform_youtube
    place_id = params[:vtuber][:vtuber_places_attributes]["0"][:place_id]
    url = params[:vtuber][:vtuber_places_attributes]["0"][:url]
    @vtuber.get_youtube_channel_id(url) if place_id == "1" && url.present?
  end
end

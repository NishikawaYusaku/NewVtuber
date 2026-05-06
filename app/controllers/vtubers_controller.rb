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
      .then { |t| Moji.han_to_zen(t) }
      .then { |t| Moji.kata_to_hira(t) }
      .then { |t| Moji.upcase(t) }

    names = Vtuber.pluck(:name).select do |name|
      normalized_name = name
        .then { |n| Moji.han_to_zen(n) }
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

  def autocomplete_affiliations
    normalized_term = params[:term]
      .then { |t| Moji.han_to_zen(t) }
      .then { |t| Moji.kata_to_hira(t) }
      .then { |t| Moji.upcase(t) }

    affiliations = Vtuber.distinct.pluck(:affiliation).select do |affiliation|
      normalized_affiliation = affiliation
        .then { |a| Moji.han_to_zen(a) }
        .then { |a| Moji.kata_to_hira(a) }
        .then { |a| Moji.upcase(a) }
      normalized_affiliation.include?(normalized_term)
    end

    render json: affiliations
  end

  def create
    @vtuber = current_user.vtubers.new(vtuber_params)

    url = params[:vtuber][:vtuber_places_attributes]["0"][:url]
    if url.include?("youtube.com")
      @youtube_channel_id = @vtuber.get_youtube_channel_id(url)
      if @youtube_channel_id.present? && VtuberYoutube.find_by(channel_id: @youtube_channel_id).present?
        @vtuber.errors.add(:base, "このYouTubeチャンネルIDは既に登録されています")
        flash.now[:danger] = "VTuberを登録できませんでした"
        render :new and return
      end
    end

    if @vtuber.save
      VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id).save

      @vtuber.update_column(:display_order, @vtuber.id)

      tag_list = params[:vtuber][:tag].split(/[、,　 ]/)
      @vtuber.save_tags(tag_list)

      if @youtube_channel_id.present?
        @vtuber.save_youtube_information(@vtuber.id, @youtube_channel_id)
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

    url = params[:vtuber][:vtuber_places_attributes]["0"][:url]
    if url.include?("youtube.com")
      @youtube_channel_id = @vtuber.get_youtube_channel_id(url)
      vtuber_youtube_data = VtuberYoutube.find_by(channel_id: @youtube_channel_id)
      if vtuber_youtube_data.present? && vtuber_youtube_data.vtuber_id != @vtuber.id
        @vtuber.errors.add(:base, "このYouTubeチャンネルIDは既に登録されています")
        flash.now[:danger] = "VTuberを更新できませんでした"
        render :edit and return
      end
    end

    if @vtuber.update(vtuber_params)
      VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id).save

      tag_list = params[:vtuber][:tag].split(/[、,　 ]/)
      @vtuber.save_tags(tag_list)

      if @youtube_channel_id.present?
        @vtuber.save_youtube_information(@vtuber.id, @youtube_channel_id)
        @vtuber.get_profile_icon_from_youtube(@vtuber, @youtube_channel_id) if @vtuber.image.identifier.nil?
      else
        @vtuber.vtuber_youtube&.destroy
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
end

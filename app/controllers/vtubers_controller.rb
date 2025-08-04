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
    term = params[:term]
    names = Vtuber.where('name LIKE ?', "%#{term}%").pluck(:name)
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
    if @vtuber.save
      VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id).save
      tag_list = params[:vtuber][:tag].split(/[、,　 ]/)
      @vtuber.save_tags(tag_list)

      place_id = params[:vtuber][:vtuber_places_attributes]["0"][:place_id]
      if place_id == "1"
        youtube_url = params[:vtuber][:vtuber_places_attributes]["0"][:url]
        @vtuber.youtube_information(@vtuber.id, youtube_url)
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
    if latest_version == params[:vtuber][:version].to_i
      if @vtuber.update(vtuber_params)
        VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id).save
        tag_list = params[:vtuber][:tag].split(/[、,　 ]/)
        @vtuber.save_tags(tag_list)

        place_id = params[:vtuber][:vtuber_places_attributes]["0"][:place_id]
        if place_id == "1"
          youtube_url = params[:vtuber][:vtuber_places_attributes]["0"][:url]
          @vtuber.youtube_information(@vtuber.id, youtube_url)
        end

        @vtuber.notification_update(current_user)
        @vtuber.update(version: @vtuber.version + 1)

        flash[:success] = "VTuberを更新しました"
        redirect_to vtuber_path(@vtuber)
      else
        flash.now[:danger] = "VTuberを更新できませんでした"
        render :edit
      end
    else
      flash[:danger] = "他の人が先にプロフィールを更新しましたので、内容を確認して再編集してください。"
      redirect_to vtuber_path(@vtuber)
    end
  end

  private

  def vtuber_params
    params.require(:vtuber).permit(:name, :affiliation, :name_x, :gender, :birthday, :debut_date, :like, :unlike, :image, vtuber_places_attributes: [:place_id, :url, :_destroy, :id], content_ids: [])
  end
end

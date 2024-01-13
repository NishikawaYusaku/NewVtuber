class VtubersController < ApplicationController
  before_action :require_login, except: %i[index]
  
  def index

  end

  def name_input
    @vtuber = Vtuber.find_by(name: params[:name])

    if @vtuber
      
    else
      redirect_to action: 'new', name: params[:name]
    end
  end

  def new
    @vtuber = Vtuber.new(name: params[:name])
  end

  def create
    @vtuber = current_user.vtubers.new(vtuber_params)
    @vtuber_user = VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id)
    @vtuber_place = VtuberPlace.new(vtuber_id: @vtuber.id, place_id: params[:vtuber][:place_ids], url: params[:vtuber][:url])

    if @vtuber.save && @vtuber_user.save && @vtuber_place.save
      redirect_to root_path
      flash[:success] = "ユーザーを登録しました"
    else
      flash.now[:danger] = "ユーザーを登録できませんでした"
      render :new
    end
  end

  private

  def vtuber_params
    params.require(:vtuber).permit( :name, :image, :debut_date, :fan_name, :like, :unlike, :gender, :name_x, content_ids: [] )
  end
end
# , place_ids: [], url: [] 
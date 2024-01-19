class VtubersController < ApplicationController
  before_action :require_login, except: %i[index show]
  
  def index
    @vtuber = Vtuber.all.order(:id).page(params[:page]).per(20)
  end

  def show
    @vtuber = Vtuber.find(params[:id])
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
  end

  def create
    @vtuber = current_user.vtubers.new(vtuber_params)
    @vtuber_user = VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id)
    @vtuber_place = VtuberPlace.new(vtuber_id: @vtuber.id, place_id: params[:vtuber][:place_ids], url: params[:vtuber][:url])

    if @vtuber.save && @vtuber_user.save && @vtuber_place.save
      redirect_to show_path(@vtuber)
      flash[:success] = "Vtuberを登録しました"
    else
      flash.now[:danger] = "Vtuberを登録できませんでした"
      render :new
    end
  end

  def edit
    @vtuber = Vtuber.find_by(id: params[:id])
  end

  def update
    @vtuber = Vtuber.find(params[:id])
    @vtuber_user = VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id)
    @vtuber_place = VtuberPlace.find_by(url: params[:vtuber][:url])

    if @vtuber_place
      @vtuber_place.update(vtuber_id: current_user.id, place_id: params[:vtuber][:place_ids], url: params[:vtuber][:url])
    end

    if @vtuber.update(vtuber_params) && @vtuber_user.save
      redirect_to show_path(@vtuber)
      flash[:success] = "Vtuberを更新しました"
    else
      flash.now[:danger] = "Vtuberを更新できませんでした"
      render :edit
    end
  end

  private

  def vtuber_params
    params.require(:vtuber).permit( :name, :image, :debut_date, :fan_name, :like, :unlike, :gender, :name_x, content_ids: [] )
  end
end
# if  @vtuber_place.update
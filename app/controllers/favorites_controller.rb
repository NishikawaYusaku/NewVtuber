class FavoritesController < ApplicationController
  before_action :set_vtuber
  
  def create
    @favorite = Favorite.new(user_id: current_user.id, vtuber_id: @vtuber.id)
    @favorite.save
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, vtuber_id: @vtuber.id)
    @favorite.destroy
  end

  private

  def set_vtuber
    @vtuber = Vtuber.find(params[:id])
  end
end

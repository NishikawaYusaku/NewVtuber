class FavoritesController < ApplicationController
  before_action :set_vtuber, only: %i[create destroy_vtuber]

  def create
    @favorite = Favorite.new(user_id: current_user.id, vtuber_id: @vtuber.id)
    @favorite.save
  end

  def destroy_vtuber
    @favorite = Favorite.find_by(user_id: current_user.id, vtuber_id: @vtuber.id)
    @favorite.destroy
  end

  def destroy_user
    @destroy_vtuber = Vtuber.find(params[:format])
    @favorite = Favorite.find_by(user_id: current_user.id, vtuber_id: @destroy_vtuber.id)
    @favorites_vtuber = current_user.favorite_vtubers.order("favorites.id DESC")
    @favorite.destroy
  end

  private

  def set_vtuber
    @vtuber = Vtuber.find(params[:vtuber_id])
  end
end

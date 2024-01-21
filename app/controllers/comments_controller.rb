class CommentsController < ApplicationController
  def create
    @vtuber = Vtuber.find(params[:id])
    @comment = Comment.new(comment_params)
    @comment.save
  end

  def destroy
    @vtuber = Vtuber.find(params[:id])
    @comment = Comment.find(params[:format])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id, vtuber_id: @vtuber.id)
  end
end

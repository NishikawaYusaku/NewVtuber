class CommentsController < ApplicationController
  def create
    @vtuber = Vtuber.find(params[:id])
    @comment = Comment.new(comment_params)
    @comment.save
  end

  def destroy
    # <i class="fa-thin fa-trash-can" style="color: #ff0000;"></i>
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id, vtuber_id: @vtuber.id)
  end
end

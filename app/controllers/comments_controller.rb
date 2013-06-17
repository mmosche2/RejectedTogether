class CommentsController < ApplicationController

	def create
		@user = User.find(params[:user_id])
    answer_id = params[:answer_id]
    @comment = Comment.create(body: params[:body], answer_id: answer_id, user_id: @user.id)
    redirect_to user_path(@user)
  end
 
  def destroy
    @user = User.find(params[:user_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to user_path(@user)
  end

end

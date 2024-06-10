class CommentsController < ApplicationController
  def create
    # 新しいコメントを作成し、それを変数に格納
    @comment = Comment.new(comment_params)
    if @comment.save
      # 作成したコメントのプロトタイプIDを使ってリダイレクト
      redirect_to prototype_path(@comment.prototype.id)
    else
      @prototype = Prototype.find(params[:prototype_id])
      @comments = @prototype.comments
      render 'prototypes/show', status: :unprocessable_entity

    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
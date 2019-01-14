class LikemicropostsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.register_to_likes(@micropost)
    flash[:success] = 'メッセージをお気に入りに追加しました。'
    redirect_to current_user
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    current_user.unregister_from_likes(@micropost)
    flash[:success] = 'メッセージをお気に入りから削除しました。'
    redirect_to current_user
  end
end

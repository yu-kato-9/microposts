class ToppagesController < ApplicationController
  def index
    if logged_in?
      @micropost = current_user.microposts.build # form_for用
      @microposts = current_user.microposts.order('created_at DESC').page(params[:page]) # 一覧用
    end
  end
end

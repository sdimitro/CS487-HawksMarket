class InterestPostsController < ApplicationController
  before_action :set_post
  
  def create
    if Interest.create(interested: @post, user: current_user)
      redirect_to @post, notice: 'Post has been added to Wishlist. The Seller will be notified soon!'
    else
      redirect_to @post, alert: 'Something went wrong...*sad panda*'
    end
  end
  
  def destroy
    Interest.where(interested_id: @post.id, user_id: current_user.id).first.destroy
    redirect_to @post, notice: 'Post is no longer in your Wishlist'
  end
  
  private
  
  def set_post
    @post = Post.friendly.find(params[:post_id] || params[:id])
  end
end

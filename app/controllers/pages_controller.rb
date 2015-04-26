class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
  end

  def inside
    @wishlist_posts = []
    wishlist = Interest.where(user_id: current_user)
    wishlist.each do |t|
     @wishlist_posts << Post.friendly.find(t.interested_id)
    end
	
    @posts = Post.friendly.where(user_id: current_user)
  end
  
  def posts
    if params[:tag]
      @posts = Post.published.tagged_with(params[:tag]).page(params[:page]).per(10)
    elsif params[:search]
      @posts = Post.published.search(params[:search]).page(params[:page]).per(10)
    else
      @posts = Post.published.page(params[:page]).per(10)
    end
  end
  
  def show_post
    @post = Post.friendly.find(params[:id])
  rescue
    redirect_to root_path
  end

  
  def email
    @email = current_user.email
    @item = params[:item]
    @message = params[:message]
    
    if @item.blank?
      flash[:alert] = "Please enter the name or description of the relevant item. Thank you."
      render :contact
    elsif @message.blank? || @message.length < 10
      flash[:alert] = "Your message is empty. Requires at least 10 characters. Nothing to send."
      render :contact
    elsif @message.scan(/<a href=/).size > 0 || @message.scan(/\[url=/).size > 0 || @message.scan(/\[link=/).size > 0 || @message.scan(/http:\/\//).size > 0
      flash[:alert] = "You can't send links. Thank you for your understanding."
      render :contact
    else    
      ContactMailer.contact_message(@email,@item,@message).deliver_now
      redirect_to root_path, notice: "Your message was sent. Thank you."
    end
  end

end

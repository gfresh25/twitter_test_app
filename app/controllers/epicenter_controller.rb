class EpicenterController < ApplicationController
	before_action :authenticate_user!
	
  include TweetsHelper

  def feed
    @tweet = Tweet.new
  	@following_tweets =[]

  	Tweet.all.each do |tweet|
      if current_user.following.include?(tweet.user_id) || current_user.id == tweet.user_id
        @following_tweets.push(tweet)
      end
    end		
  end
  

  def show_user

  	@user = User.find(params[:id])  
    if current_user.id == @user.id
      @tweet = Tweet.new
    end 
  end

  def all_users
    @users = User.all
  end

  def now_following
  	
  	current_user.following.push(params[:id].to_i)
  	current_user.save

  	redirect_to show_user_path(id: params[:id].to_i)
  end

  def unfollow
  	current_user.following.delete(params[:id].to_i)
	  current_user.save

	  redirect_to show_user_path(id: params[:id])  	
  end


  def following
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if @user.following.include? user.id
        @users.push(user)
      end
    end
  end
  
  def followers
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if user.following.include? @user.id
        @users.push(user)
      end
    end
  end





  def epi_tweet
    @tweet = Tweet.create(message: params[:tweet][:message], user_id: params[:tweet][:user_id].to_i)

    @tweet = get_tagged(@tweet)
    @tweet.save

    redirect_to root_path
  end  

  def tag_tweets
    @tag = Tag.find(params[:id])
  end

end

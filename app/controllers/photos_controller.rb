class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @photos = flickr_user.photos
  end

  private

  def flickr
    @flickr ||= Flickr.new(ENV['FLICKR_KEY'])
  end

  def flickr_user
    @flickr_user ||= flickr.users(user.flickr_username)
  end

  def user
    @user ||= current_user
  end
end

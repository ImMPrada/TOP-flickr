class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @photos = flickr_user.photos if user_has_flickr_service?
  end

  private

  def flickr
    @flickr ||= Flickr.new(ENV['FLICKR_KEY'])
  end

  def flickr_user
    @flickr_user ||= flickr.users(@user.flickr_username)
  end

  def user_has_flickr_service?
    @user.flickr_username.present?
  end
end

# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  def flickr
    user = User.find_from_flickr_oauth(auth)
    return no_user_found unless user.present?


  end

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  private

  def auth
    @auth ||= request.env['omniauth.auth']
  end

  def no_user_found
    flash[:alert] = "no user found for #{auth.info.nickname} flickr user did you link your profile with your flickr?"
    redirect_to new_user_session_path
  end
end

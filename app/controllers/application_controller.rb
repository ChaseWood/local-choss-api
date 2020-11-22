class ApplicationController < ActionController::Base
    #prevents rails from using its authenticity token. This is disabled so taht we dont receive forbidden parameters that will prevent our controller actions from executing without errors.
    skip_before_action :verify_authenticity_token

    #This code is making sure that all the methods defined below are passed to all the other controllers in the app.
    helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!

    def login!
        session[:user_id] = @user.id
    end

    def logged_in?
        !!session[:user_id]
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def authorized_user?
        @user == current_user
    end

    def logout!
        session.clear
    end







end

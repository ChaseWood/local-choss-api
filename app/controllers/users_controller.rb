class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    if @users
      render json: @users.to_json(include: :climbs)
    else
      render json: {
        status: 500,
        errors: ['no users found']
      }
    end
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
    if @user
      render json: @user.to_json(include: :climbs)
    else
      render json: {
        status: 500,
        errors: ['user not found']
      }
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      login!
      render json: {
        status: :created,
        user: @user
      }
    else
      render json: {
        status: 500,
        errors: @user.errors.full_messages
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end


# 15 Dynamic Finders
# For every field (also known as an attribute) you define in your table, Active Record provides a finder method. If you have a field called first_name on your Client model for example, you get find_by_first_name for free from Active Record. If you have a locked field on the Client model, you also get find_by_locked method.

# You can specify an exclamation point (!) on the end of the dynamic finders to get them to raise an ActiveRecord::RecordNotFound error if they do not return any records, like Client.find_by_name!("Ryan")

# If you want to find both by name and locked, you can chain these finders together by simply typing "and" between the fields. For example, Client.find_by_first_name_and_locked("Ryan", true).

# https://guides.rubyonrails.org/active_record_querying.html

# 18.1 find_or_create_by
# The find_or_create_by method checks whether a record with the specified attributes exists. If it doesn't, then create is called. Let's see an example.

# Suppose you want to find a client named 'Andy', and if there's none, create one. You can do so by running:

# Client.find_or_create_by(first_name: 'Andy')
# # => #<Client id: 1, first_name: "Andy", orders_count: 0, locked: true, created_at: "2011-08-30 06:09:27", updated_at: "2011-08-30 06:09:27">

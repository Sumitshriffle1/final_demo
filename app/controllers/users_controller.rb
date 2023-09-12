class UsersController < ApplicationController
  before_action :authenticate_request, except: [:create, :user_login]

  # ..................Create User......................
  def create
    user = User.new(set_params)
    if user.save
      render json: { message:"User Created"}
    else
      render json: { errors: user.errors.full_messages },status: :unprocessable_entity
    end
  end

  # ..................Login user......................
  def user_login
    if user=User.find_by(email: params[:email], password_digest: params[:password_digest])
      token= jwt_encode(user_id: user.id)
      render json: { message: "Logged In Successfully..", token: token }
    else
      render json: { error: "Please Check your Email And Password....." },status: :unprocessable_entity
    end
  end

  #-------------------Update user-----------------------
  def update
    if @current_user.update(set_params)
      render json: { message: 'User updated successfully...'}
    else
      render json: { errors: @current_user.errors.full_messages },status: :unprocessable_entity
    end
  end

  #-------------------Delete user------------------------
  def destroy
    if @current_user.destroy
      render json: { message: 'User deleted' }
    else
      render json: { errors: @current_user.errors.full_messages },status: :unprocessable_entity
    end
  end

  # ..................Show user......................
  def show
    user = @current_user
    if user.present?
      render json: user
    else
      render json: "User not found", status: :not_found
    end
  end

  #-------------------Search_by_user_name--------------
  def search_user_by_name
    if params[:name].present?
      users = User.where("name like '%#{params[:name].strip}%'")
      if users.empty?
        render json: { message: 'No data found...' }, status: :not_found
      else
        render json: users
      end
    else
      render json: { message: 'No record found...' }, status: :not_found
    end
  end

  private
  def set_params
    params.permit(:name,:email,:password_digest,:contact,:type)
  end
end

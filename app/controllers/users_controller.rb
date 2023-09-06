class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create, :user_login]
  #------------------Show All Users---------------------
  def index
    if @current_user.type=="JobRecruiter"
      user = User.all
      if user.present?
        render json: user
      else
        render json: { message: "No Users exists" }
      end
    else
      render json: { message: "You cant see all users"}
    end
  end

  # ..................Create User......................
  def create
    user = User.new(set_params)
    if user.save
      render json: { message:"User Created"}
    else
      render json: { errors: user.errors.full_messages }
    end
  end

  # ..................Login user......................
  def user_login
    if user=User.find_by(email: params[:email], password_digest: params[:password_digest])
      token= jwt_encode(user_id: user.id)
      render json: { message: "Logged In Successfully..", token: token }
    else
      render json: { error: "Please Check your Email And Password....." }
    end
  end

  def update
    if @current_user.update(user_params)
      render json: { message: 'User updated', data: @current_user}
    else
      render json: { errors: @current_user.errors.full_messages }
    end
  end

  def destroy
    if @current_user.destroy
      render json: { message: 'User deleted' }
    else
      render json: { errors: @current_user.errors.full_messages }
    end
  end

  # ..................Show user......................
  def show
    user = User.find_by_id(params[:id])
    if user.present?
      render json: user
    else
      render json: "user not found"
    end
  end

  private
  def set_params
    params.permit(:name,:email,:password_digest,:contact,:type)
  end
end

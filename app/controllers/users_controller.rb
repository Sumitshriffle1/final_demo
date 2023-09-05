class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create, :user_login]

  #------------------Show All Users---------------------
  def index
    user = User.all
    if user.present?
      render json: user
    else
      render json: { message: "No Users exists" }
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

  # ..................Update user......................
  # def update
  #   user = User.find(@current_user.id)
  #   if user.update(set_params)
  #     render json: { message: 'Updated successfully......', data: user }
  #   else
  #     render json: { errors: user.errors.full_messages }
  #   end
  # end

  # # ..................Destroy user......................
  # def destroy
  #   user=User.destroy(@current_user.id)
  #   render json: { message: 'Deleted successfully', data: user }
  # end

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
    render json: @current_user
  end

  private
  def set_params
    params.permit(:name,:email,:password_digest,:contact,:type)
  end
end

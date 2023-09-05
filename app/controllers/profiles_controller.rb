class ProfilesController < ApplicationController
  before_action :check_for_existing_profile, only: [:create]
  # before_action :set_profile, only: [:update, :destroy, :show]

  # def index
  #   profile = Profile.all
  #   if profile.present?
  #     render json: profile
  #   else
  #     render json: { message: "No profile exists" }
  #   end
  # end

  def create
    profile = @current_user.create_profile(profile_params)
    if profile.save
      render json: profile
    else
      render json: { errors: profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # def update
  #   profile = @current_user.update_profile(user_params)
  #   if profile.update
  #     render json: { message: "Updated Successfully",data:@profile }
  #   else
  #     render json: { errors: profile.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   profile = @current_user.destroy_profile(user_params)
  #   if profile.destroy
  #     render json: { message: 'Deleted successfully' }
  #   else
  #     render json: { message: 'Failed to delete the program' }
  #   end
  # end

  def update
    profile = @current_user.profile
    if profile.update(profile_params)
      render json: { message: 'User Profile updated', data: @current_user}
    else
      render json: { errors: @current_user.profile.errors.full_messages}
    end
  end

  def destroy
    profile = @current_user.profile
    if profile.destroy
      render json: { message: 'User Profile deleted'}
    else
      render json: { errors: @current_user.profile.errors.full_messages }
    end
  end

  def show
    render json: @current_user.profile
  end

  private

  # def set_profile
  #   @profile = Profile.find_by_id(params[:id])
  #   unless @profile
  #     render json: {error: 'Profile not found'}, status: :not_found
  #   end
  # end

  def profile_params
    params.permit(:skills, :education, :experience)
  end

  def check_for_existing_profile
    if @current_user.user_profile
      render json: 'Some message about already having a profile'
    end
  end

end

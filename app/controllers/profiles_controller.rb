class ProfilesController < ApplicationController
  before_action :check_for_existing_profile, only: [:create]

  #-------------------Create_profile-----------------------
  def create
    profile = @current_user.create_profile(profile_params)
    if profile.save
      render json: profile
    else
      render json: { errors: profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #-------------------Update_profile-----------------------
  def update
    profile = @current_user.profile
    if profile.update(profile_params)
      render json: { message: 'User Profile updated....'}
    else
      render json: { errors: @current_user.profile.errors.full_messages},status: :unprocessable_entity
    end
  end

  #-------------------Delete_profile----------------------
  def destroy
    profile = @current_user.profile
    if profile.destroy
      render json: { message: 'User Profile deleted'}
    else
      render json: { errors: @current_user.profile.errors.full_messages },status: :unprocessable_entity
    end
  end

  #-------------------Show_profile-----------------------
  def show
    profile = @current_user.profile
    if profile.present?
      render json: profile
    else
      render json: 'sorry profile not found..', status: :not_found
    end
  end

  private

  def profile_params
    params.permit(:skills, :education, :experience,:image)
  end

  def check_for_existing_profile
    if @current_user.profile
      render json: 'Some message about already having a profile'
    end
  end
end

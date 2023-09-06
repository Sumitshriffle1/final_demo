class JobRecruitersController < ApplicationController
  before_action :only_recruiter_has_access

  def index
    # if @current_user.type=="JobRecruiter"
      user = User.all
      if user.present?
        render json: user
      else
        render json: { message: "No Users exists" }
      end
    # else
      # render json: { message: "You cant see all users"}
    # end
  end

  def view_all_apply
    apply = Apply.all
    if apply.present?
      render json: apply
    else
      render json: "No apply exists"
    end
  end

  def reject_apply
    apply = @current_user.applies
    if apply.update(status: 'rejected')
      render json: apply,status: :ok
    else
      render json: apply.errors, status: :unprocessable_entity
    end
  end

  def find_by_id
    apply = Apply.find_by_id(params[:id])
    if apply.present?
      render json: apply
    else
      render json: "Id not found"
    end
  end

  def view_rejected_apply
    rejected_apply = Apply.where(status: 'rejected')
    if reject_apply.present?
      render json: rejected_apply, status: :ok
    else
      render json: "No rejected applies"
    end
  end

  def view_accepted_apply
    accepted_apply = Apply.where(status: 'accepted')
    if accepted_apply.present?
      render json: accepted_apply, status: :ok
    else
      render json: "No accepted applies"
    end
  end
end

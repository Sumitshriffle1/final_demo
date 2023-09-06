class AppliesController < ApplicationController
  before_action :job_recruiter_access,except: [:create,:destroy,:show]
  before_action :job_seeker_can_apply,only:[:create,:destroy,:show]

  # def index
  #   view_apply = Apply.all
  #   render json: view_apply, status: :ok
  # end

  def create
    apply = @current_user.applies.new(apply_params)
    if apply
      apply.status = 'Pending..'

      if apply.save
        render json: apply, status: :ok
      else
        render json: { error: apply.errors.full_messages }
      end
    else
      render json: { message: 'Id not found' }
    end
  end

  def update
    apply = @current_user.applies
    if apply.update(status: 'accepted')
      render json: apply, status: :ok
    else
      render json: apply.errors, status: :unprocessable_entity
    end
  end

  def destroy
    apply = @current_user.applies
    if apply.destroy
      render json: { message: 'Apply deleted...'}
    else
      render json: { errors: apply.errors.full_messages }
    end
  end

  def show
    render json: @current_user.applies
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
    render json: rejected_apply, status: :ok
  end

  def view_accepted_apply
    accepted_apply = Apply.where(status: 'accepted')
    render json: accepted_apply, status: :ok
  end

  private
  def apply_params
    params.permit(:job_id,:resume)
  end

  def job_recruiter_access
    unless @current_user.type == "JobRecruiter"
      render json: "You do not have access...."
    end
  end

  def job_seeker_can_apply
    unless @current_user.type == "JobSeeker"
      render json: "only JobSeeker can apply for this job...."
    end
  end
end

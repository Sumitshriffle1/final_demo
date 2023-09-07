class JobRecruitersController < ApplicationController
  before_action :only_recruiter_has_access
  before_action :set_param, only: [:update]

  #-----------------Show_all_users------------
  def index
    user = User.all
    if user.present?
      render json: user
    else
      render json: { message: "No Users exists" }
    end
  end

  #--------------------Update_applies---------------
  def update
    if @current_user==@apply.job.user
      if @apply.update(recruiter_params)
        render json: {message: "Application Updated",data: @apply}
      else
        render json: { message: @apply.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: "You have not permission to accept and reject the job",status: :unauthorized
    end
  end

  #---------------------view_all_apllied_jobs------------
  def view_applied_jobs
    begin
      job= Apply.all
      if job.present?
        render json: job
      else
        render json: "Nobody apply for job"
      end
    rescue
      render json: "Job Not Found", status: :not_found
    end
  end

  #----------------show_perticular_applied_job---------
  def show
    begin
      job= @current_user.jobs.find(params[:id])
      applied_job = job.applies
      unless applied_job.empty?
        render json: applied_job
      else
        render json: "Nobody apply for job"
      end
    rescue
      render json: "Job Not Found", status: :not_found
    end

  end

  #---------------view_all_rejected_jobs--------------
  def view_rejected_apply
    rejected_apply = Apply.where(status: 'rejected')
    if rejected_apply.present?
      render json: rejected_apply, status: :ok
    else
      render json: "No rejected applies"
    end
  end

  #---------------view_all_accepted_jobs---------------
  def view_accepted_apply
    accepted_apply = Apply.where(status: 'accepted')
    if accepted_apply.present?
      render json: accepted_apply, status: :ok
    else
      render json: "No accepted applies"
    end
  end

  private
  def recruiter_params
    params.permit(:status)
  end

  def set_param
    begin
      @apply= Apply.find(params[:id])
    rescue
      render json: "apply not Found", status: :not_found
    end
  end
end

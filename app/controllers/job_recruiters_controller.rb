class JobRecruitersController < ApplicationController
  before_action :only_recruiter_has_access
  before_action :set_param, only: [:update]

  #-----------------Show_all_users------------
  def index
    users = User.all
    if users.present?
      render json: users
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
    jobs= Apply.all
    if jobs.present?
      render json: jobs
    else
      render json: "Nobody apply for job"
    end
  end

  #----------------show_perticular_applied_job---------
  def show
    begin
      job= @current_user.jobs.find(params[:id])
      applied_jobs = job.applies
      unless applied_jobs.empty?
        render json: applied_jobs
      else
        render json: "Nobody apply for job"
      end
    rescue
      render json: "Job Not Found", status: :not_found
    end

  end

  #---------------view_all_rejected_jobs--------------
  def view_rejected_apply
    rejected_applies = Apply.where(status: 'rejected')
    if rejected_applies.present?
      render json: rejected_applies, status: :ok
    else
      render json: "No rejected applies"
    end
  end

  #---------------view_all_accepted_jobs---------------
  def view_accepted_apply
    accepted_applies = Apply.where(status: 'accepted')
    if accepted_applies.present?
      render json: accepted_applies, status: :ok
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

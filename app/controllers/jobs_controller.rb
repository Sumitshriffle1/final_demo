class JobsController < ApplicationController
  before_action :set_job, only: [:show, :update, :destroy]
  before_action :only_recruiter_has_access,only: [:create,:update,:destroy]

  def index
    job = Job.all
    if job.present?
      render json: job
    else
      render json: { message: "No Jobs Available"}
    end
  end

  def create
    job = @current_user.jobs.new(job_params)
    if job.save
      render json: { message: "Job Created",data:job}
    else
      render json: { errors: job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    job = @current_user.jobs
    if job.update(job_params)
      render json: { message: 'User Profile updated', data:job}
    else
      render json: { errors: apply.errors.full_messages}
    end
  end

  def destroy
    job = @current_user.jobs
    if job.destroy
      render json: { message: 'Deleted successfully' }
    else
      render json: { message: 'Failed to delete the job' }
    end
  end

  def show
    render json: @job
  end

  def search_by_name
    if params[:job_title].present?
      job = Job.where("job_title like '%#{params[:job_title].strip}%'")
      if job.empty?
        render json: { message: 'No data found...' }
      else
        render json: job
      end
    else
      render json: { message: 'No record found...' }
    end
  end

  def search_by_company_name
    if params[:company_name].present?
      job = Job.where("company_name like '%#{params[:company_name].strip}%'")
      if job.empty?
        render json: { message: 'No data found...' }
      else
        render json: job
      end
    else
      render json: { message: 'No record found...' }
    end
  end

  def search_by_category
    if params[:job_category].present?
      job = Job.where("job_category like '%#{params[:job_category].strip}%'")
      if job.empty?
        render json: { message: 'No data found...' }
      else
        render json: job
      end
    else
      render json: { message: 'No record found...' }
    end
  end

  private

  def set_job
    @job = Job.find_by_id(params[:id])
    unless @job
      render json: {error: 'Job not found'}, status: :not_found
    end
  end

  def job_params
    params.permit(:job_title,:company_name,:job_category,:job_description,:location,:salary,:post)
  end

  def only_recruiter_has_access
    unless @current_user.type == "JobRecruiter"
      render json: "You do not have access...."
    end
  end
end

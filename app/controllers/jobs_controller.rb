class JobsController < ApplicationController
  before_action :set_job, only: [:show, :update, :destroy]
  before_action :only_recruiter_has_access,only: [:create,:update,:destroy]

  #--------------Show all jobs---------------------
  def index
    job = Job.all
    if job.present?
      render json: job
    else
      render json: { message: "No Jobs Available"}
    end
  end

  #----------------Create jobs-----------------------
  def create
    job = @current_user.jobs.new(job_params)
    if job.save
      render json: { message: "Job Created",data:job}
    else
      render json: { errors: job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #------------------Update jobs---------------------
  def update
    if @current_user==@job.user
      if @job.update(job_params)
        render json: {message: "Updated successfully..."}
      else
        render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: "You have not permission to update job",status: :unauthorized
    end
  end

  #-----------------Delete jobs-----------------------
  def destroy
    if @current_user==@job.user
      if @job.destroy
        render json: { message: 'Job deleted...'}
      else
        render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: "You have not permission to delete job",status: :unauthorized
    end
  end

  #------------------show pertcular job-----------------
  def show
    render json: @job
  end

  #------------------search_jobs_by_job_title------------------
  def search_by_job_title
    if params[:job_title].present?
      job = Job.where("job_title like '%#{params[:job_title].strip}%'")
      if job.empty?
        render json: { message: 'No data found...' }, status: :not_found
      else
        render json: job
      end
    else
      render json: { message: 'No record found...' }, status: :not_found
    end
  end

  #-------------------search_jobs_by_company_name-------------
  def search_by_company_name
    if params[:company_name].present?
      job = Job.where("company_name like '%#{params[:company_name].strip}%'")
      if job.empty?
        render json: { message: 'No data found...' }, status: :not_found
      else
        render json: job
      end
    else
      render json: { message: 'No record found...' }, status: :not_found
    end
  end

  #-------------------search_jobs_by_category-----------------
  def search_by_category
    if params[:job_category].present?
      job = Job.where("job_category like '%#{params[:job_category].strip}%'")
      if job.empty?
        render json: { message: 'No data found...' }, status: :not_found
      else
        render json: job
      end
    else
      render json: { message: 'No record found...' }, status: :not_found
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
end

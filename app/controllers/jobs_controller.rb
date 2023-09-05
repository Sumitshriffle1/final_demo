class JobsController < ApplicationController
  before_action :set_job, only: [:show, :update, :destroy]

  def index
    job = Job.all
    if job.present?
      render json: job
    else
      render json: { message: "No Jobs Available"}
    end
  end

  def create
    job = @current_user.jobs.new(user_params)
    if job.save
      render json: { message: "Job Created",data:job}
    else
      render json: { errors: job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @job.update(user_params)
      render json: { message: "Updated Successfully",data:@job}
    else
      render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @job.destroy
      render json: { message: 'Deleted successfully' }
    else
      render json: { message: 'Failed to delete the job' }
    end
  end

  def show
    render json: @job
  end


  private

  def set_job
    @job = Job.find_by_id(params[:id])
    unless @job
      render json: {error: 'Job not found'}, status: :not_found
    end
  end

  def user_params
    params.permit(:job_title,:company_name,:job_category,:job_description,:location,:salary,:post)
  end
end

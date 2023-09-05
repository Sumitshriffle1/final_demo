class AppliesController < ApplicationController

  def create
    apply = @current_user.applies.new(apply_params)
    if apply.save
      render json: { message: "Apply successfull..",data:apply}
    else
      render json: { errors: apply.errors.full_messages },status: :unprocessable_entity
    end
  end

  def update
    apply = @current_user.apply
    if apply.update(apply_params)
      render json: { message: 'User Profile updated', data:apply}
    else
      render json: { errors: apply.errors.full_messages}
    end
  end

  def destroy
    apply = @current_user.apply
    if apply.destroy
      render json: { message: 'User Profile deleted'}
    else
      render json: { errors: apply.errors.full_messages }
    end
  end

  def show
    render json: @current_user.apply
  end
  

  private
  def apply_params
    params.permit(:resume)
  end 
end



# def accept_application
#   application = JobApplication.find(params[:application_id])
#   if application.update(status: 'accepted')
#     render json: application, status: :ok
#   else
#     render json: application.errors, status: :unprocessable_entity
#   end
# end
# def reject_application
#   application = JobApplication.find(params[:application_id])
#   if application.update(status: 'rejected')
#     render json: application, status: :ok
#   else
#     render json: application.errors, status: :unprocessable_entity
#   end
# end
# def view_applications
#   @job_recruiter_applications = @job_recruiter.job_applications
#   render json: @job_recruiter_applications, status: :ok
# end
# def view_approved_applications
#   @job_recruiter_approved_applications = @job_recruiter.job_applications.where(status: 'accepted')
#   render json: @job_recruiter_approved_applications, status: :ok
# end
# def view_rejected_applications
#   @job_recruiter_rejected_applications = @job_recruiter.job_applications.where(status: 'rejected')
#   render json: @job_recruiter_rejected_applications, status: :ok
# end

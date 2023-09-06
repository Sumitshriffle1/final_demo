class ApplicationController < ActionController::Base
  include JsonWebToken

	before_action :authenticate_request

  # ...................Authenticate User..................
  def authenticate_request
    begin
      header = request.headers['Authorization']
      header = header.split(" ").last if header
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue JWT::DecodeError => e
      render json: { error: 'Invalid token' }, status: :unprocessable_entity
    rescue ActiveRecord::RecordNotFound
      render json: "No record found.."
    end
  end

  # ..............Check user.....................
	def current_user
		@current_user
	end

  def only_recruiter_has_access
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

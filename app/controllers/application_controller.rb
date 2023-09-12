class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  include ActiveStorage::SetCurrent
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end
  include JsonWebToken

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

  #-----------------JobRecruiter access--------------
  def only_recruiter_has_access
    unless @current_user.type == "JobRecruiter"
      render json: "You do not have access...."
    end
  end

  #------------------Check url---------------------
  def invalid_url
    render json: { error: "Invalid URL" }, status: :not_found
  end
end

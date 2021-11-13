class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::BadRequest, with: :bad_request_error

  # Render exceptions errors
  def record_not_found(exception)
    render json: {message: exception.message}, status: :not_found
    return
  end

  def bad_request_error(exception)
    render json: {error: exception.message}, status: :bad_request
    return
  end
end

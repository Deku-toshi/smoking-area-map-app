class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  
  private

  def render_not_found
    render json: {
      error: {
        code:  "not_found",
        message: "Smoking area not found."
      },
      request_id: request.request_id
    }, status: :not_found
  end
end

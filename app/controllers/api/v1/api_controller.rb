class Api::V1::ApiController < ActionController::API
  def index
    render json: {
      data: Course.last(2)
    }
  end
end

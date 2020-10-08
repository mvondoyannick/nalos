class Api::V1::ApiController < ApplicationController #ActionController::API
  def index
    render json: {
      data: Course.find(146).exclude().as_json
    }
  end
end

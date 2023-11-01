class Api::V1::SpinGachaController < ApplicationController
  def index
    result = FetchWaitTimeService.new().execute
    render json: result
  end
end

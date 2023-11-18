class Api::V1::SpinGachaController < ApplicationController
  def index
    param = params[:park]
    result = FetchWaitTimeService.new(park: param).execute
    render json: result
  end

end

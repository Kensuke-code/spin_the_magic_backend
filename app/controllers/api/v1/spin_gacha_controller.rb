class Api::V1::SpinGachaController < ApplicationController
  def index
    param = params[:park]
    Rails.logger.info("------------param-----------")
    Rails.logger.info(param)
    Rails.logger.info("------------param-----------")
    result = FetchWaitTimeService.new(park: param).execute
    render json: result
  end

end

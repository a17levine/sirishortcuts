class TeslaController < ApplicationController
  
  timeout 30
  iam_policy "lambda"
  def start_hvac
    TeslaHvacJob.perform_later(:start_hvac)
    render json: { status: 'hvac started' } and return
  end
  
  timeout 30
  iam_policy "lambda"
  def stop_hvac
    TeslaHvacJob.perform_later(:stop_hvac)
    render json: { status: 'hvac stopped' } and return
  end
end

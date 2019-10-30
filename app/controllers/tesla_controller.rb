class TeslaController < ApplicationController
  
  timeout 30
  def start_hvac
    TeslaHvacJob.perform_later(:start_hvac)
    render json: { status: 'hvac started' } and return
  end
  
  def stop_hvac
    TeslaHvacJob.perform_later(:stop_hvac)
    render json: { status: 'hvac stopped' } and return
  end
end

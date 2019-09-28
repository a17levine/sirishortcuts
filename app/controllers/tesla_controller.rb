class TeslaController < ApplicationController
  def start_hvac
    client = Slack::Web::Client.new
    begin
      tesla_api = TeslaApi::Client.new(
        email: ENV["tesla_email_address"], 
        client_id: ENV["tesla_api_client_id"], 
        client_secret: ENV["tesla_api_client_secret"]
      )
      tesla_api.login!(ENV["tesla_password"])
      model_3 = tesla_api.vehicles.first
      model_3.wake_up
      model_3.auto_conditioning_start unless model_3.climate_state["is_auto_conditioning_on"]
  
      client.chat_postMessage(channel: '#alex-scripting-log', text: 'Tesla HVAC started', as_user: true)
      render json: { status: 'hvac started' }
    rescue => e
      client.chat_postMessage(channel: '#alex-scripting-log', text: "Tesla HVAC script failed: #{e.inspect} #{e.backtrace.join("\n")}", as_user: true)
      render json: { status: 'hvac script failed' }
    end
  end

  def stop_hvac
    client = Slack::Web::Client.new
    begin
      tesla_api = TeslaApi::Client.new(
        email: ENV["tesla_email_address"], 
        client_id: ENV["tesla_api_client_id"], 
        client_secret: ENV["tesla_api_client_secret"]
      )
      tesla_api.login!(ENV["tesla_password"])
      model_3 = tesla_api.vehicles.first
      model_3.wake_up
      model_3.auto_conditioning_stop unless model_3.climate_state["is_auto_conditioning_off"]
  
      client.chat_postMessage(channel: '#alex-scripting-log', text: 'Tesla HVAC stopped', as_user: true)
      render json: { status: 'hvac stopped' }
    rescue => e
      client.chat_postMessage(channel: '#alex-scripting-log', text: "Tesla HVAC script failed: #{e.inspect} #{e.backtrace.join("\n")}", as_user: true)
      render json: { status: 'hvac script failed' }
    end
  end
end
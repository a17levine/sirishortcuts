class TeslaHvacJob < ApplicationJob
  class_timeout 30


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
      
      15.times {
        puts "model3 state is #{model_3['state']}"
        if model_3['state'] == 'online'
          puts "turning on car"
          model_3.auto_conditioning_start unless model_3.climate_state["is_auto_conditioning_on"]
          # client.chat_postMessage(channel: '#alex-scripting-log', text: 'Tesla HVAC started', as_user: true)
          return
        else
          puts "sleeping"
          sleep 2
          # Refresh the vehicle state
          model_3 = tesla_api.vehicles.first
        end
      }
      # If we're not in this loop, the car didn't wake up after several attempts
      throw 'Car did not wake up after several attempts'
    rescue => e
      client.chat_postMessage(channel: '#alex-scripting-log', text: "Tesla HVAC script failed: #{e.inspect} #{e.backtrace.join("\n")}", as_user: true)
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
      return
    rescue => e
      client.chat_postMessage(channel: '#alex-scripting-log', text: "Tesla HVAC script failed: #{e.inspect} #{e.backtrace.join("\n")}", as_user: true)
      return
    end
  end
end

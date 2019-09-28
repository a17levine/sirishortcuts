class TeslaController < ApplicationController
  def start_hvac
    # tesla_api = TeslaApi::Client.new(
    #   email: ENV["tesla_email_address"], 
    #   client_id: '81527cff06843c8634fdc09e8ac0abefb46ac849f38fe1e431c2ef2106796384', 
    #   client_secret: 'c7257eb71a564034f9419ee651c7d0e5f7aa6bfbd18bafb5c5c033b093bb2fa3'
    # )
    # result = tesla_api.login!(ENV["tesla_password"])
    # access_token = res['access_token']
    # model_3 = tesla_api.vehicles.first # => <TeslaApi::Vehicle>
    # model_3.wake_up
    # model_3.auto_conditioning_start unless model_3.climate_state["is_auto_conditioning_on"]

    client = Slack::Web::Client.new
    client.chat_postMessage(channel: '#alex-scripting-log', text: 'Hello World', as_user: true)
    render json: {status: 'hvac started'}
  end
end

class TeslaController < ApplicationController
  def start_hvac
    render json: {hello: "world", action: "index"}
  end
end

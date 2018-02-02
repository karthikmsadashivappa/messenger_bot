class CallbackController < ApplicationController
  def index
  	if params["hub.verify_token"] == "asd"
  		render json: params["hub.challenge"]
  	end
  end

  def recieved_data
  end
end


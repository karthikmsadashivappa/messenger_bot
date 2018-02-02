class CallbackController < ApplicationController
 protect_from_forgery with: :null_session

  def index
    if params["hub.verify_token"] == "asd"
      render json: params["hub.challenge"]
    end
  end

  def recieved_data
    therequest = request.body.read
    data = JSON.parse(therequest)
    parse_data(data)
    render "recieved_data"
  end

  def parse_data(data)
    enteries = data["entry"]
    enteries.each do |entry|
      entry["messaging"].each do |messaging|
        sender = messaging["sender"]["id"]
        text = messaging["message"]["text"]
        analysis(sender, text.downcase)
      end
    end
  end

  def analysis(sender, text)
    message = Message.where(:recieved => text).first
    if message
      reply = message.reply
    else
      reply = "Sorry not found"
    end
      send_message(sender, reply)
  end

  def send_message(sender, text)
    myjson = {"recipient": {"id": "#{sender}"},"message": {"text": "#{text}"}}
    puts HTTP.post(url, json: myjson)
  end


  def url 
    "https://graph.facebook.com/v2.6/me/messages?access_token=EAACXKi9DHWIBAKZCeR9CSdbjUap1Bec53bFdBzZB48eq1iQDMKPmMH3UCvBpRuiH6AZA32ZC1ZAgq3zkRPOVK7ZCXJggsqr3kJRSnnlAZBHjbx7BQ2j4atStKJK6N0B9Tkp5U9gYYMAUZBni3hMFoRowhqYKFometSTwMYGaxRZBsFzPBfViHGVin"
  end
end


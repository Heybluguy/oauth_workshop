class SessionsController < ApplicationController
  def create
    client_id     = YOUR_CLIENT_ID
    client_secret = YOUR_CLIENT_SECRET
    code          = params[:code]
    response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")
  end
end
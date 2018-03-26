class SessionsController < ApplicationController
  def create
    client_id     = YOUR_CLIENT_ID
    client_secret = YOUR_CLIENT_SECRET
    code          = params[:code]
    response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

    pairs = response.body.split("&")
    response_hash = {}
    pairs.each do |pair|
      key, value = pair.split("=")
      response_hash[key] = value
    end

    token = response_hash["token"]

    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

    auth = JSON.parse(oauth_response.body)

    user          = User.find_or_create_by(uid: auth["id"])
    user.username = auth["login"]
    user.uid      = auth["id"]
    user.token    = token
    user.save

    session[:user_id] = user.id

    redirect_to dashboard_path

  end
end
require 'sinatra/base'
require 'opentok'

if !ENV.has_key?("TB_API_KEY") || !ENV.has_key?("TB_API_SECRET")
  raise "You must define TB_API_KEY and TB_API_SECRET environment variables"
end

class TBDemo < Sinatra::Base

  set :api_key, ENV['TB_API_KEY']
  set :opentok, OpenTok::OpenTok.new(api_key, ENV['TB_API_SECRET'])
  set :session, opentok.create_session

  get '/' do

    api_key = settings.api_key
    session_id = settings.session.session_id
    token = settings.opentok.generate_token(session_id)

    erb :index, :locals => {
      :api_key => api_key,
      :session_id => session_id,
      :token => token
    }
  end
end

require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class TagLouisiana < OAuth2
      # change the class name and the :name option to match your application name
      option :name, :taglouisiana

      option :client_options, {
          :site => "http://localhost:4000",
          :authorize_url => "/oauth/authorize"
      }

      uid do
        raw_info["id"]
      end

      info do
        {
            :email => raw_info["email"],
            :first_name => raw_info["first_name"],
            :last_name => raw_info["last_name"],
            :name => raw_info["name"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
        puts "Raw info: " << @raw_info.to_json
        @raw_info
      end
    end
  end
end

OmniAuth.config.add_camelization 'taglouisiana', 'TagLouisiana'

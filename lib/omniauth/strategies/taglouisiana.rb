require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class TagLouisiana < OmniAuth::Strategies::OAuth2
      # change the class name and the :name option to match your application name
      option :name, :doorkeeper

      option :client_options, {
          :site => "https://moby.taglouisiana.com",
          :authorize_url => "/oauth/authorize"
      }

      uid { raw_info["id"] }

      info do
        {
            :email => raw_info["email"],
            :first_name => raw_info["first_name"],
            :last_name => raw_info["last_name"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end
    end
  end
end

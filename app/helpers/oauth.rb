module OAuth

  module Helpers

    def user_id
      user_info['resource_owner_id'] || ()
    end

    def user_info
      token_string = find_token_string()
      error! 'missing access token', 400 if token_string.nil?        
      
      token_info = get_token_info(token_string)
      error! 'failed to get token info', 500 if token_info.nil?

      invalid_scope = !validate_token?(token_info)
      error! 'invalid scope', 400 if invalid_scope
      
      return token_info

      # user_info = get_user_info(token_string)
      # error! 'failed to get user info from personnel api', 500 if user_info.nil?

      # return { token: token_info, user: user_info }
    end


    def find_token_string
      Rack::Auth::AbstractRequest::AUTHORIZATION_KEYS.each do |key|
        if env.key?(key) && extracted_token = env[key][/^Bearer (.*)/, 1]
          return extracted_token
        end
      end
      params[:access_token]
    end


    def get_token_info token_string
      begin
        response = get Config[:oauth_token_url], {authorization: "Bearer #{token_string}"}
        return JSON.parse response.body if response.code == 200
      rescue
        nil
      end
    end


    def validate_token? token_info
      Config[:scopes].each do |scope|
        return false if !token_info['scopes'].include? scope
      end
      true
    end
    

    def get_user_info token_string
      begin
        response = get Config[:personnel_info_url], {authorization: "Bearer #{token_string}"}
        return JSON.parse response.body if response.code == 200
      rescue
        nil
      end
    end


    def get url, headers
      RestClient::Request.execute(url: url, headers: headers, method: :get, verify_ssl: true)
    end

  end

end

module API
  module ApiHelper
    def warden
      env['warden']
    end

    def session
      env['rack.session']
    end

    def authenticated
      return true if warden.authenticated?

      headers['Access-Token'] && (@user = User.find_by_authentication_token(headers['Access-Token']))
    end

    def authenticated_admin
      authenticated && @user.admin?
    end

    def current_user
      warden.user || @user
    end
  end
end

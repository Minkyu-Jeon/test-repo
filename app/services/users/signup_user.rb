module Users
  class SignupUser
    def initialize(params)
      @email = params[:email]
      @password = params[:password]
    end

    def call

    end
  end
end
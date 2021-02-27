module Users
  class SignupUser
    def initialize(params)
      @email = params[:email]
      @password = params[:password]
    end

    def call
      user = User.new(email: @email, password: @password)

      user.save or raise InvalidParameterError.new(user.errors.messages)
      
      { user: user.as_json(only: [:id, :email, :created_at, :updated_at]) }
    end
  end
end
class InvalidParameterError < ApplicationError
  CODE = 1

  attr_reader :errors

  def initialize(errors)
    @errors = errors
    super
  end
end
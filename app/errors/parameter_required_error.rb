class ParameterRequiredError < ApplicationError
  def initialize(absence_params)
    super(absence_params.to_sentence + " 는 필수 파라미터입니다.")
  end
end
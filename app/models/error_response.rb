class ErrorResponse < Response
  attr_accessor :error

  def initialize(error)
    @error = error
    @success = false
  end

end

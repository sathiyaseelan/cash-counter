class FailureResponse < Response
  attr_accessor :messages, :error_code

  def initialize(messages, error_code = nil)
    @messages = messages
    @success = false
    #@object = nil
    @error_code = error_code
  end

end

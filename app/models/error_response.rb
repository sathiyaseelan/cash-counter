class ErrorResponse < Response
  attr_accessor :messages

  def initialize(messages)
    @messages = messages
    @success = false
    #@object = nil
  end

end

class FailureResponseSerializer < ActiveModel::Serializer
  attributes :success, :messages
  self.root = false


  def messages
    messages = []
    object.messages.each do |key,value_arr|
      [value_arr].flatten.each { |value| messages << "#{key}:#{value}" }
    end
    messages
  end
end

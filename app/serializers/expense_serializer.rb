class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :description, :amount, :paid_on, :paid_by_id, :paid_by, :categories



  def categories
    object.categories.map do |category|
      CategorySerializer.new(category)
    end
  end

end

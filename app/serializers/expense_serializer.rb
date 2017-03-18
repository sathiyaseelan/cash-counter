class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :description, :amount, :paid_on, :paid_by_id, :paid_by

  def paid_by
    Member.find_by(id: object.paid_by_id).user.full_name
  end

end

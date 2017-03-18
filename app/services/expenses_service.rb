class ExpensesService < ApplicationService

  def create_expense_for_group(group_id: , paid_on: , paid_by_id:, description:, amount:, categories:)
    @expense = Expense.new(group_id: group_id, paid_on: paid_on, paid_by_id: paid_by_id, description: description, amount: amount)
    if @expense.valid?
      @expense.transaction do
        if @expense.save!
          @expense.categories << expense_categories(group_id: group_id, categories: categories)
          return Response.new(@expense, success: true)
        else
          return FailureResponse.new(@expense.errors)
        end
      end
    else
      return FailureResponse.new(@expense.errors)
    end
  end

  def expense_categories(group_id:, categories:)
    categories = []
    Category.transaction do
      categories.each do |category_name|
        categories << Category.find_or_create_by!(name: category_name, group_id: group_id)
      end
    end
    categories
  end
end

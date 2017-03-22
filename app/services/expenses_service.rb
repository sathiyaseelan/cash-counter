class ExpensesService < ApplicationService

  def create_expense_for_group(group_id: , paid_on: , paid_by_id:, description:, amount:, categories:)
    @expense = Expense.new(group_id: group_id, paid_on: paid_on, paid_by_id: paid_by_id, description: description, amount: amount)
    if @expense.valid?
      @expense.transaction do
        if @expense.save!
          @expense.categories << expense_categories(group_id: group_id, category_names: categories)
          return Response.new(@expense, success: true)
        else
          return FailureResponse.new(@expense.errors)
        end
      end
    else
      return FailureResponse.new(@expense.errors)
    end
  end

  def get_expenses_for_group(group_id:)
    @group = Group.find_by(id: group_id)
    if @group
      @expenses = @group.expenses
      return Response.new(@expenses, success: true)
    else
      return FailureResponse.new(['Can not find the group with given id'])
    end
  end

  def get_expenses_for_user(user_id:)
    @user = User.find_by(id: user_id)
    if @user
      @expenses = @user.expenses
      return Response.new(@expenses, success: true)
    else
      return FailureResponse.new(['Can not find the user with given id'])
    end
  end

  private

  def expense_categories(group_id:, category_names:)
    categories = []
    Category.transaction do
      category_names.each do |category_name|
        categories << Category.find_or_create_by!(name: category_name, group_id: group_id)
      end
    end
    categories
  end
end

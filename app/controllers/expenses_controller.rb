class ExpensesController < ApplicationController
  def create
    response = ExpensesService.new.create_expense_for_group(expense_params)
    if response.success?
      render json: response, status: :created
    else
      render json: response, status: :unprocessable_entity
    end
    rescue Exception => e
      render json: ErrorResponse.new(e.message), status: :internal_server_error
  end


  private

  def expense_params
    output = convert_keys_to_symbols  params.require(:expense).permit(:amount, :description, :paid_on, :paid_by_id, :categories => []).to_h
    output.merge!(group_id: params[:group_id])
    output
  end
end

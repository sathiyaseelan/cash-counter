class UsersService < ApplicationService

  def create_user(user_params)
    @user = User.new(user_params)
    byebug
    if @user.valid? && @user.save
      return Response.new(@user, success: true)
    else
      return ErrorResponse.new(@user.errors)
    end
  end

end

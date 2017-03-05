class MembersService < ApplicationService

  # Either user_id or user_email is required
  def create_member(group_id:, user_id: nil, user_email: nil, role: :member)
    @group = Group.find_by(id: group_id)
    if @group.nil?
      return FailureResponse.new(['Can not find the group with given id'])
    else
      if !user_id.nil?
        @user = User.find_by(id: user_id)
        if @user.nil?
          return FailureResponse.new(['Can not find the user with given id'])
        else
          @member = Member.new(group: @group, user: @user, role: role)
          if @member.valid? && @member.save
            return Response.new(@member, success: true)
          else
            return FailureResponse.new(@member.errors.full_messages)
          end
        end
      else
        # To send mail to the new user
        send_join_to_group_mail(user_email, @group)
        return Response.new(['Mail sent to the user'], success: true)
      end
    end
  end


end

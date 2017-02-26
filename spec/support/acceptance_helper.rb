module AcceptanceHelper

  def generate_token(user)
    login_params = {user: {email: user.email, password: user.password} }
    header = {"CONTENT_TYPE" => "application/json"}
    client.post "/api/v1/user/signin", login_params.to_json, header
    JSON.parse(response_body)['token']
  end


  def generate_token_and_set_header(user)
    token = nil
    no_doc do
      token = generate_token user
    end
    header "Authorization", "Bearer #{token}"
  end
end

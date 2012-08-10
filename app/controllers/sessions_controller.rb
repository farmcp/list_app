class SessionsController < ApplicationController
  #GET the page that will create a new session
  def new
    #on initial visit, check if there is a current user and if so redirect to their profile
    if current_user
      redirect_to current_user
    end
  end

  #POST the information that will create the new session and drop teh cookie
  def create
    #if the email and password exist in the database then drop a cookie - downcase the email since all the emails are lowercased
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = "Invalid Username or Password combination"
      render 'new'
    end
  end

  #DELETE the cookie and kill the session
  def destroy
    sign_out
    redirect_to new_session_path
  end

  def facebook
    begin
      auth = request.env['omniauth.auth']
      p auth.to_yaml
      user = User.find_by_provider_and_fb_id(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
      sign_in user
      redirect_back_or user
    rescue 
      flash.now[:error] = "Something went wrong with the authentication."
      render 'new'
    end
      
  end

end

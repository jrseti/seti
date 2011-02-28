class SessionsController < ApplicationController
  
  
  # Create a new session, based on third party oauth authentication. Then redirect to air_login_complete if using air, other
  def create
    auth = request.env["omniauth.auth"]
    session[:token] = auth["credentials"]["token"]
    session[:provider] = auth["provider"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    puts "----- LOGIN: " + user.name + "(" + user.id.to_s + ") via " + request.env['HTTP_USER_AGENT']
    session[:user_id] = user.id
    user_agent = request.env['HTTP_USER_AGENT']
    if (user_agent.match('AdobeAIR') || user_agent.match('Android')) && can? (:explore, :all)
      redirect_to "/air_active?_session_id=" +  request.session_options[:id]
    else 
      redirect_to root_url, :notice => "Signed in"
    end
  end
  
  # This is where we return nothing, so the AIR application knows we're done with authentication
  
  def air_active
    render :air_active
  end
  
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out"
  end
end

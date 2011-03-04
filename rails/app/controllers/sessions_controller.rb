class SessionsController < ApplicationController
    
  # Create a new session, based on third party oauth authentication. Then redirect to air_login_complete if using air, other
  def create
    auth = request.env["omniauth.auth"]
    puts auth.to_yaml
    session[:token] = auth["credentials"]["token"]
    session[:provider] = auth["provider"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    puts "----- LOGIN: " + user.name + "(" + user.id.to_s + ") via " + request.env['HTTP_USER_AGENT']
    session[:user_id] = user.id
    user_agent = request.env['HTTP_USER_AGENT']
    if (user_agent.match('AdobeAIR') || user_agent.match('Android')) && can?(:explore, :all)
      redirect_to "/air_active?_session_id=" +  request.session_options[:id]
    else 
      redirect_to root_url, :notice => "Signed in"
    end
  end
  
  # This is where we return nothing, so the AIR application knows we're done with authentication
  
  def air_active
    render :air_active
  end


   
 def index
   authorize! :manage, Session
   @sessions = Session.page(params[:page])
   respond_to do |format|
     format.html
     format.xml  { render :xml => @sessions }
   end
 end
  
  def destroy
    authorize! :manage, Session
    @session = Session.find(params[:id])
    @session.destroy

    respond_to do |format|
      format.html { redirect_to(sessions_url) }
      format.xml  { head :ok }
    end
  end

  def logout
    session.destroy
    redirect_to root_url, :notice => "Logged out"
  end
end

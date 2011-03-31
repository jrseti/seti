# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#

class SessionsController < ApplicationController

  # Cross-Site Forgery protection is not enabled on Session Controller (protect_from_forgery)
  # The AIR app does its own cookie management, and isn't handling the hidden form elements correctly during Google OpenID authentication.

    
  # Create a new session, based on third party oauth authentication. Then redirect to air_login_complete if using air, other
  def create
    auth = request.env["omniauth.auth"]
    puts auth.to_yaml
    if auth["credentials"]
      session[:token] = auth["credentials"]["token"]
    end
    session[:provider] = auth["provider"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth, request.env['HTTP_USER_AGENT'])
    puts "----- LOGIN: " + user.name + "(" + user.id.to_s + ") via " + request.env['HTTP_USER_AGENT']
    session[:user_id] = user.id
    user_agent = request.env['HTTP_USER_AGENT']
    # We can't tell AIR for Android (via StageWebView) from Android browser -- ugh!
    if user_agent.match('AdobeAIR') || user_agent.match('Android')
      puts "------- SESSION OPTIONS -------"
      puts request.session_options.to_yaml
      puts "-----------------------"
      redirect_to "/air_active?_session_id=" +  request.session_options[:id]
    else
      redirect_to root_url
    end
  end
  
  # This is where we return nothing, so the AIR application knows we're done with authentication
  
  def air_active
    render "static/home"
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

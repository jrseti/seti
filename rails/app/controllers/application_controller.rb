class ApplicationController < ActionController::Base

  #Disable Cross-Site Request Forgery protection at the application level.
  #The AIR app does its own cookie management, and isn't handling the hidden form elements correctly during Google OpenID authentication.
  #protect_from_forgery

  # See http://mattmccray.com/archive/2007/02/19/Sorta_Nested_Layouts/
  def sub_layout
    if can? :admin, :all
      "admin" 
    else
      "explore"
    end
  end
  
  
  helper_method :current_user
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  

  # Redirect user to the correct domain
  # This seems like it belongs in the view rather than the controller

  before_filter :check_uri
  def check_uri
    host = request.host_with_port.downcase
    if host.match('explorer.setiquest.org')
      if host == 'explorer.setiquest.org'
        host = 'live.seti.hg94.com'
      else  
        host['explorer.setiquest.org'] = 'seti.hg94.com'
      end
      redirect_to request.protocol + host
    end
  end
  

  
  # Setting different layouts for mobile vs. personal computer.
  # Seems like this should be in the view, not the controller.
  # Got it here: http://guides.rubyonrails.org/layouts_and_rendering.html
  
  layout :device_layout
  private
    def device_layout
      user_agent = request.env['HTTP_USER_AGENT']
      if (user_agent.match('iPhone') || user_agent.match('iPad') || user_agent.match('iPod') || user_agent.match('Android'))
        return "mobile"
      else
        return "computer"
      end
    end
  
  
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { render :file => "public/401.html", :status => :unauthorized }
      format.xml  { render :xml => "<error>Unauthorized: #{exception.message}</error>", :status => :unauthorized  }
    end
  end
end

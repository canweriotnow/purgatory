class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable
  
  def github
    @user = User.find_for_github_oauth(request.env["omniauth.auth"], current_user)
    
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
      sign_in_and_redirect @user, :event => :authentication
      remember_me(@user)
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_session_url
    end
  end
  
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # Or alternatively,
    # raise ActionController::RoutingError.new('Not Found')
  end
  
end
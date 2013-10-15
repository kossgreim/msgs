class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :get_count_of_unread_messages

  before_filter :set_last_request_at, if: :user_signed_in?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end


  def set_last_request_at
     current_user.update_attribute(:last_request_at, Time.now) 
  end
  
  def get_count_of_unread_messages
      user_con = User.find(current_user).user_conversations
      cnt = 0
      for con in user_con 
        result = Message.where(conversation_id: con.conversation_id, read: false).where("user_id <> ?", current_user[:id]).count
        cnt += result 
        con.update_attributes(deleted: false) if con.deleted? 
        con.update_attributes read: false  if result != 0
      end
      cnt == 0 ? '' : cnt
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up){ |u| u.permit(:name, :user_name, :avatar, :email, :password) }
    devise_parameter_sanitizer.for(:account_update){ |u| u.permit(:name, :bio, :user_name, :avatar, :email, :password, :current_password, :roles) }
  end

  def not_found
  	respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

end

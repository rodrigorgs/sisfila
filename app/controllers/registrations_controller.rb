class RegistrationsController < Devise::RegistrationsController

  before_action :redirect_to_root, only: [:new, :create]
  
  protected

  def redirect_to_root
    redirect_to root_path
  end

  # def one_user_registered?
  #   if User.count == 1
  #     if user_signed_in?
  #       redirect_to root_path
  #     else
  #       redirect_to new_user_session_path
  #     end
  #   end  
  # end

end

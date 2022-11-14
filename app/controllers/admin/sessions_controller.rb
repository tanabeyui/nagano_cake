class Admin::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    admin_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end



end

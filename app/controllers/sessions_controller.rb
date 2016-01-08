class SessionsController < Devise::SessionsController
  def create
    super
  end
  

  def destroy
    current_user.update_attributes(status:false)
    super
  end
end

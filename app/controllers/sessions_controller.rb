class SessionsController < Devise::SessionsController
  def create
    @new_user=current_user
    PrivatePub.publish_to "/users/new", user:@new_user
    super
  end



  def destroy
      super
    current_user.update_attributes(status:false)
  end
end

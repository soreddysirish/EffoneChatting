class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:new,:create]
 #before_action :authenticate_user!

  def index
    @groupmessage = Groupmessage.new

    if params[:search]
      @users = User.search(params[:search]).order("created_at Desc")
    else
      @users = User.all.order("created_at Desc")
    end
    
  #  @groupmessages = Groupmessage.all
    #binding.pry
    #  @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
    if user_signed_in?
      current_user.update_attributes(status:true)
      @users = User.online_users_list
      @onlineusers = @users-[current_user]  
      @conversations = Conversation.involving(current_user).order("created_at DESC")
     
  end
end
  
   def list_of_users
     @userslist=User.all
   end

   def show_image
    @user = current_user
    @avatar = @user.avatar_file_name
   end

   def toggle
     @user=User.find(params[:id])
   if @user.update_attributes(banned:params[:banned])
     flash[:alert]= "user is successfully banned"
     render nothing:true
   end
 end

  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end


  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to authenticated_root_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation,:avatar)
    end
end


class GroupmessagesController < ApplicationController
  before_action :set_groupmessage, only: [:show, :edit, :update, :destroy]

  # GET /groupmessages
  # GET /groupmessages.json
  def index
    #@groupmessages = Groupmessage.all
    @groupmessage  = Groupmessage.new
  end

  # GET /groupmessages/1
  # GET /groupmessages/1.json
  def show
  end

  # GET /groupmessages/new
  def new
    @groupmessage = Groupmessage.new
  end

  # GET /groupmessages/1/edit
  def edit
  end

  # POST /groupmessages
  # POST /groupmessages.json
  def create
    #@groupmessage = Groupmessage.new
    @groupmessage = Groupmessage.create(groupmessage_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy 
    @groupmessage = Groupmessage.find(params[:id])
    @groupmessage.destroy
    @allgroupmessages = Groupmessage.all
    @allgroupmessages.destroy
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_groupmessage
      @groupmessage = Groupmessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def groupmessage_params
      params.require(:groupmessage).permit(:text).merge(user_id:current_user.id)
    end
end

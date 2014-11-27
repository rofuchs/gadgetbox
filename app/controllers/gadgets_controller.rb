class GadgetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_user = current_user
    @gadgets = []
    @gadgets = current_user.gadgets !params[:name]

    if params[:name]
      puts params[:name]
      if params[:name]
        @gadgets = Gadget.where("user_id = ? AND name  LIKE ? ",@current_user.id, params[:name])
      end
    end
  end

  def show
    @gadget = Gadget.find_by(id: params[:id], user_id: current_user.id)
  end

  def new
    @gadget = Gadget.new
  end

  def create
    @gadget = Gadget.new(user_id: current_user.id)
    if @gadget.update_attributes(gadget_params)
      params[:images].each do |image|
        @gadget.images.create(image: image)
    end if params[:images]
      flash[:success] = 'Saved'
      redirect_to gadgets_path
    else
      flash.now[:error] = "Failed"
      render :new
    end
  end

  def edit
    @gadget = Gadget.find_by(id: params[:id], user_id: current_user.id)
    render "_editGadget"
  end

  def update
    @gadget = Gadget.find_by(id: params[:id], user_id: current_user.id)
    if @gadget.update_attributes(gadget_params)
      upload_images
      flash[:success] = 'Updated'
      redirect_to gadgets_path
    else
      flash.now.alert = "Failed"
      render "_editGadget"
    end
  end

  def destroy
    @gadget = Gadget.find_by(id: params[:id], user_id: current_user.id)
    @gadget.destroy
    flash[:success] = 'Deleted'
    redirect_to gadgets_path
  end

private 

  def upload_images
    params[:images].each do |image|
      @gadget.images.create(image: image)
    end if params[:images]
  end

  def gadget_params
    params.require(:gadget).permit(:name, :description)
  end
end

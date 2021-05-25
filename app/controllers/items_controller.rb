class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :find_params, only: %i[show edit update destroy]
  before_action :check_user, only: %i[edit update destroy]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :prefecture_id, :fee_status_id,
                                 :days_to_ship_id, :selling_price, :image).merge(user_id: current_user.id)
  end

  def find_params
    @item = Item.find(params[:id])
  end

  def check_user
    redirect_to action: :index unless current_user == @item.user
  end
end

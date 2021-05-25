class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]

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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    find_params
    check_user
  end

  def update
    find_params
    check_user
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
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
    unless current_user == @item.user
      redirect_to action: :index
    end
  end
end

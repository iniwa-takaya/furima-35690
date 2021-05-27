class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[index create]
  before_action :find_params, only: %i[index create]
  before_action :check_user, only: %i[index create]

  def index
    @order_shipping = OrderShipping.new
  end

  def create
    @order_shipping = OrderShipping.new(order_shipping_params)
    if @order_shipping.valid?
      pay_item
      @order_shipping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_shipping_params
    params.require(:order_shipping).permit(:postal_code, :prefecture_id, :city, :address_name, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def find_params
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.selling_price,
      card: order_shipping_params[:token],
      currency: 'jpy'
    )
  end

  def check_user
    redirect_to root_path if current_user == @item.user || @item.order.present?
  end
end

class OrdersController < ApplicationController
  def new
    @order_shipping = OrderShipping.new
  end
  def create
    
  end
end

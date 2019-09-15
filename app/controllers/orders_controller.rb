class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :cart_empty, only: %i(new create)

  def index
    @orders = current_user.orders.order(create_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[id])
  end

  def new
    @order = current_user.orders.build
    @order.delivery = current_user.delivery
    @order.build_items(current_user)
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.build_items(current_user)

    if @order.save
      @order.update_user_delivery!
      current_user.cart_items.clear

      redirect_to root_path, notice: "ご注文ありがとうございます。"
    else
      render :new
    end
  end

  private
    def order_params
      params.require(:order).permit(:name, :postal_code, :address, :phone_number, :delivery_date, :delivery_time, :save_delivery)
    end

    def cart_empty
      if current_user.cart_items.empty?
        redirect_to root_path, alert: "商品をカートに追加してから購入してください"
      end
    end
end

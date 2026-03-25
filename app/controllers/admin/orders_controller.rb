class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: [:show, :update_status]

  def index
    @orders = Order.includes(:order_items, :products).order(created_at: :desc)
    @pending_count = Order.pending.count
    @confirmed_count = Order.confirmed.count
    @shipped_count = Order.shipped.count
  end

  def show
  end

  def update_status
    if @order.update(status: params[:status])
      redirect_to admin_order_path(@order), notice: "Status updated to #{@order.status_label}."
    else
      redirect_to admin_order_path(@order), alert: "Error updating status."
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end

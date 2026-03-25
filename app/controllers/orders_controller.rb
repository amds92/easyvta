class OrdersController < ApplicationController
  allow_unauthenticated_access

  def new
    @product = Product.find_by!(slug: params[:product_slug]) if params[:product_slug]
    @product ||= Product.find(params[:product_id]) if params[:product_id]
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    product = Product.find(params[:product_id])
    quantity = [params[:quantity].to_i, 1].max

    @order.order_items.build(
      product: product,
      quantity: quantity,
      unit_price_pence: product.price_pence,
      product_name: product.name
    )
    @order.total_pence = product.price_pence * quantity

    if @order.save
      OrderMailer.confirmation(@order).deliver_later
      OrderMailer.admin_notification(@order).deliver_later
      redirect_to confirmation_orders_path(reference: @order.reference), notice: "Order placed successfully!"
    else
      @product = product
      render :new, status: :unprocessable_entity
    end
  end

  def confirmation
    @order = Order.find_by!(reference: params[:reference])
  end

  private

  def order_params
    params.require(:order).permit(:customer_name, :customer_email, :customer_phone,
      :address_line1, :address_line2, :city, :postal_code, :country, :customer_notes)
  end
end

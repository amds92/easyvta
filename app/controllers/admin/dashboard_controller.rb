class Admin::DashboardController < Admin::BaseController
  def index
    @total_products = Product.count
    @in_stock_count = Product.in_stock.count
    @out_of_stock_count = Product.out_of_stock.count
    @coming_soon_count = Product.coming_soon.count
    @featured_count = Product.where(featured: true).count
    @products = Product.ordered
    @pending_orders = Order.pending.count
    @total_orders = Order.count
    @recent_orders = Order.order(created_at: :desc).limit(5)
  end
end

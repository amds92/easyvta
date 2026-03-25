class HomeController < ApplicationController
  allow_unauthenticated_access

  def index
    @products = Product.ordered
    @in_stock_products = @products.in_stock
    @out_of_stock_products = @products.out_of_stock
  end
end

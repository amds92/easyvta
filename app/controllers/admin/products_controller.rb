class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [ :show, :edit, :update, :destroy, :toggle_stock ]

  def index
    @products = Product.ordered
  end

  def show
  end

  def new
    @product = Product.new(stock_status: :in_stock, position: Product.count + 1)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: "Product created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @product.image.purge if params[:product][:remove_image] == "1"
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "Product updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "Product deleted."
  end

  def toggle_stock
    new_status = @product.in_stock? ? :out_of_stock : :in_stock
    @product.update(stock_status: new_status)
    redirect_to admin_products_path, notice: "Stock status for \"#{@product.name}\" updated."
  end

  def reorder
    params[:order].each_with_index do |id, index|
      Product.where(id: id).update_all(position: index + 1)
    end
    head :ok
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name, :slug, :tonearm_name, :description, :price_pence,
      :shaft_size, :mounting_type, :stock_status, :position,
      :featured, :image_url, :notes, :image, :remove_image
    )
  end
end

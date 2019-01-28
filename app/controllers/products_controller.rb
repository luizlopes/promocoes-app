class ProductsController < ApplicationController
  def show
    @product = Product.find params[:id]
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    redirect_to @product
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :product_key)
  end
end

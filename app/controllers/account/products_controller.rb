class Account::ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = current_user.products.all
  end

  def new
    @product = current_user.products.new
    @photo = @product.build_photo
  end

  def edit
    @product = Product.find(params[:id])

    if @product.photo.present?
      @photo = @product.photo
    else
      @photo = @product.build_photo
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to account_products_path
    else
      render :edit
    end
  end

  def create
    @product = current_user.products.new(product_params)

    if @product.save
      redirect_to account_products_path
    else
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path(@product), alert: "商品已下架"
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, photo_attributes: [:image, :id])
  end
end

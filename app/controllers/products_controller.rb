class ProductsController < ApplicationController
  def index
    @products = Product.all.includes(:supplier).page params[:page]
  end
end

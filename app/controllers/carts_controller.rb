class CartsController < ApplicationController
    
  def index
    @carts = Cart.all
    respond_with @carts
  end

  def show
    begin
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url, notice: 'Invalid cart'
    else
      respond_with @cart
    end
  end

  def new
    @cart = Cart.new
    respond_with @cart
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def create
    @cart = Cart.new(params[:cart])
    flash[:notice] = 'Cart was successfully created.' if @cart.save
    respond_with @cart
  end

  def update
    @cart = Cart.find(params[:id])
    flash[:notice] = 'Cart was successfully updated.'
    respond_with @cart
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil
    flash[:notice] = 'Your cart is currently empty'
    respond_with @cart
  end

end

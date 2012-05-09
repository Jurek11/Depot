class LineItemsController < ApplicationController
    
  def index
    @line_items = LineItem.all
    respond_with @line_items
  end

  def reset_session_counter
    session[:counter] = 0
  end
  
  def show
    @line_item = LineItem.find(params[:id])
    respond_with @line_item
  end

  def new
    @line_item = LineItem.new
    respond_with @line_item
  end

  def edit
    @line_item = LineItem.find(params[:id])
  end

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id, product.price)
    respond_to do |format|
      if @line_item.save
        reset_session_counter
        format.html { redirect_to store_url }
        format.js
        format.json { render json: @line_item,
          status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors,
          status: :unprocessable_entity }
      end
    end
  end

  def update
    @line_item = LineItem.find(params[:id])
    flash[:notice] = 'Line item was successfully updated.' if @line_item.update_attributes(params[:line_item])
    respond_with @line_item
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    respond_to do |format|
      if current_cart.line_items.empty?
        format.html { redirect_to(store_url, 
          notice: 'Your cart is empty') }
      else 
        format.html { redirect_to(@line_item.cart, 
          notice: 'Line item was successfully removed.') } 
      end
    end
  end 

end

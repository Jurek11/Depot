class AddPriceToLineItem < ActiveRecord::Migration
  def up
    add_column :line_items, :price, :decimal, precision: 8, scale: 2
    LineItem.reset_column_information
    LineItem.all.each do |line_item|
      line_item.update_attribute :price, line_item.product.price  if line_item.product
    end
  end

  def down
    remove_column :line_items, :price
  end
end
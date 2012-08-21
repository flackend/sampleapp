class AddCostandExpToProduct < ActiveRecord::Migration
  def change
    add_column :products, :cost, :integer
    add_column :products, :xp, :integer
  end
end

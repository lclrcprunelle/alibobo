class RemoveRatingFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :rating, :integer
  end
end

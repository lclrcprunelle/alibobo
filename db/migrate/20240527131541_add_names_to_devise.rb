class AddNamesToDevise < ActiveRecord::Migration[7.1]
  def change
    add_column :devises, :first_name, :string
    add_column :devises, :last_name, :string
  end
end

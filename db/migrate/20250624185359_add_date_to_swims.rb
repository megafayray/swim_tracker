class AddDateToSwims < ActiveRecord::Migration[8.0]
  def change
    add_column :swims, :date, :string
  end
end

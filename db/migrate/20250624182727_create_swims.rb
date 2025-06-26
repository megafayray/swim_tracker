class CreateSwims < ActiveRecord::Migration[8.0]
  def change
    create_table :swims do |t|
      t.string :swim_type
      t.decimal :cost

      t.timestamps
    end
  end
end

class ChangeDateColumnTypeInSwims < ActiveRecord::Migration[8.0]
  def up
    # Rename the old column to preserve the string data (optional)
    rename_column :swims, :date, :date_string

    # Add a new date column
    add_column :swims, :date, :date

    # Migrate the values
    Swim.reset_column_information
    Swim.find_each do |swim|
      begin
        swim.update_column(:date, Date.parse(swim.date_string)) if swim.date_string.present?
      rescue ArgumentError
        # Invalid date string — skip or log
      end
    end

    # Remove the old string column
    remove_column :swims, :date_string
  end

  def down
    add_column :swims, :date_string, :string
    Swim.reset_column_information
    Swim.find_each do |swim|
      swim.update_column(:date_string, swim.date.to_s) if swim.date.present?
    end
    remove_column :swims, :date
    rename_column :swims, :date_string, :date
  end
end

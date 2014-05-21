class AddPatternToUser < ActiveRecord::Migration
  def change
    add_column :users, :pattern, :text
  end
end

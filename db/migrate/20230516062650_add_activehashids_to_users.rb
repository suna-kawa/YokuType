class AddActivehashidsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :prefecture_id, :integer
    add_column :users, :age_id, :integer
    add_column :users, :gender_id, :integer
    add_column :users, :job_id, :integer
  end
end

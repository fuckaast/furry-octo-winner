class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.integer :password
      t.boolean :successful, default: false

      t.timestamps null: false
    end
  end
end

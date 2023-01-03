class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.float :price
      t.string :status, default: "active"
      t.integer :frequency
      t.references :tea, foreign_key: true

      t.timestamps
    end
  end
end

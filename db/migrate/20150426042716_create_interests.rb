class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.references :user, index: true
      t.references :interested, polymorphic: true, index: true

      t.timestamps null: false
    end
    add_foreign_key :interests, :users
  end
end

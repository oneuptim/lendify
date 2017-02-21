class CreateLenders < ActiveRecord::Migration[5.0]
  def change
    create_table :lenders do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :money

      t.timestamps
    end
  end
end

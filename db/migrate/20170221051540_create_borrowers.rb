class CreateBorrowers < ActiveRecord::Migration[5.0]
  def change
    create_table :borrowers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :reason
      t.text :explanation
      t.integer :amount

      t.timestamps
    end
  end
end

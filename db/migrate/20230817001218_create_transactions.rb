class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :crypto
      t.integer :amount_cents
      t.decimal :rate

      t.timestamps
    end
  end
end

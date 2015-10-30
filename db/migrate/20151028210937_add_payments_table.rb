class AddPaymentsTable < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :customer_email
      t.string :customer_id
      t.datetime :date_to_run
      t.integer :amount_in_cents
      t.string :for
      t.string :currency
    end
  end
end

class CreatePaymentRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_requests do |t|
      t.text :encoded_string
      t.string :token
      t.timestamps
    end
  end
end
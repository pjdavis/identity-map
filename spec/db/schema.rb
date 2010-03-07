ActiveRecord::Schema.define(:version => 0) do
  puts "Creating Schema"
  create_table :customers, :force => true do |t|
    t.string :name
  end
  create_table :phone_numbers, :force => true do |t|
    t.string :number
    t.integer :customer_id
  end
end
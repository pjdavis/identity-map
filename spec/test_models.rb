load_schema

class Customer < ActiveRecord::Base
  has_many :phone_numbers
end

customer = Customer.create(:name => "Boneman")

class PhoneNumber < ActiveRecord::Base
  belongs_to :customer
end

phone_number = customer.phone_numbers.create(:number => "8675309")
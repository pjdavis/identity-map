require File.dirname(__FILE__) + '/spec_helper'

describe "Customers" do
	
	before(:each) do
		Thread.current["identity_map"] = Cache.new
	end
	
	it "should load the same model twice" do
		c1 = Customer.first
		c2 = Customer.first
		c1.__id__.should == c2.__id__
	end
	
	it "should work for has_many associations" do
		p1 = PhoneNumber.first
		p2 = Customer.first.phone_numbers.first
		p1.__id__.should == p2.__id__
	end
	
	it "should work for belongs_to assocations" do
		d1 = Customer.first
		d2 = PhoneNumber.first.customer
		d1.__id__.should == d2.target.__id__
	end
	
	it "should work for creating objects" do
		c1 = Customer.create(:name => "billy")
		c2 = Customer.find_by_name("billy")
		c1.__id__.should == c2.__id__
	end
	
	after(:each) do
		Thread.current["identity_map"] = nil
	end
	
end
require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do 
    it 'creates a product' do 
      @category = Category.create(name: "large")
      @product = Product.create(name: "Bed", price: "1000", quantity: 100, category: @category)
      expect(@product).to be_present
  end 
  it 'validates whether the product has a name' do 
    @category = Category.create(name: "large")
    @product = Product.create(name: nil, price: "1000", quantity: 100, category: @category)
    expect(@product.errors.full_messages[0]).to eq("Name can't be blank")
    expect(@product[:name]).not_to be_present 
  end
  it 'validates whether the product has a price' do
    @category = Category.create(name: "large")
    @product = Product.create(name: "Bed", price: nil, quantity: 100, category: @category) 
    expect(@product.errors.full_messages[0]).to eq("Price cents is not a number")
    expect(@product[:price]).not_to be_present 
  end 
  it 'validates that the product has a quantity' do 
    @category = Category.create(name: "large")
    @product = Product.create(name: "Bed", price: "1000", quantity: nil, category: @category)
    expect(@product.errors.full_messages[0]).to eq("Quantity can't be blank")
    expect(@product[:quantity]).not_to be_present 
  end 
  it 'validates that the product has a category' do 
    # @category = Category.create(name: "large")
    @product = Product.create(name: "Bed", price: "1000", quantity: 100, category: nil)
    expect(@product.errors.full_messages[0]).to eq("Category can't be blank")
    expect(@product[:category]).not_to be_present 
  end 
end
end 

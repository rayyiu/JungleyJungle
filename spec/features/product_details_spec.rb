require 'rails_helper'
RSpec.feature "User navigates from home page to product detail page when they click on a product", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "User sees a product's details when they click on product card" do
    visit root_path
    
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")
    expect(page).to have_content("Quantity")
    expect(page).to have_content("Price")


    # save_screenshot
  end
end

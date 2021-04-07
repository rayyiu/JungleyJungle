require 'rails_helper'
RSpec.feature "when a user clicks 'Add to Cart' for a product, their cart increases by one", type: :feature, js: true do
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

  scenario "User clicks on add a cart and the cart increases by 1" do
    visit root_path

    expect(page).to have_content("My Cart (0)")

    click_button('Add', match: :first)

    expect(page).to have_content("My Cart (1)")

    # save_screenshot
  end


end

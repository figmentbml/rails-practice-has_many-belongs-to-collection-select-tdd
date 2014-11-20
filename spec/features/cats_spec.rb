require 'rails_helper'

feature "Cats" do
  before do
    cat = Cat.create!(
      name: "Bob"
    )
    toy = Toy.create!(
      name: "String",
      cat_id: cat.id
    )
  end

  scenario "User can see list of cat's toys on cat show page" do
    visit root_path
    click_on "Cats"
    expect(page).to have_content("Cats!")
    expect(page).to have_no_content("Toys!")
    click_on "Bob"
    expect(page).to have_content("Bob")
    expect(page).to have_content("This cat's toys are...")
    expect(page).to have_content("String")
  end


end

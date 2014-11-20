require 'rails_helper'

feature "Toys" do
  before do
    cat = Cat.create!(
      name: "Andy"
    )
    Cat.create!(
      name: "Buzz"
    )
    toy = Toy.create!(
      name: "Rope",
      cat_id: cat.id
    )
    Toy.create!(
      name: "String",
      cat_id: cat.id
    )
  end

  scenario "Toy index page should list the cat that owns each of the toys listed" do
    visit root_path
    click_on "Toys"
    expect(page).to have_content("Toys!")
    expect(page).to have_content("Andy")
    expect(page).to have_no_content("Andys")
  end

  scenario "Toy show page should list the cat that owns that toy (toys are not shared)" do
    visit toys_path
    expect(page).to have_content("Toys!")
    click_on "Rope"
    expect(page).to have_content("Rope" && "This toy belongs to...")
    expect(page).to have_content("Andy")
    expect(page).to have_no_content("Buzz")
  end

  scenario "Users can select cat from toy new page and shows on index" do
    visit toys_path
    expect(page).to have_content("Toys!")
    click_on "New Toy!"
    expect new_toy_path
    fill_in "Name", with: "Crazy ball"
    select "Andy", from: "toy_cat_id"
    click_on "Create Toy"
    expect(page).to have_content("Crazy ball")

    visit toys_path
    expect(page).to have_content("Toys!")
    click_on "New Toy!"
    expect new_toy_path
    fill_in "Name", with: "face mask"
    select "Buzz", from: "toy_cat_id"
    click_on "Create Toy"
    expect(page).to have_content("face mask")
    expect(page).to have_content("Buzz")
  end

end

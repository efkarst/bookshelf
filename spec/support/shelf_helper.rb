module ShelfHelper
  def create_new_shelf
    # fill in form to create shelf
    click_link("new_shelf")
    fill_in("shelf_name", :with => "Fiction")
    check("shelf_book_ids_1")
    click_on("Create Shelf")

    # validate shelf is created
    expect(current_path).to eq("/users/1")
    expect(page).to have_content("Fiction")
  end
  
end
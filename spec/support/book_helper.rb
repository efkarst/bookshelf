module BookHelper
  def add_book_by_search
    fill_in('searchbox-text', :with => "huckleberry finn")
    click_button('searchbox-button')
    expect(current_path).to eq("/books/search/new")
    expect(page).to have_content("Results for 'huckleberry finn'")
    click_on("SiFa-XvuQmAC")
    expect(current_path).to eq("/users/1")
    expect(page).to have_content("Adventures of Huckleberry Finn")
  end
  
end
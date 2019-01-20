module BooksHelper

  def add_or_remove_button(book)
    if !current_user_book(book)
      render 'books/form', {book: book}
    else
      form_tag("/books/#{book.id}", method: 'delete') do
        submit_tag 'Remove from My Books', class: 'button-small', id: book.identifier
      end
    end
  end

  # Returns instance of book - do i need this or can i just use method below?
  def current_user_book(book)
    current_user.books.find_by(identifier: book.identifier)
  end

  def current_user_has_read(book)
    current_user_book(book)
  end

  def unsorted_books(user)
    unsorted = []
    user.books.each do |book|
      if book.shelves.empty?
        unsorted << book 
      end 

      user.shelves.each do |shelf|
        if shelf.books.include?(book) && unsorted.include?(book)
          unsorted << book
        end
      end

    end
    
    unsorted
  end

  def current_user_finished_book(book)
    finished = UserBook.where("user_id = #{current_user.id}").where("book_id=#{book.id}").first.finished_book if current_user_book(book)
  end
end

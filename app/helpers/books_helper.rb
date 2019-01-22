module BooksHelper

  # Shows button for user to add or remove book from their collection on show and index pages
  def add_or_remove_button(book)
    if !current_user_book(book)
      render 'books/add_to_collection', {book: book}
    else
      render 'books/remove_from_collection', {book: book}
    end
  end

  def book_filters
    select "filter", "<option value=filter[order_by_title]>Order by Title</option>
                      <option value=filter[order_by_author]>Order by Author</option>
                      <option value=filter[top_rated]>Top Rated</option>".html_safe, class: 'button'
  end

  # Returns instance of book - do i need this or can i just use method below?
  def current_user_book(book)
    current_user.books.find_by(identifier: book.identifier)
  end

  def current_user_has_read(book)
    current_user_book(book)
  end

  # Returns array of current user books that aren't on a shelf
  def unsorted_books(user)
    user.books - user.shelves.collect{ |shelf| shelf.books }.flatten.uniq
  end

  def current_user_finished_book(book)
    finished = UserBook.where("user_id = #{current_user.id}").where("book_id=#{book.id}").first.finished_book if current_user_book(book)
  end
end

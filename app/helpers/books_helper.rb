module BooksHelper

  # Shows button for user to add or remove book from their collection on show and index pages
  def add_or_remove_button(book)
    if !book.id && current_user_has_book?(book)                          
      render 'books/form_remove_from_collection', {book: Book.find_by(identifier: book.identifier)}     # Remove button if search result is already in the user's collection
    elsif !book.id && !Book.find_by(identifier: book.identifier)
      render 'books/form_new_from_search', {book: book}           # Add button if book is a search results and isn't in any users collection
    elsif !current_user_has_book?(book)
      render 'books/form_add_to_collection', {book: book}         # Add button if book doesn't belong to current user but does belong to other suers
    else
      render 'books/form_remove_from_collection', {book: book}    # Remove button if book belongs to user and isn't a search result
    end
  end

  # Returns instance of book that belongs to the current user if they have the book
  def current_user_has_book?(book)
    current_user.books.find_by(identifier: book.identifier)
  end

  # Returns array of current user books that aren't on a shelf
  def unsorted_books(user)
    user.books - user.shelves.collect{ |shelf| shelf.books }.flatten.uniq
  end
 
  # return boolean if user has finishe book or not
  def current_user_finished_book(book)
    finished = UserBook.find_user_book_activity(current_user.id, book.id).finished_book if current_user_has_book?(book)
  end
end

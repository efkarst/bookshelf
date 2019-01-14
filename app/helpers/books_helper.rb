module BooksHelper

  def add_or_remove_button(book)
    if !current_user.books.find_by(identifier: book.identifier)
      render 'books/new_form', {book: book}
    else
      form_tag("/books/#{book.id}", method: 'delete') do
        submit_tag 'Remove from Collection', class: 'remove-from-collection-button'
      end
    end
  end
end

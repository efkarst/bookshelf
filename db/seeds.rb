# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

sara = User.create(name: "Sara", email: "sara@sara.omg", password: "password")

wizard = Book.create(title: "Wizard of Earthsea", pages: 200, description: "Best childrens series ever")
ursula = wizard.create_author(name: "Ursula K LeGuin")
fantasy = wizard.create_genre(name: "Fantasy")
wizard2 = Book.create(title: "Wizard of Earthsea 2", pages: 200, description: "Best childrens series ever, part 2")
wizard2.author = ursula
wizard2.genre = fantasy
wizard2.save
wizard3 = Book.create(title: "Wizard of Earthsea 3", pages: 200, description: "Best childrens series ever, part 3")
wizard3.author = ursula
wizard3.genre = fantasy
wizard3.save

bell = Book.create(title: "The Bell Jar", pages: 133, description: "Something serios")
plath = bell.create_author(name: "Sylvia Plath")
roman = bell.create_genre(name: "Roman a clef")

sara.books << wizard
sara.books << wizard2
sara.books << wizard3
sara.books << bell
sara.save

fantasy_shelf = Shelf.create(name: "Fantasy")
fantasy_shelf.books << wizard
fantasy_shelf.books << wizard2
fantasy_shelf.books << wizard3
fantasy_shelf.user = sara
fantasy_shelf.save

memoir_shelf = Shelf.create(name: "Memoir")
memoir_shelf.books << bell
memoir_shelf.user = sara
memoir_shelf.save




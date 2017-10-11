# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_data = [
  { name: 'admin', email: 'admin@example.com', admin: true, password: 'password' },
  { name: 'user', email: 'user@example.com', admin: false, password: 'password' },
]

user_data.each do |user|
  puts "Seeding user: #{user[:name]} and #{user[:email]}"
  library_user = User.create_with(password: user[:password]).
    find_or_create_by(name: user[:name], email: user[:email], admin: user[:admin])
end

book_data = [
  { title: 'The Golden Compass', author: 'Philip Pullman' },
  { title: 'The Giver', author: 'Lois Lowry' },
  { title: 'A Wrinkle in Time', author: "Madeleine L'Engle" },
  { title: 'To Kill a Mockingbird', author: 'Harper Lee' },
  { title: 'Lord of the Flies', author: 'William Golding' },
  { title: 'The Hunger Games', author: 'Suzanne Collins' },
  { title: 'The Chocolate War', author: 'Robert Cormier' },
  { title: "Are You There God? It's Me, Margaret" , author: 'Judy Blume' },
  { title: 'Harry Potter', author: 'J. K. Rowling' },
  { title: 'The Outsiders', author: 'S. E. Hinton' },
  { title: 'Sabriel', author: 'Garth Nix' },
  { title: 'Dealing with Dragons', author: 'Patricia C. Wrede' },
  { title: 'The Golden Compass', author: 'Philip Pullman' },
  { title: 'Alanna: The First Adventure', author: 'Tamora Pierce' },
  { title: 'The Hobbit', author: 'J. R. R. Tolkien' },
  { title: 'Ella Enchanted', author: 'Gail Carson Levine' },
  { title: 'Bridge to Terabithia', author: 'Katherine Paterson' },
  { title: 'Little Women', author: 'Louisa May Alcott' },
  { title: 'Inkheart', author: 'Cornelia Funke' },
  { title: 'Charlie and the Chocalate Factory', author: 'Roald Dahl' },
  { title: 'A Series of Unfortunate Events', author: 'Lemony Snicket' },
  { title: 'Artemis Fowl', author: 'Eoin Colfer' },
  { title: 'Tuck Everlasting', author: 'Natalie Babbit' },
  { title: 'Coraline', author: 'Neil Gaimen' },
  { title: 'Hatchet', author: 'Gary Paulsen' },
  { title: 'The Catcher in the Rye', author: 'J. D. Salinger' },
  { title: 'The Westing Game', author: 'Ellen Raskin' },
  { title: 'The Princess Bride', author: 'William Goldman' },
  { title: 'Where the Red Fern Grows', author: 'Wilson Rawls' },
  { title: 'Walk Two Moons', author: 'Sharon Creech' },
  { title: 'Holes', author: 'Louis Sachar' },
  { title: 'Where the Sidewalk Ends', author: 'Shel Silverstein' },
  { title: 'The True Confessions of Charlotte Doyle', author: 'Avi' },
  { title: 'Animal Farm', author: 'George Orwell' },
  { title: 'Redwall', author: 'Brian Jacques' },
]

book_data.each do |book|
  puts "Seeding book: #{book[:title]}, #{book[:author]}"
  library_book = Book.find_or_create_by(title: book[:title], author: book[:author])
end

puts "All done"

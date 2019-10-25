# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  country = Country.create!(
    name: Faker::Team.unique.state,
    capital: Faker::Nation.unique.capital_city
  )

  100.times do
    publishers = []
    publishers << Publisher.create!(name: Faker::Company.unique.name, country: country)
    publishers << Publisher.create!(name: Faker::Company.unique.name, country: country)

    user = User.create!(
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      country: country
    )

    5.times do |i|
      user.books.create!(
        title: Faker::Book.title,
        publisher_id: publishers[(1 % (i + 1)).floor].id
      )
    end
  end
end

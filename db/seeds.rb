require 'open-uri'
require 'json'


BASE_URL = 'https://fakestoreapi.com/products'
response = URI.open(BASE_URL).read
data = JSON.parse(response)

User.destroy_all
Product.destroy_all

user = User.create!(first_name: "Prunelle", last_name: "Leclerc", phone_number: "0613668429", address: "46 Amarina Avenue", email: "prunelleleclerc@gmail.com", password: "azerty")

data.each do |product|
  prod = Product.create!(
            title: product["title"],
            price: product["price"],
            category: product["category"],
            description: product["description"],
            rating: product.dig("rating", "rate"),
            user: user
          )

  file = URI.open(product["image"])
  prod.photo.attach(io: file, filename: "#{prod.title}.jpg", content_type: "image/jpg")
end

puts "Products seeded successfully."

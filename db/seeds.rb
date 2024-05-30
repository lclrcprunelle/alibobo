require 'open-uri'
require 'faker'

# BASE_URL = 'https://fakestoreapi.com/products'
# response = URI.open(BASE_URL).read
# data = JSON.parse(response)

object_names = [
  "Apple", "Book", "Chair", "Desk", "Pen", "Laptop", "Mug", "Bottle", "Lamp", "Phone",
  "Clock", "Speaker", "Remote", "Keyboard", "Mouse", "Tablet", "Notebook", "Backpack", "Wallet", "Glass",
  "Camera", "Frame", "Printer", "Router", "Shoe", "Socks", "Pillow", "Blanket", "Scissors", "Glue",
  "Brush", "Comb", "Mirror", "Hat", "Coat", "Towel", "Soap", "Shampoo", "Conditioner", "Toothbrush",
  "Toothpaste", "Razor", "Deodorant", "Perfume", "Lipstick", "Earrings", "Necklace", "Bracelet", "Ring", "Watch",
  "Gloves", "Belt", "Umbrella", "Suitcase", "Diary", "Calculator", "Stapler", "Paperclip", "Envelope", "Folder",
  "Highlighter", "Marker", "Crayon", "Ruler", "Tape", "Whiteboard", "Clipboard", "Trashcan", "Recycle bin", "File cabinet",
  "Window", "Curtain", "Blinds", "Door", "Lock", "Key", "Doormat", "Vase", "Plant", "Flowerpot",
  "Table", "Bench", "Couch", "Sofa", "Stool", "Shelf", "Bookcase", "Drawer", "Wardrobe", "Closet",
  "Bed", "Mattress", "Duvet", "Bedsheet", "Quilt", "Pillowcase", "Mirror", "Fan", "Air conditioner", "Heater",
  "Oven", "Microwave", "Refrigerator", "Freezer", "Dishwasher", "Toaster", "Blender", "Mixer", "Kettle", "Coffee maker",
  "Pan", "Pot", "Spoon", "Fork", "Knife", "Plate", "Bowl", "Cup", "Mug", "Glass",
  "Bottle", "Jar", "Can", "Tray", "Cutting board", "Napkin", "Placemat", "Apron", "Tongs", "Spatula",
  "Whisk", "Ladle", "Colander", "Peeler", "Grater", "Strainer", "Thermometer", "Timer", "Measuring cup", "Measuring spoon",
  "Recipe book", "Chopping block", "Pestle", "Mortar", "Garlic press", "Cheese grater", "Ice cube tray", "Rolling pin", "Pizza cutter", "Cork screw",
  "Wine opener", "Can opener", "Bottle opener", "Salt shaker", "Pepper grinder", "Sieve", "Wok", "Skillet", "Saucepan", "Stockpot",
  "Roasting pan", "Baking tray", "Cooling rack", "Mixing bowl", "Pastry brush", "Cookie cutter", "Cake pan", "Pie dish", "Bread box", "Oven mitt",
  "Trivet", "Cutlery tray", "Dish rack", "Drying mat", "Sink strainer", "Frying pan", "Dutch oven", "Pressure cooker", "Slow cooker", "Rice cooker",
  "Steamer", "Food processor", "Mandoline", "Griddle", "Fondue pot", "Egg timer", "Salad spinner", "Tea infuser", "Coffee grinder", "Juicer"
]

User.destroy_all
Product.destroy_all
Category.destroy_all

user_1 = User.create!(first_name: "Prunelle", last_name: "Leclerc", phone_number: "0613668429", address: "46 Amarina Avenue", email: "test@test.com", password: "azerty")
user_2 = User.create!(first_name: "John", last_name: "Leclerc", phone_number: "0613668429", address: "46 Amarina Avenue", email: "john@test.com", password: "azerty")

category_names = ["Travel", "Electronics", "Men's clothing", "Jewelery", "Women's clothing", "Sport", "Food", "Cosmetic", "Other"]

category_names.each do |category_name|
  Category.create!(name: category_name)
end

categories_mapping = {
  "men's clothing" => "Men's clothing",
  "jewelery" => "Jewelery",
  "electronics" => "Electronics",
  "women's clothing" => "Women's clothing"
}

50.times do |i|
  product = {
    "title" => object_names[i],
    "price" => Faker::Commerce.price(range: 10.0..100.0),
    "description" => Faker::Lorem.sentence(word_count: 15),
    "images" => [
      "https://source.unsplash.com/random/300x300/?#{object_names[i]}&#{rand(1..100)}",
      "https://source.unsplash.com/random/300x300/?#{object_names[i]}&#{rand(1..100)}",
      "https://source.unsplash.com/random/300x300/?#{object_names[i]}&#{rand(1..100)}"
    ],
    "category" => categories_mapping.keys.sample
  }

  category_name = product["category"]
  category = Category.find_by(name: categories_mapping[category_name])

  prod = Product.create!(
            title: product["title"],
            price: product["price"],
            description: product["description"],
            category: category,
            user: user_1
          )

  product["images"].each_with_index do |image_url, index|
    file = URI.open(image_url)
    prod.photos.attach(io: file, filename: "#{prod.title}_#{index + 1}.jpeg", content_type: "image/jpeg")
  end

  puts "product created #{prod.title}"
end

additionnal_products = [
  {
    title: "Sac de voyage",
    price: 45,
    description: "Ce sac type Duffel bag est conçu pour vous permettre de transporter vos affaires lors de vos aventures en milieu outdoor.",
    category: Category.find_by(name: "Travel"),
    user: user_1
  },
  {
    title: "Chaussures de running",
    price: 30,
    description: "Améliorée au niveau de la réactivité et du confort, la chaussure Hoka One One Mach 5 pour homme offre des qualités indispensables pour le running. Profitez de ses performances lors de vos entraînements intensifs sur routes et chemins tracés.",
    category: Category.find_by(name: "Sport"),
    user: user_1
  },
  {
    title: "Chaussures de sport",
    price: 45,
    description: "Forte d'un design audacieux et d'une fiabilité irréprochable, la chaussure On Running Cloudmonster pour homme vous accompagne lors de vos sessions de running longues distances. Pensée pour votre plaisir, elle vous apporte une excellente dose de dynamisme sur les routes et chemins tracés.",
    category: Category.find_by(name: "Sport"),
    user: user_1
  },
  {
    title: "Maquillage",
    price: 25,
    description: "La palette PINK' COLADA est inspirée d’un univers cocktail et d’un plaisir SUCRÉ auquel personne ne peut résister. Les «pink ladys»",
    category: Category.find_by(name: "Cosmetic"),
    user: user_1
  },
  {
    title: "Sac eastpack",
    price: 40,
    description: "Le sac de voyage Eastpak Terminal + 75 cm possède un grand volume de 96 L parfait pour les grandes vacances ou pour le partager avec toute la famille. Il est proposé dans différents coloris permettant de le coordonner sans difficulté avec le style d'un sac d'appoint, etc.",
    category: Category.find_by(name: "Travel"),
    user: user_1
  },
  {
    title: "Valise",
    price: 90,
    description: "Nos produits se distinguent par leur qualité exceptionnelle, leur design unique et leur finition parfaite.",
    category: Category.find_by(name: "Travel"),
    user: user_1
  }
]

additionnal_products.each do |product|
  prod = Product.create(product)

  product_image_name = "#{product[:title].downcase.gsub(" ", "_")}.jpg"
  path = Rails.root.join("app", "assets", "images", product_image_name)
  file = URI.open(path)
  prod.photos.attach(io: file, filename: "#{prod.title}.jpeg", content_type: "image/jpeg")

  puts "product created #{prod.title}"
end

puts "Products seeded successfully."

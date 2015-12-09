# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

seed_categories = [
  { name: "Wands" },
  { name: "School Supplies" },
  { name: "Dark Objects" },
  { name: "Prank Items" }
]

seed_categories.each do |seed|
  Category.create(seed)
end

seed_merchants = [
  { user_name: "Ollivanders", email: "ollie@diagonalley.com", password: "p", password_confirmation: "p" },
  { user_name: "George Weasley", email: "RIPfred@diagonalley.com", password: "p", password_confirmation: "p" },
  { user_name: "Flourish and Blotts", email: "booksandwands@diagonalley.com", password: "p", password_confirmation: "p" },
  { user_name: "Borgin and Burkes", email: "antiques@knocturnalley.com", password: "p", password_confirmation: "p" }
]

seed_merchants.each do |seed|
  Merchant.create(seed)
end

seed_order_items = [
  { product_id: 1, order_id: 1, quantity: 1 },
  { product_id: 2, order_id: 1, quantity: 1 },
  { product_id: 3, order_id: 4, quantity: 3 },
  { product_id: 4, order_id: 1, quantity: 1 }
]

seed_order_items.each do |seed|
  OrderItem.create(seed)
end

seed_orders = [
  { status: "pending", order_time: Time.now, customer_name: "Minerva McGonagall", customer_email: "miverva@hogwarts.com", customer_address: "Hogwarts Castle, UK", customer_card_last_four: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018 },
  { status: "paid", order_time: Time.now, customer_name: "Severus Snape", customer_email: "severus@hogwarts.com", customer_address: "Hogwarts Castle, UK", customer_card_last_four: 2345, customer_card_exp_month: 04, customer_card_exp_year: 2018 },
  { status: "complete", order_time: Time.now, customer_name: "Lucius Malfoy", customer_email: "iheartvoldy@dark.com", customer_address: "Malfoy Mansion, UK", customer_card_last_four: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018 },
  { status: "cancelled", order_time: Time.now, customer_name: "Molly Weasley", customer_email: "burrowbad-ass@magic.com", customer_address: "The Burrow, PS25 ILT, UK", customer_card_last_four: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018 }
]

seed_orders.each do |seed|
  Order.create(seed)
end

seed_products = [
  { name: "Wand", price: 50, merchant_id: 1, description: "Core of unicorn tail", photo_url: "http://vignette3.wikia.nocookie.net/harrypotter/images/a/ad/George_Weasley's_wand.jpg/revision/latest?cb=20110503105406", inventory: 100 },
  { name: "Cauldron", price: 50, merchant_id: 3, description: "Solid. Made in Romania ", photo_url: "http://www.madvapes.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/c/a/cauldron.jpg", inventory: 24 },
  { name: "Extendable Ears", price: 30, merchant_id: 2, description: "Sneak a listen at a distance", photo_url: "http://www.kimlawlercreative.com/wp-content/uploads/2011/06/extendable-ear.jpg", inventory: 10 },
  { name: "horcrux", price: 500000, merchant_id: 4, description: "A piece of the puzzle - the ring", photo_url: "http://ecx.images-amazon.com/images/I/41vRx1M8JTL._SY300_.jpg", inventory: 1 }
]

seed_products.each do |seed|
  Product.create(seed)
end

seed_categories_products = [
  { product_id: 1 , category_id: 1 },
  { product_id: 2 , category_id: 2 },
  { product_id: 3 , category_id: 4 },
  { product_id: 4 , category_id: 3 },
  { product_id: 1, category_id: 2 }
]

seed_categories_products.each do |seed|
  CategoriesProduct.create(seed)
end

seed_reviews = [
  { rating: 5, product_id: 1, description: "Amazing quality for the price.  Lightweight with a perfect balance for my wee little wizard's first year at Hogwart's" },
  { rating: 2, product_id: 2, description: "Horrible to clean. Spent hours scraping flobberworm mucus from the bottom" },
  { rating: 3, product_id: 3, description: "doesn't fit, emits creepy indistinct whispers" },
  { rating: 5, product_id: 4, description: "Has skyrocketed my sleuthing Slytherin skills to a stupendous state!" }
]

seed_reviews.each do |seed|
  Review.create(seed)
end

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "nokogiri"
require "cloudinary"
require "active_record"

p "Destroying previous Data"
Duck.destroy_all
User.destroy_all

category = "horror"
# url = "https://www.parisduckstore.fr/product-category/#{category}/"s
# url = "https://www.parisduckstore.fr/la-boutique/"

html_content = File.read(Rails.root.join("db", "source.html"))
# html_file = URI.open(url).read
html_doc = Nokogiri::HTML.parse(html_content)

user = User.create!(first_name: "Margarita", last_name: "Severine",
  email: "soledad@sophia.com",
  password: "coucou",
  password_confirmation: "coucou")
  p "creating user"

count = 0
html_doc.search("li.product.type-product").each do |element|
  count += 1
  description = element.at_css(".astra-shop-summary-wrap").text.strip
  title = element.at_css(".woocommerce-loop-product__title").text.strip

  price = element.at_css("woocommerce-Price-amount amount")
  test = element.at_css('.size-woocommerce_thumbnail img')
  next unless test
  images_url = test.attr("data-lazy-srcset").split(",")[0].split(" ")[0]

  file = URI.open(images_url)
  duck = Duck.new(title: title, description: description, price: price)
  duck.photo.attach(io: file, filename: "duck", content_type: "image/png")
  duck.user = user
  duck.save!
  return if Duck.count >= 50
  p "duck saved"
end

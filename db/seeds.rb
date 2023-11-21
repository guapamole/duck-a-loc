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

category = "horror"
# url = "https://www.parisduckstore.fr/product-category/#{category}/"s
url = "https://www.parisduckstore.fr/la-boutique/"
html_file = URI.open(url).read
html_doc = Nokogiri::HTML.parse(html_file)


html_doc.search("li.product.type-product").each do |element|
  image_url = element.at_css("img").values[6]
  p image_url
  description = element.at_css(".astra-shop-summary-wrap").text.strip
  title = element.at_css(".woocommerce-loop-product__title").text.strip
  p title
  price = element.at_css("woocommerce-Price-amount amount")

  uploaded_image = Cloudinary::Uploader.upload(image_url)
  # itération sur image_url pour récupérer cahque url de l'array

  file = URI.open("https://www.parisduckstore.fr/product-category/#{category}/")
  duck = Duck.new(title: title, description: description, price: price)
  duck.photo.attach(io: file, content_type: "image/png")
  duck.save
end

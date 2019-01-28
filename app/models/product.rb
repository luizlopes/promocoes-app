require 'net/http'
class Product < ApplicationRecord
  def self.sync_products
    # uri = URI(Rails.configuration.product_api['url'])
    # res = Net::HTTP.get uri
    products = JSON.parse(
      File.read(Rails.root.join('lib', 'assets', 'products.json'))
    )

    products['products'].map do |product|
      create_with(product).find_or_create_by(
        product_key: product['product_key']
      )
    end
  end
end

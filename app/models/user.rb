class User < ActiveRecord::Base
    has_many :reviews
    has_many :products, through: :reviews

    def reviews
        Review.where(user_id: self.id)
    end

    def products
        self.reviews.map do |review|
            review.product
        end
    end

    def favorite_product
        self.products.order("reviews.star_rating DESC").first
    end

    def remove_reviews(product)
        self.reviews.where(product_id: product.id).destroy_all
    end
end
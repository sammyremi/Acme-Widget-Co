class Basket
    def initialize(products:, delivery_rules:, offers: [])
        @products = products
        @delivery_rules = delivery_rules
        @offers = offers
        @items = []
    end
end
class Basket
    def initialize(products:, delivery_rules:, offers: [])
        @products = products
        @delivery_rules = delivery_rules
        @offers = offers
        @items = []
    end

    def add(product_code)
        raise "Invalid product code" unless @products.key?(product_code)
    
        @items << product_code
    end
    
    def total
        subtotal = calculate_subtotal
        discount = apply_offers
        delivery_fee = calculate_delivery_fee(subtotal - discount)
    
        final_amount = subtotal - discount + delivery_fee
        format('%.2f', final_amount).to_f
    end
    
end
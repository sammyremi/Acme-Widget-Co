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
    
    private

    def calculate_subtotal
        total = 0
        for x in @items
          total += @products[x][:price]
        end
        total
    end

    def calculate_delivery_fee(total)
        for x in @delivery_rules
          if total < x[:threshold]
            return x[:charge]
          end
        end
        return 0.0
    end

    def apply_offers
        total_discount = 0
        for offer in @offers
          total_discount += offer.call(@items, @products)
        end
        total_discount
    end

    
end
class Basket
    def initialize(products:, delivery_rules:, offers: [])
      @products = products
      @delivery_rules = delivery_rules
      @items = []
    end
  
    def add(product_code)
      raise "Invalid product code" unless @products.key?(product_code)
      @items << product_code
    end
  
    def total
      subtotal = calculate_subtotal
      discount = apply_red_widget_offer
      delivery_fee = calculate_delivery_fee(subtotal - discount)
  
      final_amount = subtotal - discount + delivery_fee
      format('%.2f', final_amount).to_f
    end
  
    private
  
    def calculate_subtotal
      total = 0
      for item in @items
        total += @products[item][:price]
      end
      total
    end
  
    def calculate_delivery_fee(total)
      for rule in @delivery_rules
        if total < rule[:threshold]
          return rule[:charge]
        end
      end
      return 0.0
    end
  
    def apply_red_widget_offer
      red_count = 0
      for item in @items
        red_count += 1 if item == "R01"
      end
  
      half_price_items = red_count / 2
      discount_per_item = @products["R01"][:price] / 2
      half_price_items * discount_per_item
    end
end
  
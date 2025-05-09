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
      0.0
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
  
  # Product catalogue
  PRODUCTS = {
    "R01" => { name: "Red Widget", price: 32.95 },
    "G01" => { name: "Green Widget", price: 24.95 },
    "B01" => { name: "Blue Widget", price: 7.95 }
  }
  
  # Delivery rules
  DELIVERY_RULES = [
    { threshold: 50.0, charge: 4.95 },
    { threshold: 90.0, charge: 2.95 }
  ]
  
  # Example usage
  puts "Example Baskets:"
  
  basket1 = Basket.new(products: PRODUCTS, delivery_rules: DELIVERY_RULES)
  basket1.add("B01")
  basket1.add("G01")
  puts "B01, G01 => $#{basket1.total}"
  
  basket2 = Basket.new(products: PRODUCTS, delivery_rules: DELIVERY_RULES)
  basket2.add("R01")
  basket2.add("R01")
  puts "R01, R01 => $#{basket2.total}"
  
  basket3 = Basket.new(products: PRODUCTS, delivery_rules: DELIVERY_RULES)
  basket3.add("R01")
  basket3.add("G01")
  puts "R01, G01 => $#{basket3.total}" 
  
  basket4 = Basket.new(products: PRODUCTS, delivery_rules: DELIVERY_RULES)
  basket4.add("B01")
  basket4.add("B01")
  basket4.add("R01")
  basket4.add("R01")
  basket4.add("R01")
  puts "B01, B01, R01, R01, R01 => $#{basket4.total}" 
  
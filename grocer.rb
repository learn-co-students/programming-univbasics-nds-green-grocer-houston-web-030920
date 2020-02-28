require "pry"

def find_item_by_name_in_collection(name, collection)
  
  counter = 0 
  while counter < collection.count do   
    if collection[counter][:item] == name
      return collection[counter]
    end
    counter += 1 
  end 
end

#------------------------------

def consolidate_cart(cart)
  consolidated_array = []
  
  consolidated_array << cart[0]
  consolidated_array[0][:count] = 1 
  cart.shift
  
  cart.each do |item_hash|
     
    if consolidated_array[0][:item] == item_hash[:item]
    consolidated_array[0][:count] += 1
    else
      item_hash[:count] = 1 
      consolidated_array << item_hash
    end
  end 
  p consolidated_array 
end

#------------------------------


def apply_coupons(cart, coupons)
  
  hash_with_coupon = {}
  
  
  
  cart.each do |item_hash| 
    coupons.each do |coupon|
      rounded_price = (coupon[:cost]/coupon[:num]).round(2)
      hash_with_coupon[:item] = "#{coupon[:item]} W/COUPONS"
      hash_with_coupon[:price] = rounded_price
      hash_with_coupon[:count] = coupon[:num]
      
      item_hash[:count] -= coupon[:num]
      hash_with_coupon[:clearance] = item_hash[:clearance]
      
    end
    
  end
  cart << hash_with_coupon
  binding.pry
end

#------------------------------

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

#------------------------------

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end

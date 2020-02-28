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
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
   
  # cart_with_coupons = consolidate_cart(cart)
  
  # cart_with_coupons.each do |item_hash|
  #   if coupons[0][:item] == item_hash[:item] && item_hash[:count] >= coupons[0][:num]
  #     coupons[0][:item] = "#{coupons[0][:item]} W/COUPONS"
  #     coupons[0][:price] = coupons[0][:cost]/coupons[0][:num]
  #     coupons[0][:clearance] = item_hash[:clearance]
  #     coupons[0][:count] = item_hash[:count]
  #     item_hash[:count] -= coupons[0][:num]
      
  #   end 
  #   
  # end 
  
  
  coupons.each do |coupon|
    item_name = coupon[:item]
    cart.each do |item|
      if item[:item] == item_name && item[:count] >= coupon[:num]
        hash_with_coupon = {}
        
        hash_with_coupon[:item] = "#{coupon[:item]} W/COUPONS"
        hash_with_coupon[:price] = coupon[:cost]/coupon[:num]
        hash_with_coupon[:clearance] = item[:clearance]
        hash_with_coupon[:count] = item[:count]
        item[:count] -= coupon[:num]
        
        binding.pry
      end 
    end
  end
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

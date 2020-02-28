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
  
  coupons.each do |coupon|
    item_in_cart = find_item_by_name_in_collection(coupon[:item], cart)
    hash_with_coupon[:item] = "#{coupon[:item]} W/COUPON"
    hash_with_coupon[:price] = (coupon[:cost]/coupon[:num]).round(2)
    
    if item_in_cart[:count] / coupon[:num] >= 1 
      hash_with_coupon[:clearance] = item_in_cart[:clearance]
      hash_with_coupon[:count] = item_in_cart[:count] - (item_in_cart[:count] % coupon[:num])
      
      cart << hash_with_coupon
      item_in_cart[:count] %= coupon[:num]
    end
  end
  cart
end

#------------------------------

def apply_clearance(cart)
  
  item_clearance = []
  
  cart.each do |item|
    if item[:clearance]
      item[:price] = item[:price] - (item[:price] * 0.20).round(2)
    end 
    item_clearance << item
  end 
  
  item_clearance
  
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
  
  
  
  consolidated_cart = consolidate_cart(cart)
  coupon_item = apply_coupons(consolidated_cart, coupons)
  clearance_item = apply_clearance(coupon_item)
  
  grand_total = 0 
  
  clearance_item.each do |item|
    item_total = (item[:price] * item[:count].round(2))
    grand_total += item_total
  end
  
  if grand_total > 100
    grand_total -= (grand_total * 0.10).round(2)
  end 
  
  grand_total
  
end

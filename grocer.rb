require 'pp'
require 'pry'

def find_item_by_name_in_collection(name, collection)
  f_hash = {}
  a_index = 0
  while a_index < collection.length do
    if collection[a_index][:item] == name
      return collection[a_index]
    end
  a_index += 1
  end
  nil
end
      
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
def consolidate_cart(cart)
  n_array = []
  b_index = 0
  while b_index < cart.length do
    n_item = find_item_by_name_in_collection(cart[b_index][:item], n_array)
    if n_item
      n_item[:count] += 1
    else
      n_item = {
        :item => cart[b_index][:item],
        :price => cart[b_index][:price],
        :clearance => cart[b_index][:clearance],
        :count => 1
      }
      n_array << n_item
    end
    b_index += 1
  end
  return n_array
end
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.

def apply_coupons(cart, coupons)
  counter = 0
  while counter < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    coupon_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(coupon_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => coupon_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end  
    counter += 1
  end
  cart
end
  
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

def apply_clearance(cart)
  counter = 0
  while counter < cart.length do
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2)
    end
    counter += 1
  end
  cart
end
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  counter = 0
  while counter < final_cart.length do
    total += final_cart[counter][:price] * final_cart[counter][:count]
    counter += 1
  end
  if total > 100
    total -= (total * 0.10)
  end
  total
end
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers

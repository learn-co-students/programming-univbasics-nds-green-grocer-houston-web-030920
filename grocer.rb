
def find_item_by_name_in_collection(name, collection)
  
  counter=0
  while counter<collection.length do
    if 
      collection[counter][:item] == name
      return collection[counter]
    end
    counter+=1
  end
end



def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  consolidated_cart = []
  index = 0 
  while index < cart.length do 
    new_cart_item = find_item_by_name_in_collection(cart[index][:item], consolidated_cart)
    if new_cart_item != nil
      new_cart_item[:count] += 1
    else
      new_cart_item = {
        :item => cart[index][:item],
        :price => cart[index][:price],
        :clearance => cart[index][:clearance],
        :count => 1 
      }
      consolidated_cart << new_cart_item
    end
    index += 1 
  end
  consolidated_cart
end


def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0 
  while index < coupons.length do 
    item_coupon_name = "#{coupons[index][:item]} W/COUPON"
    cart_item = find_item_by_name_in_collection(coupons[index][:item], cart)
    cart_item_with_coupon = find_item_by_name_in_collection(item_coupon_name, cart)
    if cart_item && cart_item[:count] >= coupons[index][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[index][:num]
        cart_item[:count] -= coupons[index][:num]
      else
        cart_item_with_coupon = {
          :item => item_coupon_name,
          :price => coupons[index][:cost] / coupons[index][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[index][:num] 
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[index][:num]
      end
    end
    index += 1 
  end 
  cart
end


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0 
  while index < cart.length do 
    if cart[index][:clearance] == true 
      cart[index][:price] *= 0.8
      cart[index][:price] = cart[index][:price].round(2)
    end
    index += 1 
  end
  cart
end

def checkout(cart, coupons)
  
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0 
  index = 0
  while index < cart.length do 
    total += (cart[index][:price] * cart[index][:count])
    index += 1 
  end
  if total > 100 
    total *= 0.9
  end
  total.round(2)
  total
end
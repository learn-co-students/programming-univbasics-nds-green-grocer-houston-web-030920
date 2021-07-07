def increment_count_of_item (cart, item_name)
  i = 0
  while i < cart.size do
    current_item = cart[i]
    if ( current_item[:item] == item_name )
      current_item[:count] += 1
    end
    i += 1
  end
  cart
end

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs

  i = 0

  while i < collection.size do
    current_item = collection[i]
    if ( current_item[:item] == name )
      return current_item
    end
    i += 1
  end
  nil

end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.

  newArr = [] 
 i = 0

  while i < cart.size do
    current_item = cart[i]
    if ( find_item_by_name_in_collection( current_item[:item], newArr ) == nil)
      current_item[:count] = 1
      newArr.push(current_item)
    else
      increment_count_of_item( newArr, current_item[:item] )
    end
    i += 1
  end
  newArr

end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
   i = 0

  while i < coupons.size do
    current_coupon = coupons[i]
    discount = find_item_by_name_in_collection( current_coupon[:item], cart )
      if ( discount[:count] / current_coupon[:num] >= 1 )
        cart.push( {:item => "#{current_coupon[:item]} W/COUPON",
                    :price => (current_coupon[:cost] / current_coupon[:num]).round(2),
                    :clearance => discount[:clearance],
                    :count => discount[:count] - ( discount[:count] % current_coupon[:num])})

        discount[:count] %= current_coupon[:num]
      end
    i += 1
  end
  cart

end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
    i = 0
  newArr = []

  while i < cart.size do
    current_item = cart[i]
    if ( current_item[:clearance] )
      current_item[:price] = current_item[:price] - ( current_item[:price] * 0.20 )
    end
    newArr.push( current_item )
    i += 1 
  end
  newArr
end

def checkout(cart, coupons)
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
    checkout = consolidate_cart( cart )
  checkout = apply_coupons( checkout, coupons )
  checkout = apply_clearance( checkout )

  i = 0
  total = 0

  while i < checkout.size do
    current_item_total = checkout[i][:price] * checkout[i][:count]
    current_item_total.round(2)
    total += current_item_total
    i += 1
  end
  if ( total > 100 )
    total *= 0.90
  end
  total
end

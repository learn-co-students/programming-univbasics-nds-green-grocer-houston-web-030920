require 'pry'

def find_item_by_name_in_collection(name, collection) 
#this method takes in two arguments. A name and an array. It will then search for the name in the array. If the name is there, it will return that entire element that the name is in. If the name is not found nil will be returned. 
  counter = 0
  while counter < collection.length do 
    if name == collection[counter][:item]   
      return collection[counter]
end 
counter += 1 
  
end
return collection[counter]
end 

#I used the method above because in the method below I want to find if the name of the item is in the new array. if it is, Im going to increment it one. If not, Im going to put it into the array. 

def consolidate_cart(cart)
  new_cart = []
  counter = 0 
  while counter < cart.length do 
 new_cart_item = find_item_by_name_in_collection(cart[counter][:item], new_cart)
 #We want to figureout if item is in our new cart 
 #This method checks to see if the item we're looking for is in the new cart. Takes in items name and collection or cart. :item key points to name of the item. 
 # This will either return the item or it will retrun nil. RETURNS THE ITEM OR RETURNS NIL
 #This above code produces nil or cart[counter], per the above method. If nil is prodcued then a new hash called new_cart_item is added to the new array with a new hash called :count.
 #If it already exist, the counter is incremented by one. 
 #My question is, what is new_cart_item 

if new_cart_item 
  #If this has a truthy value, do whats below. New_cart_item is the item!!! It will be truthy if it is in the array. If in the array, we will just incremement count by 1. And do this every time this item comes up. 
  new_cart_item[:count] += 1 
  else new_cart_item = { 
    #Else is all other options. Either truthy of falsey. If new_cart_item returns nil, then we will do below. Which is creating our item. Creating a new hash, which is the same hash with :count added. So you can say, if this is not already in our array, which will produce nil, we will add :count to the array and and put it into the new array. We will give it a count of 1. Once its been built the count will be incremented by one for each time the item is in the old cart.
:item => cart[counter][:item], 
:price => cart[counter][:price],
:clearance => cart[counter][:clearance],
:count => cart[counter][:count] = 1  
  }
new_cart<< new_cart_item
end 
counter += 1 
end
new_cart 

end


def apply_coupons(cart, coupons)
  
  counter = 0 
  while counter < coupons.length do 
  cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
  couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
  cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
 if cart_item && cart_item[:count] >= coupons[counter][:num]    
  if cart_item_with_coupon
    cart_item_with_coupon[:count] += coupons[counter][:num]
    cart_item[:count] -= coupons[counter][:num]
  else 
    cart_item_with_coupon = {
  :item => couponed_item_name,
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

def apply_clearance(cart)
counter = 0 
while counter < cart.length do
 if cart[counter][:clearance] 
   cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.2))
 
 end 
 counter += 1 
 end 
 cart 
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  
  total = 0 
  counter =0 
  while counter < final_cart.length
  total += final_cart[counter][:price] * final_cart[counter][:count]
  counter += 1 
end
if total > 100 
  total -= (total * 0.10)
end
total
end 

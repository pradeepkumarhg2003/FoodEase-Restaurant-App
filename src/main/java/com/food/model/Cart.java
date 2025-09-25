package com.food.model;

import java.util.HashMap;
import java.util.Map;

public class Cart {

    // Map of cart items (key: itemId, value: CartItem object)
    private Map<Integer, CartItem> items;

    public Cart() {
        this.items = new HashMap<>();
    }
//
    // Add item to cart
    public void addCartItem(CartItem item) {
    	
    	int itemId = item.getItemId();
        if (items.containsKey(itemId)) {
        	CartItem existingItem = items.get(itemId);
            int newQuanity = item.getQuantity();
            
            int oldQuantity = existingItem.getQuantity();
            
            int sumOfQuantity = newQuanity + oldQuantity;
            existingItem.setQuantity(sumOfQuantity);
            
        } else {
            items.put(itemId, item);
        }
    }
//
    // Update item quantity in cart
    public void updateCartItem(int itemId, int quantity) {
        if (items.containsKey(itemId)) {
            if(quantity <= 0) {
            	items.remove(itemId);
            }else {
            	items.get(itemId).setQuantity(quantity);
            }
        }
    }
//
//     Remove item from cart
    public void removeCartItem(int itemId) {
       items.remove(itemId);
    }
    
    
    public Map<Integer, CartItem> getItems() {
		return items;
	}
    
    // Calculate total price
    public double getTotalPrice() {
        double total = 0;
        for (CartItem item : items.values()) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }
}


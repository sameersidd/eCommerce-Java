package com.esite;

import java.util.ArrayList;

public class Cart {
    private String name = null;
    private ArrayList<Item> cart;
    public Cart(String name){
        this.name = name;
        cart = new ArrayList<>();
    }

    public String getName (){
        return name;
    }

    public ArrayList<Item> getCart (){
        return cart;
    }


    public void addToCart(String itemID, int quantity) {
        cart.add(new Item(itemID, quantity));
    }

    public void deleteFromCart(String itemID){
        int size = cart.size();
        for (int i = 0; i < size; i++){
            if(cart.get(i).getItemID().equals(itemID)){
                cart.remove(i);
                break;
            }
        }
    }

    public void emptyCart() {
        for (int i = cart.size();!(cart.isEmpty());i++){
            cart.remove(i);
        }
    }

    public int numberOfItems(){
        return cart.size();
    }

}

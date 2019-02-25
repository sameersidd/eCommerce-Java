package com.esite;

public class Item {
    private String itemID = null;
    private int quantity = 0;
    public Item (String itemID, int quantity){
        this.itemID = itemID;
        this.quantity = quantity;
    }

    public String getItemID(){
        return itemID;
    }

    public int getQuantity(){
        return quantity;
    }

}

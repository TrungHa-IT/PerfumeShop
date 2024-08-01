/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import Dal.ProductDetailDAO;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hatru
 */
public class Cart {

    private List<Item> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    public List<Item> getItems() {
        return items;
    }

    public Cart(List<Item> items) {
        this.items = items;
    }

    public Item getItemById(int id) {
        for (Item i : items) {
            if (i.getProduct().getProductFullDetailID() == id) {
                return i;
            }
        }
        return null;
    }

    public int getQuantityById(int id) {
        Item item = getItemById(id);
        if (item == null) {
            // Return 0 or handle appropriately if the item is not found
            return 0;
        }
        return item.getQuantity();
    }

    //add item to cart
    public final void addItem(Item t) {
        Item i = getItemById(t.getProduct().getProductFullDetailID());
        if (i != null) {
            i.setQuantity(i.getQuantity() + t.getQuantity());
        } else {
            items.add(t);
        }
    }

    public void removeItem(int id) {
        Item i = getItemById(id);
        if (i != null) {
            items.remove(i);
        }
    }

    public BigDecimal getTotalMoney() {
        BigDecimal t = BigDecimal.valueOf(0);
        for (Item i : items) {
            BigDecimal quantity = BigDecimal.valueOf(i.getQuantity());
            t = t.add(quantity.multiply(i.getProduct().getProductPrice()));
        }
        return t;
    }

    private ProductDetail getProductDetailByID(int id, List<ProductDetail> list) {
        for (ProductDetail i : list) {
            if (i.getProductFullDetailID() == id) {
                return i;
            }
        }
        return null;
    }

    public Cart(String txt, List<ProductDetail> list) {
        items = new ArrayList<>();
        try {
            if (txt != null && txt.length() != 0) {
                String[] s = txt.split(",");
                for (String i : s) {
                    String[] n = i.split(":");
                    int id = Integer.parseInt(n[0]);
                    int quantity = Integer.parseInt(n[1]);
                    String name = n[2];
                    ProductDetail p = getProductDetailByID(id, list);
                    Item t = new Item(p, quantity, name);
                    addItem(t);
                }
            }
        } catch (NumberFormatException e) {

        }

    }

}

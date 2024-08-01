/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Util;

import Constant.constant;
import Models.Cart;
import Models.Item;
import java.util.regex.Pattern;

/**
 *
 * @author nguye
 */
public class Validation {

    public boolean isValidStartWithSpace(String str) {
        return str.startsWith(" ");
    }

    public boolean isValidVietnameseAndEnglish(String str) {
        String regex = constant.VIETNAMESE;
        Pattern pattern = Pattern.compile(regex);
        return !pattern.matcher(str).matches();
    }

    public boolean isValidEmpty(String str) {
        return str.trim().isEmpty() || str == null;
    }

    public boolean isPositiveIntegerText(String s) {
        return s.matches("\\d+");
    }

    public boolean isPositiveRealNumberText(String s) {
        return s.matches("\\d*\\.?\\d+");
    }

    public String txtCookie(Cart cart) {
        String txt = "";
        for (Item ca : cart.getItems()) {
            txt += String.valueOf(ca.getProduct().getProductFullDetailID()) + ":" + ca.getQuantity() + ":" + ca.getName() + ",";
        }
        if (txt != null && txt.length() > 0 && txt.charAt(txt.length() - 1) == ',') {
            txt = txt.substring(0, txt.length() - 1);
        }
        return txt;
    }

    public boolean CheckPass(String password) {
        boolean islower = false;
        boolean isupper = false;
        boolean isNumber = false;
        boolean isspecital = false;
        if (password.length() < 8) {
            return false;
        }
        for (char p : password.toCharArray()) {
            if (Character.isUpperCase(p)) {
                islower = true;
            } else if (Character.isLowerCase(p)) {
                isupper = true;
            } else if (Character.isDigit(p)) {
                isNumber = true;
            } else {
                isspecital = true;
            }
        }
        if (password.contains(" ")) {
            return false;
        }
        return isNumber && islower && isspecital && isupper;
    }
    
    public static boolean isValidFirstName(String firstName) {
        // Kiểm tra nếu firstname không rỗng và không chỉ chứa khoảng trắng
        if (firstName == null || firstName.trim().isEmpty()) {
            return false;
        }

        // Kiểm tra độ dài của firstname
        if (firstName.length() < 2 || firstName.length() > 50) {
            return false;
        }

        // Kiểm tra nếu firstname chỉ chứa chữ cái và khoảng trắng
        return firstName.matches("[a-zA-Z ]+");
    }
    
    public static boolean isValidLastName(String firstName) {
        // Kiểm tra nếu firstname không rỗng và không chỉ chứa khoảng trắng
        if (firstName == null || firstName.trim().isEmpty()) {
            return false;
        }

        // Kiểm tra độ dài của firstname
        if (firstName.length() < 2 || firstName.length() > 50) {
            return false;
        }

        // Kiểm tra nếu firstname chỉ chứa chữ cái và khoảng trắng
        return firstName.matches("[a-zA-Z ]+");
    }


    public static void main(String[] args) {
        Validation validation = new Validation();
        System.out.println(validation.isValidEmpty(constant.ACCOUNTS));
        System.out.println(constant.ACCOUNTS);
    }

}

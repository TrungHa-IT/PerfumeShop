/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import Models.Carts;
import Models.ProductDetail;
import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hatru
 */
public class CartsDAO extends DBContext {

    public List<Carts> getAllCart() {
        List<Carts> list = new ArrayList<>();
        String sql = "select * from Cart";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);

            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Carts cart = new Carts(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5));
                list.add(cart);
            }

        } catch (SQLException e) {

        }
        return list;
    }

    public List<Carts> getCartByAccountID(int accountID) {
        List<Carts> list = new ArrayList<>();
        String sql = "select * from Cart where AccountID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, accountID);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Carts cart = new Carts(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5));
                list.add(cart);
            }

        } catch (SQLException e) {

        }
        return list;
    }

    public void minusQuantity(int quantity, int pdID, int accountID) {
        String sql = "UPDATE Cart set Quantity = ? - 1 where ProductFullDetailID = ? and AccountID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, quantity);
            ur.setInt(2, pdID);
            ur.setInt(3, accountID);
            ur.executeUpdate();

        } catch (SQLException e) {

        }
    }

    public void addQuantity(int quantity, int pdID, int accountID) {
        String sql = "UPDATE Cart set Quantity = ? + 1 where ProductFullDetailID = ? and AccountID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, quantity);
            ur.setInt(2, pdID);
            ur.setInt(3, accountID);
            ur.executeUpdate();

        } catch (SQLException e) {

        }
    }

    public void updateQuantity(int quantity, int pdID, int accountID) {
        String sql = "UPDATE Cart set Quantity = ? where ProductFullDetailID = ? and AccountID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, quantity);
            ur.setInt(2, pdID);
            ur.setInt(3, accountID);
            ur.executeUpdate();

        } catch (SQLException e) {

        }
    }

    public void deleteAllCart(int accountID) {
        String sql = "delete from Cart where AccountID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, accountID);
            ur.execute();

        } catch (SQLException e) {

        }
    }

    public void deleteCart(int cartID) {
        String sql = "delete from Cart where CartID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, cartID);
            ur.execute();

        } catch (SQLException e) {

        }
    }

    public Carts checkExist(int productdetailID, int accountID) {
        String sql = "select * from Cart where ProductFullDetailID = ? and AccountID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, productdetailID);
            ur.setInt(2, accountID);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Carts cart = new Carts(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5));
                return cart;
            }
        } catch (SQLException e) {

        }
        return null;
    }

    public void insetNewCart(int pdID, int accountID, int Quantity, String ProductName) {
        String sql = "INSERT INTO Cart(ProductFullDetailID, AccountID, Quantity,ProductName) VALUES (?, ?, ?,?);";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, pdID);
            ur.setInt(2, accountID);
            ur.setInt(3, Quantity);
            ur.setString(4, ProductName);
            ur.execute();

        } catch (SQLException e) {

        }
    }

    public void updateQuantityProduct(int oldQuantity, int addQuantity, int pdID, int accountID) {
        String sql = "UPDATE Cart set Quantity = ? + ? where ProductFullDetailID=? and AccountID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, oldQuantity);
            ur.setInt(2, addQuantity);
            ur.setInt(3, pdID);
            ur.setInt(4, accountID);
            ur.executeUpdate();

        } catch (SQLException e) {

        }
    }

    public static void main(String[] args) {
        CartsDAO dao = new CartsDAO();
//            List<Carts> list = dao.getAllCart();
//            ProductDetailDAO pdDAO = new ProductDetailDAO();
//          
//        
//         List<ProductDetail> listProductDetails = new ArrayList<>();
//           List<Carts> listCart = dao.getAllCart();
//        for (Carts carts : listCart) {
//            ProductDetail p = pdDAO.getInforProductDetail(carts.getProductFullDetailID());
//            listProductDetails.add(p);
//
//        }
//        for (ProductDetail listProductDetail : listProductDetails) {
//            System.out.println(listProductDetail.toString());
////        }
//            for (Carts carts : listCart) {
//                System.out.println(carts.getCardID());

        //dao.deleteCart(7);
        //dao.minusQuantity(9, 3, 7);
        //dao.addQuantity(8, 3, 7);
        //dao.deleteCart(3);
//      if(dao.checkExist(1, 3) != null){
//          System.out.println(true);
//      }
//      else{
//          System.out.println(false);
//      }
//      
        dao.insetNewCart(81, 1, 3, "XERJOFF%20NAXOS%20EDP");
        //dao.updateQuantityProduct(12, 6, 16, 9);
        //System.out.println( dao.checkExist(16, 9).getQuantity());
//        List<Carts> cart  = dao.getCartByAccountID(9);
//        for (Carts carts : cart) {
//            System.out.println(carts.getName());
//        }
//        Carts cart = dao.checkExist(3, 8);
//        System.out.println(cart.getName());
    }
}

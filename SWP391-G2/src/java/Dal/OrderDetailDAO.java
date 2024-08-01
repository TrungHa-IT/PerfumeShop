/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import Models.Orders;
import Models.orderDetailSale;
import context.DBContext;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nguye
 */
public class OrderDetailDAO extends DBContext {

    public List<orderDetailSale> getAllByOrderId(int id) {
        List<orderDetailSale> _details = new ArrayList<>();
        String sql = "select pd.image,od.odName,pd.ProductSize,od.odQuantity,od.odPrice,pd.ProductFullDetailID from OrderDetail od join ProductFullDetail pd on od.odProductDetail = pd.ProductFullDetailID where od.odOrderID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, id);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                orderDetailSale detail = new orderDetailSale(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getFloat(5),
                        rs.getInt(6)
                );
                _details.add(detail);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return _details;
    }

    public void insertOrderDetail(int orderID, int pdID, int odQuantity, float pdPrice, String odName) {
        String sql = "insert into OrderDetail(odOrderID, odProductDetail, odQuantity, odPrice, odName) values(?,?,?,?,?);";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, orderID);
            ur.setInt(2, pdID);
            ur.setInt(3, odQuantity);
            ur.setFloat(4, pdPrice);
            ur.setString(5, odName);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public static void main(String[] args) {
        OrderDetailDAO detailDAO = new OrderDetailDAO();
        //System.out.println(detailDAO.getAllByOrderId(1).size());
        detailDAO.insertOrderDetail(8, 12, 8, 200, "Trung");
    }
}

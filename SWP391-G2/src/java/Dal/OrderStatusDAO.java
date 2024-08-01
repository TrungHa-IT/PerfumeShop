/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import Models.OrderStatus;
import Models.orderDetailSale;
import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nguye
 */
public class OrderStatusDAO extends DBContext {

    public List<OrderStatus> getAll() {
        String sql = "Select * from StatusOrder";
        List<OrderStatus> statuss = new ArrayList<>();
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                OrderStatus status = new OrderStatus(
                        rs.getInt(1),
                        rs.getString(2)
                );
                statuss.add(status);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return statuss;
    }
    public static void main(String[] args) {
        OrderStatusDAO dao = new OrderStatusDAO();
        System.out.println(dao.getAll().size());
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import Models.Brands;
import Models.Orders;
import context.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

/**
 *
 * @author hatru
 */
public class OrderDAO extends DBContext {

    public int getSumRevenue() {
        String sql = "select SUM(OrderTotalPrice) from Orders";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getTotalDeals() {
        String sql = "SELECT COUNT(DISTINCT odID) FROM [dbo].[OrderDetail];";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getSumQuantitySold() {
        String sql = "select SUM(odQuantity) from OrderDetail";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public double totalRevenueMonth(int month, int year) {
        String sql = "select SUM([OrderTotalPrice]) from [Orders]\r\n"
                + "where MONTH([OrderReceiveDate])=? and year([OrderReceiveDate])=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, month);
            st.setInt(2, year);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public double totalRevenueByWeek(int day, int from, int to, int year, int month) {
        String sql = "";
        if (from > to) {
            sql = "SELECT SUM(OrderTotalPrice) "
                    + "FROM Orders "
                    + "WHERE ((DAY(OrderReceiveDate) >= ? AND MONTH(OrderReceiveDate) = ?) "
                    + "OR (DAY(OrderReceiveDate) <= ? AND MONTH(OrderReceiveDate) = ?)) "
                    + "AND YEAR(OrderReceiveDate) = ? AND DATEPART(dw, OrderReceiveDate) = ?";
        } else {
            sql = "SELECT SUM(OrderTotalPrice) "
                    + "FROM Orders "
                    + "WHERE DAY(OrderReceiveDate) BETWEEN ? AND ? "
                    + "AND MONTH(OrderReceiveDate) = ? "
                    + "AND YEAR(OrderReceiveDate) = ? "
                    + "AND DATEPART(dw, OrderReceiveDate) = ?";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            if (from > to) {
                st.setInt(1, from);
                st.setInt(2, month);
                st.setInt(3, to);
                st.setInt(4, (month + 1));
                st.setInt(5, year);
                st.setInt(6, day);
            } else {
                st.setInt(1, from);
                st.setInt(2, to);
                st.setInt(3, month);
                st.setInt(4, year);
                st.setInt(5, day);
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void insertOrder(Orders order) {
        String sql = "insert into Orders(AccountID, OrderDate, OrderTotalPrice, OrderContactName,OrderPhone, Email, OrderAddress,  PaymentMethod, OrderNote, OrderSoID, VoucherID) values(?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, order.getAccountID());
            ur.setDate(2, (Date) order.getOrderDate());
            ur.setDouble(3, order.getOrderTotalPrice());
            ur.setString(4, order.getOrderContactName());
            ur.setString(5, order.getOrderPhone());
            ur.setString(6, order.getEmail());
            ur.setString(7, order.getOrderAddress());
            ur.setString(8, order.getPaymentMethod());
            ur.setString(9, order.getOrderNote());
            ur.setInt(10, order.getOrderSoID());
            ur.setInt(11, order.getVoucherID());
            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public List<Orders> getMyOrder(int accountID) {
        List<Orders> listOrder = new ArrayList<>();
        String sql = "select * from Orders where AccountID = 3 and OrderSoID = 1";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            //ur.setInt(1, accountID);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Orders order = new Orders(rs.getInt(1),
                        rs.getInt(2),
                        rs.getDate(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getInt(11),
                        rs.getInt(12));
                listOrder.add(order);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listOrder;
    }

    public List<Orders> getListOrder() {
        List<Orders> listOrder = new ArrayList<>();
        String sql = "select * from Orders";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Orders order = new Orders(rs.getInt(1),
                        rs.getInt(2),
                        rs.getDate(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getInt(11),
                        rs.getInt(12));
                listOrder.add(order);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listOrder;
    }

    public ArrayList<Orders> getOrdersByFilter(String date, int status, String search, int pageNo, int pageSize) {
        ArrayList<Orders> listOrder = new ArrayList<>();
        String sql = "select * from Orders";
        boolean whereAdded = false; // A flag to track whether "WHERE" has been added to the SQL query.
        if (status != -1 || !search.isEmpty() || date != null) {
            sql += " WHERE";
            if (status != -1) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " OrderSoID = ?";
                whereAdded = true;
            }
            if (date != null) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " OrderDate <= ?";
                whereAdded = true;
            }
            if (!search.isEmpty()) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " (OrderAddress like ? or OrderContactName like ? or OrderPhone like ? or Email like ? )";
            }
        }

        sql += " ORDER BY OrderID desc  OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            int parameterIndex = 1; // Start with the first parameter index
            if (status != -1) {
                ur.setInt(parameterIndex, status);
                parameterIndex++;
            }
            if (date != null) {
                ur.setString(parameterIndex, date);
                parameterIndex++;
            }
            if (!search.isEmpty()) {
                for (int i = 0; i < 4; i++) {
                    ur.setString(parameterIndex, "%" + search + "%");
                    parameterIndex++;
                }
            }
            // Set the limit and offset parameters for pagination
            ur.setInt(parameterIndex, (pageNo - 1) * pageSize);
            parameterIndex++;
            ur.setInt(parameterIndex, pageSize);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Orders order = new Orders(rs.getInt(1),
                        rs.getInt(2),
                        rs.getDate(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getInt(11),
                        rs.getInt(12));
                listOrder.add(order);

            }
        } catch (Exception e) {
        }

        return listOrder;

    }

    public int getTotalPage(String date, int status, String search, int pageSize) {
        String sql = "SELECT COUNT(*) FROM Orders";
        boolean whereAdded = false; // A flag to track whether "WHERE" has been added to the SQL query.
        if (status != -1 || !search.isEmpty()) {
            sql += " WHERE";
            if (status != -1) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " OrderSoID = ?";
                whereAdded = true;
            }
            if (date != null) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " OrderDate <= ?";
                whereAdded = true;
            }
            if (!search.isEmpty()) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " (OrderAddress like ? or OrderContactName like ? or OrderPhone like ? or Email like ? )";
            }
        }

        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            int parameterIndex = 1; // Start with the first parameter index
            if (status != -1) {
                ur.setInt(parameterIndex, status);
                parameterIndex++;
            }
            if (!search.isEmpty()) {
                for (int i = 0; i < 4; i++) {
                    ur.setString(parameterIndex, "%" + search + "%");
                    parameterIndex++;
                }
            }
            ResultSet rs = ur.executeQuery();
            if (rs.next()) {
                int totalRecord = rs.getInt(1);
                int totalPage = totalRecord / pageSize;
                if (totalRecord % pageSize != 0) {
                    totalPage++;
                }
                return totalPage;
            }
        } catch (Exception e) {
        }
        return 0;

    }

    public int getOrderID() {
        String sql = "SELECT TOP 1 * FROM Orders ORDER BY OrderID DESC;";
        int orderID = -1;
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                orderID = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return orderID;
    }

    public Orders getOrder(int id) {
        Orders order = null;
        String sql = "select * from Orders where OrderID = ? ";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, id);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                order = new Orders(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getDate(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getInt(11),
                        rs.getInt(12)
                );
            }
            closeResultSetAndStatement(rs, ur);
        } catch (SQLException e) {
            System.err.println(e);
        }
        return order;
    }

    public void updateStatus(int id, int status) {

        String sql = "UPDATE [dbo].[Orders]\n"
                + "   SET \n"
                + "      [OrderSoID] = ?\n"
                + "    \n"
                + " WHERE OrderID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(2, id);
            ur.setInt(1, status);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public void closeResultSetAndStatement(ResultSet rs, PreparedStatement ps) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                System.out.println(e + "ham mypurchase");
            }
        }

    }

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        LocalDate orderDate = LocalDate.of(2024, 7, 2);
//        LocalDate recieveDate = LocalDate.of(2024, 7, 5);

        Date sqlOrderDate = Date.valueOf(orderDate);
//        Date sqlRecieveDate = Date.valueOf(recieveDate);
        //Orders order = new Orders(1, sqlOrderDate, 3600,"Ha Trung" ,"0944362986", "hatrung03022003@gmail.com", "Thanh Ba - Phu Tho","Direct", "Hang de vo", 1, 2);
        Orders o = new Orders(11, sqlOrderDate, 669.999, "Dinh Khanh Linh", "0944362986", "hatrung03022003@gmail.com", "Khu 12 ngo trang tien phuong xuan la quan tay ho thanh pho ha noi", "Direct", "Hang de vo", 1, -1);
        dao.insertOrder(o);
//        List<Orders> list = dao.getOrdersByFilter(1, "", 1, 10);
//        for (Orders orders : list) {
//            System.out.println(orders.getOrderContactName());
//        }
//        List<Orders> list = dao.getOrdersByFilter("", -1, "", 1, 10);
//        for (Orders orders : list) {
//            System.out.println(orders.getOrderContactName());
//        }
    }
}

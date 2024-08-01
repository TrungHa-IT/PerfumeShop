/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import Models.Vouchers;
import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author admin
 */
public class VouchersDAO extends DBContext {

    public List<Vouchers> getVoucherByName() {
        String sql = "select Code from Vouchers";
        List<Vouchers> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Vouchers voucher = new Vouchers(rs.getString(1));
                list.add(voucher);
            }

        } catch (SQLException e) {

        }
        return list;
    }

    public Vouchers getVourcherByCode(String code) {
        String sql = "select * from Vouchers where Code = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, code);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Vouchers(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getDate(4),
                        rs.getDate(5),
                        rs.getInt(6),
                        rs.getDate(7),
                        rs.getInt(8));
            }

        } catch (SQLException e) {

        }
        return null;
    }

    public void InsertVoucher(String code, double discount, Date EndDate, Date StartDate, int quantity, Date Create, int status) {
        String sql = "INSERT INTO [dbo].[Vouchers]\n"
                + "           ([Code]\n"
                + "           ,[Discount]\n"
                + "           ,[ExpiryDate]\n"
                + "           ,[StartDate]\n"
                + "           ,[Quantity]\n"
                + "           ,[CreateAt]\n"
                + "           ,[Status])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ?, ?, ?);";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setString(1, code);
            ur.setDouble(2, discount);
            ur.setDate(3, EndDate);
            ur.setDate(4, StartDate);
            ur.setInt(5, quantity);
            ur.setDate(6, Create);
            ur.setInt(7, status);
            ur.executeQuery();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }

    public void UpdateVoucher(String code, double discount, Date EndDate, Date StartDate, int quantity, Date Create, int status, int id) {
        String sql = "UPDATE [dbo].[Vouchers]\n"
                + "   SET [Code] = ?,\n"
                + "       [Discount] = ?,\n"
                + "       [ExpiryDate] = ?,\n"
                + "       [StartDate] = ?,\n"
                + "       [Quantity] = ?,\n"
                + "       [CreateAt] = ?,\n"
                + "       [Status] = ?\n"
                + " WHERE [VoucherID] = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setString(1, code);
            ur.setDouble(2, discount);
            ur.setDate(3, EndDate);
            ur.setDate(4, StartDate);
            ur.setInt(5, quantity);
            ur.setDate(6, Create);
            ur.setInt(7, status);
            ur.setInt(8, id);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }

    public Vouchers getVoucherById(int id) {
        String sql = "select * from Vouchers where VoucherID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Vouchers(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getDate(4),
                        rs.getDate(5),
                        rs.getInt(6),
                        rs.getDate(7),
                        rs.getInt(8));
            }

        } catch (SQLException e) {

        }
        return null;
    }

    public ArrayList<Vouchers> getVouchersByFilter(int status, String search, int pageNo, int pageSize, String start, String end) {
        ArrayList<Vouchers> listVoucher = new ArrayList<>();
        String sql = "SELECT * FROM Vouchers";
        boolean whereAdded = false; // A flag to track whether "WHERE" has been added to the SQL query.

        if (status != -1 || (search != null && !search.isEmpty()) || start != null || end != null) {
            sql += " WHERE";

            if (status != -1) {
                sql += " Status = ?";
                whereAdded = true;
            }

            if (search != null && !search.isEmpty()) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " (Code LIKE ? OR Discount LIKE ?)";
                whereAdded = true;
            }

            if (start != null && end == null) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " StartDate = ?";
                whereAdded = true;
            }

            if (end != null && start == null) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " ExpiryDate = ?";
                whereAdded = true;
            }

            if (start != null && end != null) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " StartDate >= ? AND ExpiryDate <= ?";
            }
        }

        sql += " ORDER BY VoucherID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            int parameterIndex = 1; // Start with the first parameter index

            if (status != -1) {
                ur.setInt(parameterIndex, status);
                parameterIndex++;
            }

            if (search != null && !search.isEmpty()) {
                for (int i = 0; i < 2; i++) {
                    ur.setString(parameterIndex, "%" + search + "%");
                    parameterIndex++;
                }
            }

            if (start != null && end == null) {
                ur.setString(parameterIndex, start);
                parameterIndex++;
            }

            if (end != null && start == null) {
                ur.setString(parameterIndex, end);
                parameterIndex++;
            }

            if (start != null && end != null) {
                ur.setString(parameterIndex, start);
                parameterIndex++;
                ur.setString(parameterIndex, end);
                parameterIndex++;
            }

            // Set the limit and offset parameters for pagination
            ur.setInt(parameterIndex, (pageNo - 1) * pageSize);
            parameterIndex++;
            ur.setInt(parameterIndex, pageSize);

            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Vouchers voucher = new Vouchers(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getDate(4),
                        rs.getDate(5),
                        rs.getInt(6),
                        rs.getDate(7),
                        rs.getInt(8)
                );

                listVoucher.add(voucher);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listVoucher;
    }

    public void updateStatusVoucher(int status, int categoryID) {
        String sql = "UPDATE [dbo].[Vouchers]\n"
                + "   SET [Status] = ?\n"
                + " WHERE [VoucherID] = ?;";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, status);
            ur.setInt(2, categoryID);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public int getTotalPage(int status, String search, int pageSize) {
        String sql = "SELECT COUNT(*) FROM Vouchers";
        boolean whereAdded = false; // A flag to track whether "WHERE" has been added to the SQL query.
        if (status != -1 || !search.isEmpty()) {
            sql += " WHERE";
            if (status != -1) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " Status = ?";
                whereAdded = true;
            }
            if (!search.isEmpty()) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " (Code LIKE ? OR Discount LIKE ?)";
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
                for (int i = 0; i < 2; i++) {
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
    
    public static void main(String[] args) {
        VouchersDAO dao = new VouchersDAO();
        Vouchers v = dao.getVourcherByCode("NEWYEAR2024");
        System.out.println(v.getDiscount());
    }
}

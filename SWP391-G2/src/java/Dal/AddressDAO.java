/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import Models.Accounts;
import Models.Address;
import Models.Products;
import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ROG
 */
public class AddressDAO extends DBContext {

    public List<Address> getAllAddress(int account_id) {
        List<Address> list = new ArrayList<>();
        String sql = "select * from Address where account_id=?";
        //chay lenhj truy van
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, account_id);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Address address = new Address(
                        rs.getInt(1), 
                        rs.getInt(2), 
                        rs.getString(3), 
                        rs.getString(4), 
                        rs.getString(5), 
                        rs.getString(6), 
                        rs.getString(7), 
                        rs.getInt(8), 
                        rs.getDate(9)
                );

                list.add(address);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Address getAll(int account_id) {

        String sql = "select  * from Address where account_id = ?";
        //chay lenhj truy van
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, account_id);
            ResultSet rs = ur.executeQuery();
            if (rs.next()) {
                Address address = new Address(
                        rs.getInt(1), 
                        rs.getInt(2), 
                        rs.getString(3), 
                        rs.getString(4), 
                        rs.getString(5), 
                        rs.getString(6), 
                        rs.getString(7), 
                        rs.getInt(8), 
                        rs.getDate(9)
                );
                return address;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Address getAdress(int account_id) {

        String sql = "select  * from Address where account_id = ?";
        //chay lenhj truy van
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, account_id);
            ResultSet rs = ur.executeQuery();
            if (rs.next()) {
                Address address = new Address(
                           rs.getInt(1), 
                        rs.getInt(2), 
                        rs.getString(3), 
                        rs.getString(4), 
                        rs.getString(5), 
                        rs.getString(6), 
                        rs.getString(7), 
                        rs.getInt(8), 
                        rs.getDate(9)
                );
                return address;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
//      public void updateAddress( int address_id, String phone, String address_line, String city, String district, String wards, int status) {
//        String sql = "Update Address set address_id = ?,phone = ?, address_line= ?, city= ?, district=?, wards=? status=? where account_id = ?";
//        try {
//            PreparedStatement ur = connection.prepareStatement(sql);
//            ur.setInt(1, address_id);
//            ur.setString(2, phone);
//            ur.setString(3, address_line);
//            ur.setString(4, city);
//            ur.setString(5, district);
//            ur.setString(6, wards);
//            ur.setInt(7, status);
//
//            ur.executeUpdate();
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//    }

    public void updateAddress(Address address) {
        String sql = "Update Address set phone = ?, address_line= ?, city= ?, district=?, wards=?, status=? where address_id = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setString(1, address.getPhone());
            ur.setString(2, address.getAddressLine());
            ur.setString(3, address.getCity());
            ur.setString(4, address.getDistrict());
            ur.setString(5, address.getWards());
            ur.setInt(6, address.getStatus());
            ur.setInt(7, address.getAddressId());

            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public void setInsertAddress(Address address) {
        String sql = "INSERT INTO [dbo].[Address] ([account_id],[phone],[address_line],[city],[district],[wards],[status]) VALUES (?,?,?,?,?,?,?);";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, address.getAccountId());
            ur.setString(2, address.getPhone());
            ur.setString(3, address.getAddressLine());
            ur.setString(4, address.getCity());
            ur.setString(5, address.getDistrict());
            ur.setString(6, address.getWards());
            ur.setInt(7, address.getStatus());
            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public void DeleteAddress(String address_id) {
        String sql = "delete from Address where address_id = ?;";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setString(1, address_id);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public Address getAddressByAddressID(String address_id) {
        String sql = "select * from Address where address_id=?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setString(1, address_id);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Address address = new Address(
                        rs.getInt(1), 
                        rs.getInt(2), 
                        rs.getString(3), 
                        rs.getString(4), 
                        rs.getString(5), 
                        rs.getString(6), 
                        rs.getString(7), 
                        rs.getInt(8), 
                        rs.getDate(9)
                );
                return address;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return null;
    }

    public Address changestatus(String address_id, int account_id) {
        String sql = "UPDATE address\n"
                + "SET status = \n"
                + "    CASE \n"
                + "        WHEN address_id = ? THEN 1\n"
                + "        ELSE 0\n"
                + "    END\n"
                + "WHERE account_id = ?;";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setString(1, address_id);
            ur.setInt(2, account_id);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Address address = new Address(
                           rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDate(8)
                );
                return address;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return null;

    }

    public Address getAddressByStatus(int account_id) {
        String sql = "select * from Address where account_id = ? and status = 1";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, account_id);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Address address = new Address(
                      rs.getInt(1), 
                        rs.getInt(2), 
                        rs.getString(3), 
                        rs.getString(4), 
                        rs.getString(5), 
                        rs.getString(6), 
                        rs.getString(7), 
                        rs.getInt(8), 
                        rs.getDate(9)
                );
                return address;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return null;
    }

    public static void main(String[] args) {
        AddressDAO addressdao = new AddressDAO();
//        Address address = new Address();
//        address.setAccountId(11);
//        address.setPhone("123");
//        address.setAddressLine("nha 24");
//        address.setCity("ha noi");
//        address.setDistrict("Nam Tu Liem");
//        address.setWards("daimo");
//        address.setStatus(1);
//        //address.setAddress_id(1004);
//        addressdao.updateAddress(address);
        //addressdao.setInsertAddress(address);
        //addressdao.DeleteAddress("6");
        System.out.println(addressdao.getAddressByStatus(1).toString());

    }

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import context.DBContext;
import Models.Accounts;
import Models.Role;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hatru
 */
public class RoleDAO extends DBContext {

    public List<Role> getAllRoles() {
        List<Role> list = new ArrayList<>();
        String sql = "select * from Roles where roleID != 1";
        //chay lenhj truy van
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Role role = new Role(rs.getInt(1), rs.getString(2));

                list.add(role);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Role> getAllRolesByID(int roleID) {
        List<Role> list = new ArrayList<>();
        String sql = "select * from Roles where roleID = ?";
        //chay lenhj truy van
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, roleID);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Role role = new Role(rs.getInt(1), rs.getString(2));

                list.add(role);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Role> getAllRolesSaleMarket() {
        List<Role> list = new ArrayList<>();
        String sql = "select * from Roles where roleID != 1 and roleID != 4";
        //chay lenhj truy van
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Role role = new Role(rs.getInt(1), rs.getString(2));

                list.add(role);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public static void main(String[] args) {
        List<Role> list = new ArrayList<>();
        RoleDAO dao = new RoleDAO();
        list = dao.getAllRolesByID(1);
        for (Role role : list) {
            System.out.println(role.getRoleID() + role.getRoleName());
        }
    }
}

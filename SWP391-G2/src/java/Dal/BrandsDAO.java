/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Models.Brands;

/**
 *
 * @author pna29
 */
public class BrandsDAO extends DBContext {

    public List<Brands> getBrands() {
        List<Brands> brands = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Brands] where status =1 ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Brands brand = new Brands(
                        rs.getInt("BrandID"),
                        rs.getString("BrandName"),
                        rs.getString("Description"),
                        rs.getDate("CreateAt"),
                        rs.getInt("status")
                );
                brands.add(brand);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return brands;
    }

    public ArrayList<Brands> getBrandByFilter(int status, String search, int pageNo, int pageSize) {
        ArrayList<Brands> listBrands = new ArrayList<>();
        String sql = "SELECT * FROM Brands";
        boolean whereAdded = false; // A flag to track whether "WHERE" has been added to the SQL query.
        if (status != -1 || !search.isEmpty()) {
            sql += " WHERE";
            if (status != -1) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " status = ?";
                whereAdded = true;
            }
            if (!search.isEmpty()) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " (Description LIKE ? OR BrandName LIKE ?)";
            }
        }

        sql += " ORDER BY BrandID desc OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
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
            // Set the limit and offset parameters for pagination
            ur.setInt(parameterIndex, (pageNo - 1) * pageSize);
            parameterIndex++;
            ur.setInt(parameterIndex, pageSize);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Brands brand = new Brands(
                        rs.getInt("BrandID"),
                        rs.getString("BrandName"),
                        rs.getString("Description"),
                        rs.getDate("CreateAt"),
                        rs.getInt("status")
                );
                listBrands.add(brand);
            }
        } catch (Exception e) {
        }

        return listBrands;
    }

    public int getTotalPage(int status, String search, int pageSize) {
        String sql = "SELECT COUNT(*) FROM Brands";
        boolean whereAdded = false; // A flag to track whether "WHERE" has been added to the SQL query.
        if (status != -1 || !search.isEmpty()) {
            sql += " WHERE";
            if (status != -1) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " status = ?";
                whereAdded = true;
            }
            if (!search.isEmpty()) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " (Description LIKE ? OR BrandName LIKE ?)";
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

    public void updateStatusBrand(int status, int brandID) {
        String sql = "UPDATE Brands\n"
                + "SET Status = ?\n"
                + "WHERE BrandID = ?;";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, status);
            ur.setInt(2, brandID);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void insertBrand(String brandName, String brandDescription) {
        String sql = "insert into Brands(BrandName, Description, status) values (?,?,1);";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setString(1, brandName);
            ur.setString(2, brandDescription);
            ur.execute();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Brands getBrandById(int brandID) {
        String sql = "select * from Brands where BrandID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, brandID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Brands brand = new Brands(
                        rs.getInt("BrandID"),
                        rs.getString("BrandName"),
                        rs.getString("Description"),
                        rs.getDate("CreateAt"),
                        rs.getInt("status")
                );
                return brand;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void updateBrand(String name, String description, int status, int brandID) {
        String sql = "Update Brands set BrandName= ?, Description = ? , status = ? where BrandID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setString(1, name);
            ur.setString(2, description);
            ur.setInt(3, status);
            ur.setInt(4, brandID);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Brands checkExistBrandName(String brandName) {
        String sql = "select * from Brands where BrandName = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, brandName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
               Brands brand = new Brands(
                        rs.getInt("BrandID"),
                        rs.getString("BrandName"),
                         rs.getString("Description"),
                        rs.getDate("CreateAt"),
                        rs.getInt("status")
                );
                return brand;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    

    public static void main(String[] args) {
        BrandsDAO brdao = new BrandsDAO();
        List<Brands> brands = brdao.getBrands();
        for (Brands brand : brands) {
            System.out.println(brand.getBrandID() + " " + brand.getBrandName() + " " + brand.getDescription() + "" + brand.getCreateAt());
        }
//        int number = brdao.getTotalPage(1, "", 10);
//        System.out.println(number);
//        List<Brands> list = brdao.getBrandByFilter(1, "", 1, 6);
//        for (Brands brands : list) {
//            System.out.println(brands.getBrandID() + brands.getBrandName());
//        }

//        List<Brands> list = brdao.getBrands();
//        for (Brands brands : list) {
//            System.out.println(brands.toString());
//        }
        //brdao.insertBrand("perfume the best in the world", "asdfhasdfhkajfhkasdf");
//           Brands b =  brdao.getBrandById(2);
//           System.out.println(b.toString());
        //brdao.updateBrand("TRUNGHA", "asdfkajshdfkajshfakjsdfhkajsfdk", 1, 21);
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import context.DBContext;
import Models.ProductDetail;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class ProductDetailDAO extends DBContext {

    public List<ProductDetail> getPriceAllowSize(int id) {
        List<ProductDetail> list = new ArrayList<>();
        String sql = "select * from ProductFullDetail where pdProductID  = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new ProductDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDate(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getBigDecimal(7),
                        rs.getInt(8),
                        rs.getString(9)));
            }

        } catch (SQLException e) {

        }
        return list;
    }

    public void updateQuantity(int id, int quantity) {
        String sql = "UPDATE [dbo].[ProductFullDetail]\n"
                + "   SET \n"
                + "      [ProductAvaiable] = ?\n"
                + "     \n"
                + " WHERE ProductFullDetailID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, quantity);
            ur.setInt(2, id);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public ProductDetail getProductDetail(int id) {
        String sql = "select * from ProductFullDetail where ProductFullDetailID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new ProductDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDate(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getBigDecimal(7),
                        rs.getInt(8),
                        rs.getString(9)
                );

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int getTotalPage(int proId, int status, String size, int pageSize) {
        String sql = "select count(*) from ProductFullDetail";
        boolean whereAdded = false;
        if (proId != -1 || status != -1 || !size.isEmpty()) {
            sql += " WHERE";
            if (proId != -1) {

                sql += " pdProductID = ?";
                whereAdded = true;
            }
            if (status != -1) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " ProductStatus = ?";
                whereAdded = true;
            }

            if (!size.isEmpty()) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " (ProductSize LIKE ?)";
            }
        }
        System.out.println(sql);
        try {

            PreparedStatement st = connection.prepareStatement(sql);
            int parameterIndex = 1;
            if (proId != -1) {
                st.setInt(parameterIndex, proId);
                parameterIndex++;
            }
            if (status != -1) {
                st.setInt(parameterIndex, status);
                parameterIndex++;
            }
            if (!size.isEmpty()) {
                st.setString(parameterIndex, size);

            }
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int totalRecord = rs.getInt(1);
                int totalPage = totalRecord / pageSize;
                if (totalRecord % pageSize != 0) {
                    totalPage++;
                }
                return totalPage;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return 1;
    }

    public int getProductDetailID(int pdID, String size) {
        String sql = "select * from ProductFullDetail where pdProductID = ? and ProductSize like ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, pdID);
            st.setString(2, size);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductDetail p = new ProductDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDate(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getBigDecimal(7),
                        rs.getInt(8),
                        rs.getString(9));
                return p.getProductFullDetailID();
            }
        } catch (SQLException e) {
            System.out.println(e);

        }
        return 0;
    }

    public List<String> getSize(int id) {
        String sql = "select ProductSize from ProductFullDetail where pdProductID = ?";
        List<String> listSize = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                listSize.add(rs.getString(1));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listSize;
    }

    public ArrayList<ProductDetail> getListProductByFilter(int proId, int status, String size, int pageNo, int pageSize) {
        ArrayList<ProductDetail> listProduct = new ArrayList<>();
        ProductDetail productDetail = new ProductDetail();
        String sql = "select * from ProductFullDetail";
        boolean whereAdded = false;
        if (proId != -1 || status != -1 || !size.isEmpty()) {
            sql += " WHERE";
            if (proId != -1) {
                sql += " pdProductID = ?";
                whereAdded = true;
            }
            if (status != -1) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " ProductStatus = ?";
                whereAdded = true;
            }

            if (!size.isEmpty()) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " (ProductSize LIKE ?)";
            }
        }
        sql += " ORDER BY ProductFullDetailID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            int parameterIndex = 1;
            if (proId != -1) {
                st.setInt(parameterIndex, proId);
                parameterIndex++;
            }
            if (status != -1) {
                st.setInt(parameterIndex, status);
                parameterIndex++;
            }
            if (!size.isEmpty()) {
                st.setString(parameterIndex, size);
                parameterIndex++;

            }
            //set the limit and offset parameters for pagination
            st.setInt(parameterIndex, (pageNo - 1) * pageSize);
            parameterIndex++;
            st.setInt(parameterIndex, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                productDetail = new ProductDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDate(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getBigDecimal(7),
                        rs.getInt(8),
                        rs.getString(9)
                );
                listProduct.add(productDetail);
            }

        } catch (Exception e) {

        }
        return listProduct;
    }

    public int getLastProductDetailIdByProductId(int proId) {
        String sql = "select count(*) ProductFullDetailID from ProductFullDetail where pdProductID = ? Order by ProductFullDetailID DESC";

        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, proId);
            ResultSet rs = ur.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -1;
    }

    public int getLastProductDetailId() {
        String sql = "select count(*) from ProductFullDetail";

        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ResultSet rs = ur.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -1;
    }

    public void updateStatus(int proId, int status) {
        String sql = "UPDATE [dbo].[ProductFullDetail]\n"
                + "   SET \n"
                + "[ProductStatus] = ?\n"
                + " WHERE ProductFullDetailID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, status);
            ur.setInt(2, proId);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }

    public void insertNewProductDetail(ProductDetail detail) {
        String sql = "INSERT INTO [dbo].[ProductFullDetail]\n"
                + "           ([pdProductID]\n"
                + "           ,[ProductDescription]\n"
                + "           ,[ProductCreateDate]\n"
                + "           ,[ProductStatus]\n"
                + "           ,[ProductSize]\n"
                + "           ,[ProductPrice]\n"
                + "           ,[ProductAvaiable]\n"
                + "           ,[image])\n"
                + "            VALUES"
                + "           (?,?,?,?,?,?,?,?);";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, detail.getPdProductID());
            ur.setString(2, detail.getProductDescription());
            ur.setDate(3, (Date) detail.getProductCreateDate());
            ur.setInt(4, detail.getProductStatus());
            ur.setString(5, detail.getProductSize());
            ur.setBigDecimal(6, detail.getProductPrice());
            ur.setInt(7, detail.getProductAvaiable());
            ur.setString(8, detail.getImage());

            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }

    public void updateProductDetail(ProductDetail detail) {
        String sql = "UPDATE [dbo].[ProductFullDetail]\n"
                + "     set [ProductDescription] = ?\n"
                + "      ,[ProductStatus] = ?\n"
                + "      ,[ProductSize] = ?\n"
                + "      ,[ProductPrice] = ?\n"
                + "      ,[ProductAvaiable] = ?\n"
                + "      ,[image] = ?\n"
                + " WHERE ProductFullDetailID = ?;";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setString(1, detail.getProductDescription());
            ur.setInt(2, detail.getProductStatus());
            ur.setString(3, detail.getProductSize());
            ur.setBigDecimal(4, detail.getProductPrice());
            ur.setInt(5, detail.getProductAvaiable());
            ur.setString(6, detail.getImage());
            ur.setInt(7, detail.getProductFullDetailID());
            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }

    public ProductDetail getInforProductDetail(int pdID) {

        String sql = "select * from ProductFullDetail where ProductFullDetailID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, pdID);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                ProductDetail p = new ProductDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDate(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getBigDecimal(7),
                        rs.getInt(8),
                        rs.getString(9));
                return p;
            }

        } catch (SQLException e) {

        }
        return null;
    }

    public void insetCart(int pdID, int accountID, int quantity, double totalPrice) {
        String sql = "insert into Cart(ProductFullDetailID, AccountID, Quantity, TotalPrice) \n"
                + "values (?,?,?,?);";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, pdID);
            ur.setInt(2, accountID);
            ur.setInt(3, quantity);
            ur.setDouble(4, totalPrice);

            ur.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateMinusAvaiableProductDetail(int avaiable, int pdID) {
        String sql = "UPDATE ProductFullDetail set ProductAvaiable = ? -1 where ProductFullDetailID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, avaiable);
            ur.setInt(2, pdID);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateAddAvaiableProductDetail(int avaiable, int pdID) {
        String sql = "UPDATE ProductFullDetail set ProductAvaiable = ? +1 where ProductFullDetailID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, avaiable);
            ur.setInt(2, pdID);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<ProductDetail> getAll() {

        String sql = "select * from ProductFullDetail";
        List<ProductDetail> details = new ArrayList<>();
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                ProductDetail p = new ProductDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDate(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getBigDecimal(7),
                        rs.getInt(8),
                        rs.getString(9));
                details.add(p);
            }

        } catch (SQLException e) {

        }
        return details;
    }

    public static void main(String[] args) {
        ProductDetailDAO pddao = new ProductDetailDAO();
        Date date = new Date(System.currentTimeMillis());
        ProductDetail detail = new ProductDetail(90, "sdsa dd", date, 1, "30ml", BigDecimal.valueOf(-1), 100, "");
        System.out.println(pddao.getTotalPage(1, -1, "", 10));
    }
}

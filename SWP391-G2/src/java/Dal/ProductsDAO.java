/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import context.DBContext;
import Models.Products;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Models.ProductsHome;
import java.sql.Date;

/**
 *
 * @author ROG
 */
public class ProductsDAO extends DBContext {

       public Products getProduct(int id) {
        String sql = "select * from Products where ProductID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Products(
                        rs.getInt(1),               
                        rs.getString(2),
                        rs.getDate(3),                        
                        rs.getInt(4),
                        rs.getString(5),                                        
                        rs.getInt(6),
                        rs.getInt(7)
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    public List<ProductsHome> loadProducts() {
        List<ProductsHome> products = new ArrayList<>();
        String sql = "SELECT p.*, "
                + "MIN(pd.ProductPrice) AS priceMin, "
                + "MAX(pd.ProductPrice) AS priceMax "
                + "FROM Products p "
                + "LEFT JOIN ProductFullDetail pd ON p.ProductID = pd.pdProductID "
                + "GROUP BY p.ProductID, p.CategoryID, p.ProductName, p.ProductCreateDate, "
                + "p.ProductStatus, p.ProductImageUrl, p.BrandID";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsHome product = new ProductsHome(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getDate("ProductCreateDate"),
                        rs.getInt("ProductStatus"),
                        rs.getString("ProductImageUrl"),
                        rs.getInt("BrandID"),
                        rs.getBigDecimal("priceMin"),
                        rs.getBigDecimal("priceMax")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    //Top best seller 
    public List<ProductsHome> getTopBestSellers(String number) {
        List<ProductsHome> products = new ArrayList<>();
        String sql = "SELECT TOP " + number + " p.ProductID, p.CategoryID, p.ProductName, p.ProductCreateDate, "
                + "p.ProductStatus, p.ProductImageUrl, p.BrandID, "
                + "MIN(pd.ProductPrice) AS priceMin, "
                + "MAX(pd.ProductPrice) AS priceMax "
                + "FROM Products p "
                + "JOIN ProductFullDetail pd ON p.ProductID = pd.pdProductID "
                + "JOIN OrderDetail od ON p.ProductID = od.odProductID "
                + "WHERE p.CategoryID <> 4 "
                + "GROUP BY p.ProductID, p.CategoryID, p.ProductName, p.ProductCreateDate, "
                + "p.ProductStatus, p.ProductImageUrl, p.BrandID "
                + "ORDER BY SUM(od.odQuantity) DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsHome product = new ProductsHome(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getDate("ProductCreateDate"),
                        rs.getInt("ProductStatus"),
                        rs.getString("ProductImageUrl"),
                        rs.getInt("BrandID"),
                        rs.getBigDecimal("priceMin"),
                        rs.getBigDecimal("priceMax")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // List Products by Category
    public List<ProductsHome> getProductsByCategory(int categoryid) {
        List<ProductsHome> products = new ArrayList<>();
        String sql = "SELECT p.*, "
                + "MIN(pd.ProductPrice) AS priceMin, "
                + "MAX(pd.ProductPrice) AS priceMax "
                + "FROM Products p "
                + "JOIN ProductFullDetail pd ON p.ProductID = pd.pdProductID "
                + "JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "WHERE p.CategoryID = ? AND c.Status = 1 "
                + "GROUP BY p.ProductID, p.ProductName, p.ProductCreateDate, "
                + "p.ProductStatus, p.ProductImageUrl, p.BrandID, p.CategoryID";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsHome product = new ProductsHome(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getDate("ProductCreateDate"),
                        rs.getInt("ProductStatus"),
                        rs.getString("ProductImageUrl"),
                        rs.getInt("BrandID"),
                        rs.getBigDecimal("priceMin"),
                        rs.getBigDecimal("priceMax")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    //List Products by Brand
    public List<ProductsHome> getProductsByBrand(int brandid) {
        List<ProductsHome> products = new ArrayList<>();
        String sql = "SELECT p.*, "
                + "MIN(pd.ProductPrice) AS priceMin, "
                + "MAX(pd.ProductPrice) AS priceMax "
                + "FROM Products p "
                + "JOIN ProductFullDetail pd ON p.ProductID = pd.pdProductID "
                + "JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "WHERE p.BrandID = ? AND c.Status = 1 "
                + "GROUP BY p.ProductID, p.ProductName, p.ProductCreateDate, "
                + "p.ProductStatus, p.ProductImageUrl, p.BrandID, p.CategoryID";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, brandid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsHome product = new ProductsHome(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getDate("ProductCreateDate"),
                        rs.getInt("ProductStatus"),
                        rs.getString("ProductImageUrl"),
                        rs.getInt("BrandID"),
                        rs.getBigDecimal("priceMin"),
                        rs.getBigDecimal("priceMax")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    //Search by check box BrandID
    public List<ProductsHome> searchByCheckboxBrand(int[] brandIds) {
        List<ProductsHome> products = new ArrayList<>();
        String sql = "SELECT p.*, "
                + "MIN(pd.ProductPrice) AS priceMin, "
                + "MAX(pd.ProductPrice) AS priceMax "
                + "FROM Products p "
                + "JOIN ProductFullDetail pd ON p.ProductID = pd.pdProductID "
                + "WHERE 1=1 ";
        if (brandIds != null && brandIds.length > 0) {
            sql += "AND p.BrandID IN (";
            for (int i = 0; i < brandIds.length; i++) {
                sql += brandIds[i];
                if (i < brandIds.length - 1) {
                    sql += ",";
                }
            }
            sql += ") ";
        }
        sql += "GROUP BY p.ProductID, p.CategoryID, p.ProductName, p.ProductCreateDate, "
                + "p.ProductStatus, p.ProductImageUrl, p.BrandID";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsHome product = new ProductsHome(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getDate("ProductCreateDate"),
                        rs.getInt("ProductStatus"),
                        rs.getString("ProductImageUrl"),
                        rs.getInt("BrandID"),
                        rs.getBigDecimal("priceMin"),
                        rs.getBigDecimal("priceMax")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    //Search by check box CategoryID
    public List<ProductsHome> searchByCheckbox(int[] categoryIds) {
        List<ProductsHome> products = new ArrayList<>();
        String sql = "SELECT p.*, "
                + "MIN(pd.ProductPrice) AS priceMin, "
                + "MAX(pd.ProductPrice) AS priceMax "
                + "FROM Products p "
                + "JOIN ProductFullDetail pd ON p.ProductID = pd.pdProductID "
                + "WHERE 1=1 ";
        if (categoryIds != null && categoryIds.length > 0) {
            sql += "AND p.CategoryID IN (";
            for (int i = 0; i < categoryIds.length; i++) {
                sql += categoryIds[i];
                if (i < categoryIds.length - 1) {
                    sql += ",";
                }
            }
            sql += ") ";
        }
        sql += "GROUP BY p.ProductID, p.CategoryID, p.ProductName, p.ProductCreateDate, "
                + "p.ProductStatus, p.ProductImageUrl, p.BrandID";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsHome product = new ProductsHome(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getDate("ProductCreateDate"),
                        rs.getInt("ProductStatus"),
                        rs.getString("ProductImageUrl"),
                        rs.getInt("BrandID"),
                        rs.getBigDecimal("priceMin"),
                        rs.getBigDecimal("priceMax")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    //Get products by category and brand
    public List<ProductsHome> getProductsByCategoriesAndBrands(int[] categoryIds, int[] brandIds) {
        List<ProductsHome> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT p.*, "
                + "MIN(pd.ProductPrice) AS priceMin, "
                + "MAX(pd.ProductPrice) AS priceMax "
                + "FROM Products p "
                + "JOIN ProductFullDetail pd ON p.ProductID = pd.pdProductID "
                + "WHERE 1=1 ");

        if (categoryIds != null && categoryIds.length > 0) {
            sql.append("AND p.CategoryID IN (");
            for (int i = 0; i < categoryIds.length; i++) {
                sql.append(categoryIds[i]);
                if (i < categoryIds.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(") ");
        }

        if (brandIds != null && brandIds.length > 0) {
            sql.append("AND p.BrandID IN (");
            for (int i = 0; i < brandIds.length; i++) {
                sql.append(brandIds[i]);
                if (i < brandIds.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(") ");
        }

        sql.append("GROUP BY p.ProductID, p.CategoryID, p.ProductName, p.ProductCreateDate, "
                + "p.ProductStatus, p.ProductImageUrl, p.BrandID");

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsHome product = new ProductsHome(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getDate("ProductCreateDate"),
                        rs.getInt("ProductStatus"),
                        rs.getString("ProductImageUrl"),
                        rs.getInt("BrandID"),
                        rs.getBigDecimal("priceMin"),
                        rs.getBigDecimal("priceMax")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    //Search by name ajax in refine
    public List<ProductsHome> searchByName(String text) {
        List<ProductsHome> products = new ArrayList<>();
        String sql = "SELECT p.* ,MIN(pd.ProductPrice) AS priceMin,MAX(pd.ProductPrice) AS priceMax FROM Products p JOIN ProductFullDetail pd ON p.ProductID = pd.pdProductID WHERE p.ProductStatus = 1 and p.ProductName LIKE ? GROUP BY p.ProductID, p.CategoryID, p.ProductName, p.ProductCreateDate, p.ProductStatus, p.ProductImageUrl, p.BrandID";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + text + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsHome product = new ProductsHome(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getDate("ProductCreateDate"),
                        rs.getInt("ProductStatus"),
                        rs.getString("ProductImageUrl"),
                        rs.getInt("BrandID"),
                        rs.getBigDecimal("priceMin"),
                        rs.getBigDecimal("priceMax")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Get list product by page
    public List<ProductsHome> getListByPage(List<ProductsHome> list, int start, int end) {
        ArrayList<ProductsHome> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<ProductsHome> getProductsByPriceRange(int minPrice, int maxPrice) {
        List<ProductsHome> products = new ArrayList<>();
        String sql = "SELECT p.*, "
                + "origPrices.priceMin AS priceMin, "
                + "origPrices.priceMax AS priceMax "
                + "FROM Products p "
                + "JOIN ProductFullDetail pd ON p.ProductID = pd.pdProductID "
                + "JOIN (SELECT pdProductID, "
                + "             MIN(ProductPrice) AS priceMin, "
                + "             MAX(ProductPrice) AS priceMax "
                + "      FROM ProductFullDetail "
                + "      GROUP BY pdProductID) origPrices "
                + "ON p.ProductID = origPrices.pdProductID "
                + "WHERE pd.ProductPrice BETWEEN ? AND ? "
                + "GROUP BY p.ProductID, p.CategoryID, p.ProductName, p.ProductCreateDate, "
                + "         p.ProductStatus, p.ProductImageUrl, p.BrandID, "
                + "         origPrices.priceMin, origPrices.priceMax";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, minPrice);
            ps.setInt(2, maxPrice);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsHome product = new ProductsHome(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getDate("ProductCreateDate"),
                        rs.getInt("ProductStatus"),
                        rs.getString("ProductImageUrl"),
                        rs.getInt("BrandID"),
                        rs.getBigDecimal("priceMin"),
                        rs.getBigDecimal("priceMax")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<ProductsHome> getProductsByPricerangeAndCateAndBrand(int minPrice, int maxPrice, int[] categoryIDs, int[] brandIDs) {
        List<ProductsHome> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT p.*, ")
                .append("origPrices.priceMin AS priceMin, ")
                .append("origPrices.priceMax AS priceMax ")
                .append("FROM Products p ")
                .append("JOIN ProductFullDetail pd ON p.ProductID = pd.pdProductID ")
                .append("JOIN (SELECT pdProductID, ")
                .append("             MIN(ProductPrice) AS priceMin, ")
                .append("             MAX(ProductPrice) AS priceMax ")
                .append("      FROM ProductFullDetail ")
                .append("      GROUP BY pdProductID) origPrices ")
                .append("ON p.ProductID = origPrices.pdProductID ")
                .append("WHERE pd.ProductPrice BETWEEN ? AND ? ");

        // Adding category filter if categoryIDs are provided
        if (categoryIDs != null && categoryIDs.length > 0) {
            sql.append("AND p.CategoryID IN (");
            for (int i = 0; i < categoryIDs.length; i++) {
                sql.append("?");
                if (i < categoryIDs.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(") ");
        }

        // Adding brand filter if brandIDs are provided
        if (brandIDs != null && brandIDs.length > 0) {
            sql.append("AND p.BrandID IN (");
            for (int i = 0; i < brandIDs.length; i++) {
                sql.append("?");
                if (i < brandIDs.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(") ");
        }

        sql.append("GROUP BY p.ProductID, p.CategoryID, p.ProductName, p.ProductCreateDate, ")
                .append("p.ProductStatus, p.ProductImageUrl, p.BrandID, origPrices.priceMin, origPrices.priceMax");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;
            ps.setInt(index++, minPrice);
            ps.setInt(index++, maxPrice);

            if (categoryIDs != null && categoryIDs.length > 0) {
                for (int categoryID : categoryIDs) {
                    ps.setInt(index++, categoryID);
                }
            }

            if (brandIDs != null && brandIDs.length > 0) {
                for (int brandID : brandIDs) {
                    ps.setInt(index++, brandID);
                }
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsHome product = new ProductsHome(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getDate("ProductCreateDate"),
                        rs.getInt("ProductStatus"),
                        rs.getString("ProductImageUrl"),
                        rs.getInt("BrandID"),
                        rs.getBigDecimal("priceMin"),
                        rs.getBigDecimal("priceMax")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<ProductsHome> getProductsByPriceLowToHigh(int[] categoryIDs, int[] brandIDs) {
        List<ProductsHome> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT p.*, ")
                .append("origPrices.priceMin AS priceMin, ")
                .append("origPrices.priceMax AS priceMax ")
                .append("FROM Products p ")
                .append("JOIN ProductFullDetail pd ON p.ProductID = pd.pdProductID ")
                .append("JOIN (SELECT pdProductID, ")
                .append("             MIN(ProductPrice) AS priceMin, ")
                .append("             MAX(ProductPrice) AS priceMax ")
                .append("      FROM ProductFullDetail ")
                .append("      GROUP BY pdProductID) origPrices ")
                .append("ON p.ProductID = origPrices.pdProductID ")
                .append("WHERE 1=1 ");

        // Adding category filter if categoryIDs are provided
        if (categoryIDs != null && categoryIDs.length > 0) {
            sql.append("AND p.CategoryID IN (");
            for (int i = 0; i < categoryIDs.length; i++) {
                sql.append("?");
                if (i < categoryIDs.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(") ");
        }

        // Adding brand filter if brandIDs are provided
        if (brandIDs != null && brandIDs.length > 0) {
            sql.append("AND p.BrandID IN (");
            for (int i = 0; i < brandIDs.length; i++) {
                sql.append("?");
                if (i < brandIDs.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(") ");
        }

        sql.append("GROUP BY p.ProductID, p.CategoryID, p.ProductName, p.ProductCreateDate, ")
                .append("p.ProductStatus, p.ProductImageUrl, p.BrandID, origPrices.priceMin, origPrices.priceMax ")
                .append("ORDER BY priceMin ASC");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;

            if (categoryIDs != null && categoryIDs.length > 0) {
                for (int categoryID : categoryIDs) {
                    ps.setInt(index++, categoryID);
                }
            }

            if (brandIDs != null && brandIDs.length > 0) {
                for (int brandID : brandIDs) {
                    ps.setInt(index++, brandID);
                }
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsHome product = new ProductsHome(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getDate("ProductCreateDate"),
                        rs.getInt("ProductStatus"),
                        rs.getString("ProductImageUrl"),
                        rs.getInt("BrandID"),
                        rs.getBigDecimal("priceMin"),
                        rs.getBigDecimal("priceMax")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<ProductsHome> getProductsByPriceHighToLow(int[] categoryIDs, int[] brandIDs) {
        List<ProductsHome> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT p.*, ")
                .append("origPrices.priceMin AS priceMin, ")
                .append("origPrices.priceMax AS priceMax ")
                .append("FROM Products p ")
                .append("JOIN ProductFullDetail pd ON p.ProductID = pd.pdProductID ")
                .append("JOIN (SELECT pdProductID, ")
                .append("             MIN(ProductPrice) AS priceMin, ")
                .append("             MAX(ProductPrice) AS priceMax ")
                .append("      FROM ProductFullDetail ")
                .append("      GROUP BY pdProductID) origPrices ")
                .append("ON p.ProductID = origPrices.pdProductID ")
                .append("WHERE 1=1 ");

        // Adding category filter if categoryIDs are provided
        if (categoryIDs != null && categoryIDs.length > 0) {
            sql.append("AND p.CategoryID IN (");
            for (int i = 0; i < categoryIDs.length; i++) {
                sql.append("?");
                if (i < categoryIDs.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(") ");
        }

        // Adding brand filter if brandIDs are provided
        if (brandIDs != null && brandIDs.length > 0) {
            sql.append("AND p.BrandID IN (");
            for (int i = 0; i < brandIDs.length; i++) {
                sql.append("?");
                if (i < brandIDs.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(") ");
        }

        sql.append("GROUP BY p.ProductID, p.CategoryID, p.ProductName, p.ProductCreateDate, ")
                .append("p.ProductStatus, p.ProductImageUrl, p.BrandID, origPrices.priceMin, origPrices.priceMax ")
                .append("ORDER BY priceMin DESC");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;

            if (categoryIDs != null && categoryIDs.length > 0) {
                for (int categoryID : categoryIDs) {
                    ps.setInt(index++, categoryID);
                }
            }

            if (brandIDs != null && brandIDs.length > 0) {
                for (int brandID : brandIDs) {
                    ps.setInt(index++, brandID);
                }
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsHome product = new ProductsHome(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getDate("ProductCreateDate"),
                        rs.getInt("ProductStatus"),
                        rs.getString("ProductImageUrl"),
                        rs.getInt("BrandID"),
                        rs.getBigDecimal("priceMin"),
                        rs.getBigDecimal("priceMax")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    //Get Product by ProductID
    public Products getProductByProductID(int id) {
        String sql = "select * from Products where ProductID=?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, id);
            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                Products product = new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDate(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getInt(7));

                return product;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return null;
    }

    public ArrayList<Products> getListProductByFilter(int cateId, int status, String search, int brandId, int pageNo, int pageSize) {
        ArrayList<Products> listProduct = new ArrayList<>();
        Products product = new Products();
        String sql = "select * from Products";
        boolean whereAdded = false;
        if (cateId != -1 || status != -1 || brandId != -1 || !search.isEmpty()) {
            sql += " WHERE";
            if (cateId != -1) {
                sql += " CategoryID = ?";
                whereAdded = true;
            }
            if (status != -1) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " ProductStatus = ?";
                whereAdded = true;
            }
            if (brandId != -1) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " BrandID = ?";
                whereAdded = true;
            }
            if (!search.isEmpty()) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " (ProductName LIKE ?)";
            }
        }

        sql += " ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            int parameterIndex = 1;
            if (cateId != -1) {
                st.setInt(parameterIndex, cateId);
                parameterIndex++;
            }
            if (status != -1) {
                st.setInt(parameterIndex, status);
                parameterIndex++;
            }
            if (brandId != -1) {
                st.setInt(parameterIndex, brandId);
                parameterIndex++;
            }
            if (!search.isEmpty()) {
                st.setString(parameterIndex, "%" + search + "%");
                parameterIndex++;

            }
            //set the limit and offset parameters for pagination
            st.setInt(parameterIndex, (pageNo - 1) * pageSize);
            parameterIndex++;
            st.setInt(parameterIndex, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                product = new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDate(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getInt(7)
                );
                listProduct.add(product);
            }

        } catch (Exception e) {

        }
        return listProduct;
    }

    public int getTotalPage(int cateId, int status, String search, int brandId, int pageSize) {
        String sql = "select count(*) from Products";
        boolean whereAdded = false;
        if (cateId != -1 || status != -1 || brandId != -1 || !search.isEmpty()) {
            sql += " WHERE";
            if (cateId != -1) {
                sql += " CategoryID = ?";
                whereAdded = true;
            }
            if (status != -1) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " ProductStatus = ?";
                whereAdded = true;
            }
            if (brandId != -1) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " BrandID = ?";
                whereAdded = true;
            }
            if (!search.isEmpty()) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " (ProductName LIKE ?)";
            }
        }
        System.out.println(sql);
        try {

            PreparedStatement st = connection.prepareStatement(sql);
            int parameterIndex = 1;
            if (cateId != -1) {
                st.setInt(parameterIndex, cateId);
                parameterIndex++;
            }
            if (status != -1) {
                st.setInt(parameterIndex, status);
                parameterIndex++;
            }
            if (brandId != -1) {
                st.setInt(parameterIndex, brandId);
                parameterIndex++;
            }
            if (!search.isEmpty()) {
                st.setString(parameterIndex, "%" + search + "%");

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
        return 0;
    }

    public int getLastProductId() {
        String sql = "select Top 1 ProductID from Products Order by ProductID DESC";

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

    public void insertNewProduct(Products product) {
        String sql = "INSERT INTO [dbo].[Products] (\n"
                + "    [ProductName],\n"
                + "    [ProductCreateDate],\n"
                + "    [ProductStatus],\n"
                + "    [BrandID],\n"
                + "    [ProductImageUrl],\n"
                + "    [CategoryID])\n"
                + "VALUES (?,?,?,?,?,?)";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setString(1, product.getProductName());
            ur.setDate(2, (Date) product.getProductCreateDate());
            ur.setInt(3, product.getProductStatus());
            ur.setInt(4, product.getBrandID());
            ur.setString(5, product.getProductImageUrl());
            ur.setInt(6, product.getCategoryID());
            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }

    public void updateStatus(int proId, int status) {
        String sql = "UPDATE [dbo].[Products]\n"
                + "   SET \n"
                + "[ProductStatus] = ?\n"
                + " WHERE ProductID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, status);
            ur.setInt(2, proId);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }
    
     public void updateStatusByStatusBrand(int status, int brandID) {
        String sql = "UPDATE [dbo].[Products]  SET [ProductStatus] = ? WHERE BrandID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, status);
            ur.setInt(2, brandID);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }

    public void updateProduct(Products product) {
        String sql = "UPDATE [dbo].[Products]\n"
                + "   SET [ProductName] = ?\n"
                + "      ,[ProductStatus] = ?\n"
                + "      ,[ProductImageUrl] = ?\n"
                + "      ,[BrandID] = ?\n"
                + "      ,[CategoryID] = ?\n"
                + "WHERE ProductID = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setString(1, product.getProductName());
            ur.setInt(2, product.getProductStatus());
            ur.setString(3, product.getProductImageUrl());
            ur.setInt(4, product.getBrandID());
            ur.setInt(5, product.getCategoryID());
            ur.setInt(6, product.getProductID());
            ur.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }

    public List<Products> getProductSimilar(int id) {
        List<Products> p = new ArrayList<>();
        String sql = "select * from Products where BrandID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                p.add(new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDate(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getInt(7)
                ));
            }

        } catch (SQLException e) {

        }
        return p;
    }

    public static void main(String[] args) {
        ProductsDAO productsDAO = new ProductsDAO();

        productsDAO.updateStatusByStatusBrand(1, 1);
    }

}

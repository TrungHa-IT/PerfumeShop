/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.marketing;

import Dal.BrandsDAO;
import Dal.CategoriesDAO;
import Dal.ProductDetailDAO;
import Dal.ProductsDAO;
import Models.Brands;
import Models.Categories;
import Models.ProductDetail;
import Models.Products;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author nguye
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class MarketingUpdateProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String s = request.getParameter("s");
        if (s != null) {
            request.setAttribute("success", "Update successfully");
        }
        String size = "";
        int proId = -1;
        int status = -1;
        int pageNo = 1;
        final int pageSize = 10;
        try {
            size = request.getParameter("size") == null ? "" : request.getParameter("size");
            proId = request.getParameter("proId") == null ? -1 : Integer.parseInt(request.getParameter("proId"));
            status = request.getParameter("status") == null ? -1 : Integer.parseInt(request.getParameter("status"));
            pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));
        } catch (Exception e) {
        }

        ProductsDAO proDao = new ProductsDAO();
        Products product = proDao.getProductByProductID(proId);

        ProductDetailDAO detailDAO = new ProductDetailDAO();
        List<ProductDetail> details = detailDAO.getListProductByFilter(proId, status, size, pageNo, pageSize);
        int totalPage = detailDAO.getTotalPage(proId, status, size, pageSize);
        List<String> listSize = detailDAO.getSize(proId);

        //get categories are active
        CategoriesDAO cateDao = new CategoriesDAO();
        List<Categories> cateList = cateDao.loadCategory();
        String cateName = cateDao.getCategoryById(product.getCategoryID()).getCategoryName();

        //get brands are active
        BrandsDAO brDao = new BrandsDAO();
        List<Brands> brList = brDao.getBrands();

        request.setAttribute("size", size);
        request.setAttribute("product", product);
        request.setAttribute("status", status);
        request.setAttribute("cateName", cateName);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", pageNo);

        request.setAttribute("listBrands", brList);
        request.setAttribute("listSize", listSize);
        request.setAttribute("listDetail", details);
        request.setAttribute("listCate", cateList);
        request.getRequestDispatcher("marketing/product-profile.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductsDAO proDao = new ProductsDAO();
        int proId = -1;
        int newCateId = -1;
        int newBrandId = -1;
        int newStatus = -1;
        int pageNo = -1;
        String productName = "";
        String ima = "";
        try {
            productName = request.getParameter("productName") == null ? "" : request.getParameter("productName");
            ima = request.getParameter("ima") == null ? "" : request.getParameter("ima");
            proId = request.getParameter("productId") == null ? -1 : Integer.parseInt(request.getParameter("productId"));
            newCateId = request.getParameter("newcateId") == null ? -1 : Integer.parseInt(request.getParameter("newcateId"));
            newStatus = request.getParameter("newstatus") == null ? -1 : Integer.parseInt(request.getParameter("newstatus"));
            newBrandId = request.getParameter("newbrandId") == null ? -1 : Integer.parseInt(request.getParameter("newbrandId"));
            pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));
        } catch (Exception e) {
        }

        response.getWriter().println(proId);
        response.getWriter().println(ima);
        response.getWriter().println(newBrandId);
        response.getWriter().println(newCateId);
        response.getWriter().println(newStatus);
        response.getWriter().print(productName);
//        Products product = new Products(proId, productName, newStatus, fileName, newBrandId, newCateId);
        Products product = new Products(proId, productName, newStatus, ima, newBrandId, pageNo);
        
        proDao.updateProduct(product);
        
        response.sendRedirect("marketing-manager-products?s=1");
        //insert product
//        var product = new Products(proId, productName, newStatus, fileName, newBrandId, newCateId);
//        proDao.updateProduct(product);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

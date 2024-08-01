/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.marketing;

import Dal.CategoriesDAO;
import Dal.ProductDetailDAO;
import Models.Categories;
import Models.ProductDetail;
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
import java.math.BigDecimal;
import java.sql.Date;

/**
 *
 * @author nguye
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class MarketingUpdateProductDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int proId = -1;
        int cateId = -1;
        int detailId = -1;
        try {
            detailId = request.getParameter("detailId") == null ? -1 : Integer.parseInt(request.getParameter("detailId"));
            proId = request.getParameter("proId") == null ? -1 : Integer.parseInt(request.getParameter("proId"));
            cateId = request.getParameter("cateId") == null ? -1 : Integer.parseInt(request.getParameter("cateId"));
        } catch (Exception e) {
        }
        //get number of product_detail_id of with product_id
        ProductDetailDAO detailDAO = new ProductDetailDAO();
        ProductDetail detail = detailDAO.getProductDetail(detailId);

        //category
        CategoriesDAO cateDao = new CategoriesDAO();
        String cateName = cateDao.getCategoryById(cateId).getCategoryName();

        request.setAttribute("proId", proId);
        request.setAttribute("cateName", cateName);
        request.setAttribute("cateId", cateId);

        request.setAttribute("detail", detail);
        request.getRequestDispatcher("marketing/update-product-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int cateId = -1;
        int detailId = -1;
        int proId = -1;
        int quantity = -1;
        int status = -1;
        String size = "";
        String detail = "";
        BigDecimal price = BigDecimal.valueOf(-1);
        String fileName = request.getParameter("ima");
        try {
            cateId = request.getParameter("cateId") == null ? -1 : Integer.parseInt(request.getParameter("cateId"));
            proId = request.getParameter("proId") == null ? -1 : Integer.parseInt(request.getParameter("proId"));
            detailId = request.getParameter("detailId") == null ? -1 : Integer.parseInt(request.getParameter("detailId"));
            quantity = request.getParameter("quantity") == null ? -1 : Integer.parseInt(request.getParameter("quantity"));
            status = request.getParameter("status") == null ? -1 : Integer.parseInt(request.getParameter("status"));
            size = request.getParameter("size") == null ? "" : request.getParameter("size");
            detail = request.getParameter("detail") == null ? "" : request.getParameter("detail");
            price = request.getParameter("price") == null ? BigDecimal.valueOf(-1) : new BigDecimal(request.getParameter("price"));
        } catch (Exception e) {
        }

        response.getWriter().println(cateId);
        response.getWriter().println(detailId);
        response.getWriter().println(proId);
        response.getWriter().println(quantity);
        response.getWriter().println(size);
        response.getWriter().println(status);
        response.getWriter().println(detail);
        response.getWriter().print(price);
        response.getWriter().print(fileName);
        //file upload

        //insert product
        ProductDetailDAO pddao = new ProductDetailDAO();
        ProductDetail details = new ProductDetail(detailId, detail, status, size, price, quantity, fileName);
        pddao.updateProductDetail(details);

        response.sendRedirect("product-detail?s=1&&proId=" + proId + "&cateId=" + cateId + "&s=1");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

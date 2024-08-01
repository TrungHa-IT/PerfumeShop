/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.marketing;

import Dal.BrandsDAO;
import Dal.CategoriesDAO;
import Dal.ProductsDAO;
import Models.Accounts;
import Models.Brands;
import Models.Categories;
import Models.Products;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author nguye
 */
public class MarketingManagerProducts extends HttpServlet {

    protected void changeStatus(int proId, int status) {
        ProductsDAO proDao = new ProductsDAO();
        proDao.updateStatus(proId, status);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("role", 3);

        String search = "";
        int proId = -1;
        int newStatus = -1;
        int cateId = -1;
        int status = -1;
        int pageNo = 1;
        int brandId = -1;
        final int pageSize = 10;
        String s = request.getParameter("s");
        try {
            
            proId = request.getParameter("proId") == null ? -1 : Integer.parseInt(request.getParameter("proId"));
            newStatus = request.getParameter("newstatus") == null ? -1 : Integer.parseInt(request.getParameter("newstatus"));
            search = request.getParameter("search") == null ? "" : request.getParameter("search");
            cateId = request.getParameter("cateID") == null ? -1 : Integer.parseInt(request.getParameter("cateID"));
            status = request.getParameter("status") == null ? -1 : Integer.parseInt(request.getParameter("status"));
            brandId = request.getParameter("brandId") == null ? -1 : Integer.parseInt(request.getParameter("brandId"));
            pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));
        } catch (Exception e) {
        }

        if (proId != -1 && newStatus != -1) {
            changeStatus(proId, newStatus);
        }

        //get list products and get total page of list by condition
        ProductsDAO pDao = new ProductsDAO();
        List<Products> proList = pDao.getListProductByFilter(cateId, status, search, brandId, pageNo, pageSize);
        int totalPage = pDao.getTotalPage(cateId, status, search, brandId, pageSize);

        //get categories are active
        CategoriesDAO cateDao = new CategoriesDAO();
        List<Categories> cateList = cateDao.loadCategory();

        //get brands are active
        BrandsDAO brDao = new BrandsDAO();
        List<Brands> brList = brDao.getBrands();

        if(s!=null) request.setAttribute("success", s);
        request.setAttribute("search", search);
        request.setAttribute("cateId", cateId);
        request.setAttribute("status", status);
        request.setAttribute("brandId", brandId);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", pageNo);

        request.setAttribute("listBrands", brList);
        request.setAttribute("listCate", cateList);
        request.setAttribute("listProduct", proList);
        request.getRequestDispatcher("marketing/manager-products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

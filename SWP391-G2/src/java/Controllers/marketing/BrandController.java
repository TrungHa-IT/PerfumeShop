/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.marketing;

import Dal.AccountsDAO;
import Dal.BrandsDAO;
import Dal.ProductsDAO;
import Dal.RoleDAO;
import Models.Accounts;
import Models.Brands;
import Models.Role;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author hatru
 */
public class BrandController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BrandController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BrandController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        int status_new = 0;
        int brandID = -1;
        try {
            status_new = request.getParameter("statusnew") == null ? -1 : Integer.parseInt(request.getParameter("statusnew"));
            brandID  = request.getParameter("brandID") == null ? -1 : Integer.parseInt(request.getParameter("brandID"));
        } catch (Exception e) {
        }

        if (status_new != -1) {
            BrandsDAO brandDAO = new BrandsDAO();
            brandDAO.updateStatusBrand(status_new, brandID);
        }

        String search = "";
        int status = -1;
        int pageNo = 1;
        final int pageSize = 6;
        try {

            search = request.getParameter("search") == null ? "" : request.getParameter("search");
            status = request.getParameter("status") == null ? -1 : Integer.parseInt(request.getParameter("status"));
            pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));

        } catch (Exception e) {
        }
        
        BrandsDAO brandDao = new BrandsDAO();
        ProductsDAO productDao = new ProductsDAO();
        productDao.updateStatusByStatusBrand(status_new, brandID);
        
        List<Brands> listbrand = brandDao.getBrandByFilter(status, search, pageNo, pageSize);
        int totalPage = brandDao.getTotalPage(status, search, pageSize);
        
        request.setAttribute("search", search);
        request.setAttribute("status", status);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", pageNo);
        request.setAttribute("listbrand", listbrand);

        request.getRequestDispatcher("marketing/brand.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        String brandName = request.getParameter("name");
        String brandDescription = request.getParameter("description");
        BrandsDAO brandDAO = new BrandsDAO();
        brandDAO.insertBrand(brandName, brandDescription);
        response.sendRedirect("brand");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

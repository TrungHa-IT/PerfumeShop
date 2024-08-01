/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.marketing;

import Dal.AccountsDAO;
import Dal.BrandsDAO;
import Models.Brands;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

/**
 *
 * @author hatru
 */
public class BrandDetailController extends HttpServlet {

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
            out.println("<title>Servlet BrandDetailController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BrandDetailController at " + request.getContextPath() + "</h1>");
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

        int brandID = -1;
        try {
            //status_new = request.getParameter("statusnew") == null ? -1 : Integer.parseInt(request.getParameter("statusnew"));
            brandID = request.getParameter("id") == null ? -1 : Integer.parseInt(request.getParameter("id"));
        } catch (Exception e) {
        }

        String search = "";
        int status = -1;
        int pageNo = 1;
        final int pageSize = 10;
        try {

            search = request.getParameter("search") == null ? "" : request.getParameter("search");
            status = request.getParameter("status") == null ? -1 : Integer.parseInt(request.getParameter("status"));
            pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));

        } catch (Exception e) {
        }

        BrandsDAO brandDao = new BrandsDAO();
        Brands brand = brandDao.getBrandById(brandID);
        int totalPage = brandDao.getTotalPage(status, search, pageSize);

        request.setAttribute("search", search);
        request.setAttribute("status", status);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", pageNo);
        request.setAttribute("data", brand);
        //response.getWriter().println(brand.getBrandID() + brand.getBrandName());
//          response.getWriter().println(status);
//          response.getWriter().println(brandID);

        request.getRequestDispatcher("marketing/branddetails.jsp").forward(request, response);
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
        
//        <input type="text" value="${requestScope.data.getBrandID()}" name="id" hidden>
//                    <input type="text" value="${requestScope.status}" name="status" id="status" hidden> 
//                    <input type="text" value="${requestScope.currentPage}" name="pageNo" id="pageNo" hidden>
//                    <input type="text" value="${requestScope.search}" name="search" id="search" hidden>
//
//                    <div class="form-group row">
//                        <div class="col-4">
//                            <label for="name">Brand Name</label>
//                            <input type="text" class="form-control" id="name" name="name" placeholder="${requestScope.data.getBrandName()}">
//                            <div id="nameError" class="error-message"></div>
//                        </div>
//                        <div class="col-4">
//                            <label for="description">Brand Description:</label>
//                            <input type="text" class="form-control" id="description" name="description" placeholder="${requestScope.data.getDescription()}">
//                            <div id="descriptionError" class="error-message"></div>
//                        </div>
//                    </div>
//                    <div class="form-group row">
//                        <div class="col-4">
//                            <label>Status:</label>
//                            <select class="form-control"  name="status">
//                                <option value="1" ${requestScope.data.getStatus()==1 ? 'selected' : '' }>Active</option>
//                                <option value="0" ${requestScope.data.getStatus()==0 ? 'selected' : '' }>In-Active</option>
//                            </select>
//                        </div>
//                    </div>
        
        String status_raw = request.getParameter("statusnew");
        String brandID_raw = request.getParameter("id");
        String brandName = request.getParameter("name");
        String brandDescription = request.getParameter("description");
        int statusnew = -1;
        int brandID = -1;

        String search = "";
        int status = -1;
        int pageNo = 1;
        final int pageSize = 10;
        BrandsDAO brandDAO = new BrandsDAO();
        try {
            statusnew = Integer.parseInt(status_raw);
            brandID = Integer.parseInt(brandID_raw);
            search = request.getParameter("search") == null ? "" : request.getParameter("search");
            status = request.getParameter("status") == null ? -1 : Integer.parseInt(request.getParameter("status"));
            pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));
        } catch (Exception e) {

        }
        brandDAO.updateBrand(brandName, brandDescription, statusnew, brandID);

        response.sendRedirect("brand?search=" + search + "&brandID=" + brandID + "&status=" + status + "&pageNo=" + pageNo);
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

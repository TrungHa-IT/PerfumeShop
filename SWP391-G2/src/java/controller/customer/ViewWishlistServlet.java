/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import Dal.BrandsDAO;
import Dal.CategoriesDAO;
import Dal.ProductDetailDAO;
import Dal.ProductsDAO;
import Dal.WishlistDAO;
import Models.Accounts;
import Models.Brands;
import Models.Categories;
import Models.ProductDetail;
import Models.WishlistItems;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author pna29
 */
public class ViewWishlistServlet extends HttpServlet {

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
            out.println("<title>Servlet ViewWishlistServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewWishlistServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Accounts account = (Accounts) session.getAttribute("account");

        if (account != null) {
            CategoriesDAO categoriesDAO = new CategoriesDAO();
            BrandsDAO brandsDAO = new BrandsDAO();
            WishlistDAO wishlistDAO = new WishlistDAO();
            List<Categories> categories = categoriesDAO.loadCategory();
            List<Brands> brands = brandsDAO.getBrands();
            List<WishlistItems> wishlist = wishlistDAO.getWishlistByAccountId(account.getAccountID());

            request.setAttribute("brands", brands);
            request.setAttribute("categories", categories);
            request.setAttribute("wishlist", wishlist);
            request.getRequestDispatcher("common/viewWishlist.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
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
        HttpSession session = request.getSession();
        Accounts account = (Accounts) session.getAttribute("account");
        int productID = Integer.parseInt(request.getParameter("productID"));
        if (account != null) {
            WishlistDAO wishlistDAO = new WishlistDAO();
            wishlistDAO.removeFromWishlist(account.getAccountID(), productID);
            List<WishlistItems> wishlist = wishlistDAO.getWishlistByAccountId(account.getAccountID());

            request.setAttribute("wishlist", wishlist);
            request.getRequestDispatcher("common/viewWishlist.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
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

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.common;

import Dal.BrandsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Dal.CategoriesDAO;
import Dal.FeedbackDAO;
import Dal.ProductsDAO;
import Dal.SliderDAO;
import Models.Accounts;
import Models.Brands;
import Models.Categories;
import Models.FeedBacks;
import Models.ProductsHome;
import Models.Sliders;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author pna29
 */
public class HomeServlet extends HttpServlet {

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
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
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

        CategoriesDAO categoriesDAO = new CategoriesDAO();
        ProductsDAO productsDAO = new ProductsDAO();
        BrandsDAO brandsDAO = new BrandsDAO();
        SliderDAO sliDAO = new SliderDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        HttpSession session = request.getSession();
        Accounts account = (Accounts) session.getAttribute("account");

        boolean isLoggedIn = (account != null);
        request.setAttribute("isLoggedIn", isLoggedIn);

        List<Sliders> sliders = sliDAO.getAll();
        List<ProductsHome> productsMen = productsDAO.getProductsByCategory(1);
        List<ProductsHome> productsWomen = productsDAO.getProductsByCategory(2);
        List<ProductsHome> productsUnisex = productsDAO.getProductsByCategory(3);
        List<ProductsHome> giftSet = productsDAO.getProductsByCategory(4);
        List<ProductsHome> productsTop5Sellers = productsDAO.getTopBestSellers("5");
        List<Categories> categories = categoriesDAO.loadCategory();
        List<Brands> brands = brandsDAO.getBrands();

        Map<Integer, Integer> productAverageStars = new HashMap<>();
        List<ProductsHome> allProducts = productsMen;
        allProducts.addAll(productsWomen);
        allProducts.addAll(productsUnisex);
        allProducts.addAll(giftSet);
        allProducts.addAll(productsTop5Sellers);

        for (ProductsHome product : allProducts) {
            int averageStars = feedbackDAO.getAverageStartByProductID(product.getProductID());
            productAverageStars.put(product.getProductID(), averageStars);
        }

        request.setAttribute("productAverageStars", productAverageStars);
        session.setAttribute("sliders", sliders);
        request.setAttribute("productsMen", productsMen);
        request.setAttribute("productsWomen", productsWomen);
        request.setAttribute("productsUnisex", productsUnisex);
        request.setAttribute("productGiftset", giftSet);
        request.setAttribute("productsTopSellers", productsTop5Sellers);
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("common/home.jsp").forward(request, response);
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
        doGet(request, response);
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

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.common;

import Dal.AccountsDAO;
import Dal.BrandsDAO;
import Dal.CategoriesDAO;
import Dal.FeedbackDAO;
import Dal.ProductDetailDAO;
import Dal.ProductsDAO;
import Models.Accounts;
import Models.Brands;
import Models.Categories;
import Models.FeedBacks;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import Models.ProductDetail;
import Models.Products;
import Models.ProductsHome;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author admin
 */
public class DetailOfProduct extends HttpServlet {

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
            out.println("<title>Servlet ProductDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetail at " + request.getContextPath() + "</h1>");
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
        String id_raw = request.getParameter("productID");
        int id = -1;
        try {

            id = Integer.parseInt(id_raw);

        } catch (NumberFormatException e) {
            System.out.println("");
        }
        ProductDetailDAO pdtDAO = new ProductDetailDAO();
        ProductsDAO pDAO = new ProductsDAO();
        BrandsDAO bDAO = new BrandsDAO();
        CategoriesDAO cDAO = new CategoriesDAO();
        FeedbackDAO fbDAO = new FeedbackDAO();
        AccountsDAO accDAO = new AccountsDAO();

        List<Categories> categoriehome = cDAO.loadCategory();
        List<Brands> brandhome = bDAO.getBrands();
        Products product = pDAO.getProductByProductID(id);
        Categories categories = cDAO.getCategoryById(product.getCategoryID());
        ProductDetail productDetail = pdtDAO.getProductDetail(id);

        Brands brand = bDAO.getBrandById(product.getBrandID());

        List<ProductDetail> priceandsize = pdtDAO.getPriceAllowSize(id);
        List<ProductsHome> psimilar = pDAO.getProductsByBrand(product.getBrandID());
        List<FeedBacks> feedbacks = fbDAO.getListFeedback(id);
        List<Accounts> listAccount = new ArrayList<>();

        for (FeedBacks listfb : feedbacks) {
            Accounts a = accDAO.getAccoutByID(listfb.getFbAccountID());

            listAccount.add(a);
        }
        int averageStart = fbDAO.getAverageStartByProductID(id);
        int getTotalFeedback = fbDAO.getTotalFeedbackByProductId(id);

        Map<Integer, Integer> productAverageStars = new HashMap<>();
        List<ProductsHome> allProducts = psimilar;

        for (ProductsHome allProduct : allProducts) {
            int averageStars = fbDAO.getAverageStartByProductID(allProduct.getProductID());
            productAverageStars.put(allProduct.getProductID(), averageStars);
        }
         request.setAttribute("productAverageStars", productAverageStars);
        request.setAttribute("categories", categoriehome);
        request.setAttribute("brands", brandhome);
        request.setAttribute("psimilar", psimilar);
        request.setAttribute("priceandsize", priceandsize);

        request.setAttribute("c", categories);
        request.setAttribute("b", brand);
        request.setAttribute("pd", productDetail);
        request.setAttribute("p", product);
        request.setAttribute("fb", feedbacks);
        request.setAttribute("listAccount", listAccount);

        request.setAttribute("averageStart", averageStart);
        request.setAttribute("getTotalFeedback", getTotalFeedback);

        request.getRequestDispatcher("common/productDetail.jsp").forward(request, response);
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
        processRequest(request, response);
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

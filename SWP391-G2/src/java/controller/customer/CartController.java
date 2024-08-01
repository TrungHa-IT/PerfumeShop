/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import Dal.CartsDAO;
import Dal.ProductDetailDAO;
import Models.Accounts;
import Models.Carts;
import Models.ProductDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import javax.mail.Session;
import org.apache.tomcat.util.net.SSLSupport;

/**
 *
 * @author hatru
 */
public class CartController extends HttpServlet {

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
            out.println("<title>Servlet CartController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartController at " + request.getContextPath() + "</h1>");
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
//        HttpSession session = request.getSession();
//        
//        session.invalidate();
        HttpSession session = request.getSession();
        CartsDAO cart = new CartsDAO();
        //String accountID_raw = sessio

        String pdtID_raw = request.getParameter("productfulldetailid");
        String addquantity_raw = request.getParameter("quantity");
        String productName_raw = request.getParameter("productname");
        String deletecart_raw = request.getParameter("deletecard");
        int cartID = -1, pdID = -1, addquantity = -1;

        Accounts accounts = (Accounts) session.getAttribute("account");
        int account = accounts == null ? Integer.parseInt(request.getParameter("accountID")) : accounts.getAccountID();
        try {
            pdID = pdtID_raw != null ? Integer.parseInt(pdtID_raw) : -1;
            addquantity = addquantity_raw != null ? Integer.parseInt(addquantity_raw) : -1;
            //cartID = deletecart_raw != null ? Integer.parseInt(deletecart_raw) :-1;

        } catch (Exception e) {

        }
        if (deletecart_raw != null) {
            cartID = Integer.parseInt(deletecart_raw);
            cart.deleteCart(cartID);
        } else if (cart.checkExist(pdID, account) != null) {
            //Update quantity exist in DB
            int oldQuantity = cart.checkExist(pdID, account).getQuantity();
            cart.updateQuantityProduct(oldQuantity, addquantity, pdID, account);

        } else if (cart.checkExist(pdID, account) == null) {
            //Insert new productdetail in DB
            cart.insetNewCart(pdID, account, addquantity, productName_raw);
        }

        List<Carts> listCart = cart.getCartByAccountID(account);
        ProductDetailDAO productDAO = new ProductDetailDAO();
        List<ProductDetail> listProduct = new ArrayList<>();
        for (Carts carts : listCart) {
            ProductDetail p = productDAO.getInforProductDetail(carts.getProductFullDetailID());
            listProduct.add(p);
        }

        request.setAttribute("listcart", listCart);
        request.setAttribute("listproduct", listProduct);
        request.getRequestDispatcher("common/cart.jsp").forward(request, response);
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
        String productID_raw = request.getParameter("pdID");
        String quantity_raw = request.getParameter("quantity");
        String minus_raw = request.getParameter("minus");
        String add_raw = request.getParameter("add");
        String accountID_raw = request.getParameter("accountID");
        String cartID_raw = request.getParameter("cartID");
        String avaiable_raw = request.getParameter("avaiable");
        String newquantity_raw = request.getParameter("newquantity");
        String delete = request.getParameter("deletecard");
        int productID = 0, quantity = 0, accountID = 0, avaiable = 0, newquantity = 0, cartID = 0;
        HttpSession session = request.getSession();
        try {
            productID = Integer.parseInt(productID_raw);
            quantity = Integer.parseInt(quantity_raw);
            accountID = Integer.parseInt(accountID_raw);
            avaiable = Integer.parseInt(avaiable_raw);
            newquantity = Integer.parseInt(newquantity_raw);
            cartID = Integer.parseInt(cartID_raw);
        } catch (Exception e) {
            System.out.println(e);
        }
        CartsDAO cartDAO = new CartsDAO();
        ProductDetailDAO pdDAO = new ProductDetailDAO();
        if (minus_raw != null) {

            if (quantity == 1) {
                //response.sendRedirect("cartcontroller?accountID=" + accountID_raw);
                //deletecart
                //session.invalidate();
                cartDAO.deleteCart(cartID);
                //response.sendRedirect("cartcontroller?accountID=" + accountID_raw);
            } else {
                //session.invalidate();
                cartDAO.minusQuantity(quantity, productID, accountID);
                //pdDAO.updateAddAvaiableProductDetail(avaiable, productID);
                //response.sendRedirect("cartcontroller?accountID=" + accountID_raw);
            }

        } else if (add_raw != null) {

            if (quantity + 1 > avaiable) {
                //response.sendRedirect("cartcontroller?accountID=" + accountID_raw);
            } else {
                //session.invalidate();
                cartDAO.addQuantity(quantity, productID, accountID);
                //pdDAO.updateAddAvaiableProductDetail(avaiable, productID);
                //response.sendRedirect("cartcontroller?accountID=" + accountID_raw);
            }
        }
//        else if (delete != null) {
//            cartDAO.deleteCart(cartID);
//            response.sendRedirect("cartcontroller?accountID=" + accountID_raw);
//        }
//        else {
//            //cartDAO.updateQuantity(newquantity, productID, accountID);
//                response.sendRedirect("cartcontroller?accountID=" + accountID_raw);
//
//            //response.getWriter().print("success");
//        }
        Accounts accounts = (Accounts) session.getAttribute("account");
        int account = accounts == null ? Integer.parseInt(request.getParameter("accountID")) : accounts.getAccountID();
        CartsDAO cart = new CartsDAO();
        List<Carts> listCart = cart.getCartByAccountID(account);
        ProductDetailDAO productDAO = new ProductDetailDAO();
        List<ProductDetail> listProduct = new ArrayList<>();
        for (Carts carts : listCart) {
            ProductDetail p = productDAO.getInforProductDetail(carts.getProductFullDetailID());
            listProduct.add(p);
        }
        request.setAttribute("listcart", listCart);
        request.setAttribute("listproduct", listProduct);
        request.getRequestDispatcher("common/cart.jsp").forward(request, response);

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

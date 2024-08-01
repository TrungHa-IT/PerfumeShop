/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import Dal.CartsDAO;
import Dal.ProductDetailDAO;
import Models.Cart;
import Models.Carts;
import Models.ProductDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hatru
 */
public class CheckoutController extends HttpServlet {

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
            out.println("<title>Servlet CheckoutController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutController at " + request.getContextPath() + "</h1>");
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
       String r = request.getParameter("r");
       if(r!=null){
           request.setAttribute("error", "Checkout Fail");
       }
        //processRequest(request, response);
        HttpSession session = request.getSession();
        ProductDetailDAO productDAO = new ProductDetailDAO();
        CartsDAO cart = new CartsDAO();
        Cart ca = new Cart();
        List<Carts> listCart = cart.getAllCart();
        List<ProductDetail> listProduct = new ArrayList<>();
        listProduct.clear();
        boolean check = session.getAttribute("account") != null ? true : false;

        if (check) {
            for (Carts carts : listCart) {
                ProductDetail p = productDAO.getInforProductDetail(carts.getProductFullDetailID());
                listProduct.add(p);
            }
        } else {
            ProductDetailDAO d = new ProductDetailDAO();
            List<ProductDetail> list = d.getAll();
            Cookie[] arr = request.getCookies();
            String txt = "";
            if (arr != null) {
                for (Cookie o : arr) {
                    if (o.getName().equals("cart")) {
                        txt = URLDecoder.decode(o.getValue(), StandardCharsets.UTF_8.toString());
                        break;
                    }
                }
            }
            ca = new Cart(txt, list);
            if (!txt.isEmpty()) {
                String[] s = txt.split(",");
                for (String string : s) {
                    String[] i = string.split(":");
                    ProductDetail p = productDAO.getInforProductDetail(Integer.parseInt(i[0]));
                    listProduct.add(p);
                }
            }
        }

        String totalprice_raw = request.getParameter("totalprice");
        if (check) {
            request.setAttribute("listcart", listCart);
        }else{
            request.setAttribute("cookieCart", ca);
        }
        request.setAttribute("listproduct", listProduct);
        request.setAttribute("totalprice", totalprice_raw);
        request.getRequestDispatcher("common/checkout.jsp").forward(request, response);
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

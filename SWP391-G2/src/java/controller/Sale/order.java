/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Sale;

import Dal.CartsDAO;
import Dal.OrderDAO;
import Dal.OrderDetailDAO;
import Dal.ProductDetailDAO;
import Models.Accounts;
import Models.Cart;
import Models.Carts;
import Models.Orders;
import Models.ProductDetail;
import Models.Vouchers;
import Util.Validation;
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
import java.sql.Date;
import java.time.LocalDate;
import javax.mail.Session;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hatru
 */
public class order extends HttpServlet {

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
            out.println("<title>Servlet order</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet order at " + request.getContextPath() + "</h1>");
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
//        String firstName = request.getParameter("firstname");
//        String lastName = request.getParameter("lastname");
//        String phone = request.getParameter("phone");
        request.setCharacterEncoding("UTF-8");
        String total = request.getParameter("total");

        // Chuyển đổi giá trị từ String sang double
        double totalprice = Double.parseDouble(total);

        // Làm tròn số và chuyển đổi sang long
        long amount = Math.round(totalprice);
        response.setContentType("text/html; charset=UTF-8");
        String payment = request.getParameter("payment");
        HttpSession session = request.getSession();
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String city = request.getParameter("selectedCity");
        String district = request.getParameter("selectedDistrict");
        String ward = request.getParameter("selectedWard");
        String note = request.getParameter("note");
        String addressdetails = request.getParameter("addressDetails");
        String address = addressdetails + " " + ward + " " + district + " " + city;
        LocalDate currentDate = LocalDate.now();

        // Tạo các biến LocalDate cho ngày hiện tại
        LocalDate orderDate = currentDate;

        //Chuyển đổi LocalDate thành Date
        Date sqlOrderDate = Date.valueOf(orderDate);

        String paymentMethod = "vnpay";
        int AccountID = -1;
        int voucherID = -1;
        OrderDAO dao = new OrderDAO();
        OrderDetailDAO detailDao = new OrderDetailDAO();
        int orderID = -1;
        boolean checkVou = session.getAttribute("dis") != null ? true : false;
        boolean check = session.getAttribute("account") != null ? true : false;
        Accounts accounts = null;
        accounts = (Accounts) session.getAttribute("account");
        AccountID = accounts != null ? accounts.getAccountID() : -1;
        Orders or = new Orders(AccountID, sqlOrderDate, totalprice, fullName, phone, email, address, paymentMethod, note, 1, -1);

        switch (payment) {
            case "vnpay":
                // Code xử lý cho "vnpay"
                if (checkVou) {
                    or.setVoucherID(voucherID);
                }
                session.setAttribute("order", or);
                request.setAttribute("total", total);
                request.getRequestDispatcher("vnpay").forward(request, response);
                break;
            case "direct":
                // Code xử lý cho "direct"

                //response.getWriter().print(sqlOrderDate);
                request.setAttribute("fullname", fullName);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("note", note);
                request.setAttribute("accountID", AccountID);
                request.setAttribute("city", city);
                request.setAttribute("district", district);
                request.setAttribute("ward", ward);
                request.setAttribute("addressdetails", addressdetails);
                request.setAttribute("method", "Payment on delivery");

//                response.getWriter().println(sqlOrderDate);
//                response.getWriter().println(totalprice);
//                response.getWriter().println(fullName);
//                response.getWriter().println(phone);
//                response.getWriter().println(email);
//                response.getWriter().println(address);
//                response.getWriter().println(note);
//                response.getWriter().println(voucherID);
                CartsDAO cart = new CartsDAO();
                ProductDetailDAO productDAO = new ProductDetailDAO();
                List<ProductDetail> listProduct = new ArrayList<>();
                if (check) {
                    Accounts account = (Accounts) session.getAttribute("account");
                    AccountID = account.getAccountID();
                    if (checkVou) {
                        Vouchers v = (Vouchers) session.getAttribute("dis");
                        voucherID = v.getVoucherID();
                        // Orders o = new Orders(11, sqlOrderDate, 84024.5, "Dinh Khanh Linh", "0944362986", "hatrung03022003@gmail.com", "Khu 12 ngo trang tien phuong xuan la quan tay ho thanh pho ha noi", "Direct", "Hang de vo", 1, 2);

                        Orders order = new Orders(AccountID, sqlOrderDate, totalprice, fullName, phone, email, address, "Payment on delivery", note, 1, voucherID);
                        dao.insertOrder(order);
                    } else {
                        Orders o = new Orders(AccountID, sqlOrderDate, totalprice, fullName, phone, email, address, "Payment on delivery", note, 1, -1);
                        dao.insertOrder(o);
                    }
                    List<Carts> listCart = cart.getAllCart();
                    orderID = dao.getOrderID();
                    for (Carts carts : listCart) {
                        ProductDetail p = productDAO.getInforProductDetail(carts.getProductFullDetailID());
                        listProduct.add(p);
                        detailDao.insertOrderDetail(orderID, carts.getProductFullDetailID(), carts.getQuantity(), p.getProductPrice().floatValue(), carts.getName());
                    }
                    request.setAttribute("listcart", listCart);
                    request.setAttribute("total", totalprice);
                    request.setAttribute("listproduct", listProduct);
                    //response.getWriter().println(AccountID);
                    cart.deleteAllCart(AccountID);
                    session.removeAttribute("dis");
                    request.getRequestDispatcher("./common/order.jsp").forward(request, response);
                } else {
                    Cart ca = new Cart();
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
                    if (checkVou) {
                        Vouchers v = (Vouchers) session.getAttribute("dis");
                        voucherID = v.getVoucherID();
                        Orders order = new Orders(-1, sqlOrderDate, totalprice, fullName, phone, email, address, "Payment on delivery", note, 1, voucherID);
                        dao.insertOrder(order);
                        session.removeAttribute("dis");
                    } else {
                        Orders order = new Orders(-1, sqlOrderDate, totalprice, fullName, phone, email, address, "Payment on delivery", note, 1, -1);
                        dao.insertOrder(order);
                    }
                    ca = new Cart(txt, list);
                    orderID = dao.getOrderID();
                    if (!txt.isEmpty()) {
                        String[] s = txt.split(",");
                        for (String string : s) {
                            String[] i = string.split(":");
                            ProductDetail p = productDAO.getInforProductDetail(Integer.parseInt(i[0]));
                            listProduct.add(p);
                            detailDao.insertOrderDetail(orderID, Integer.parseInt(i[0]), Integer.parseInt(i[1]), p.getProductPrice().floatValue(), i[2]);
                        }
                    }
                    request.setAttribute("cookieCart", ca);
                    request.setAttribute("total", totalprice);
                    request.setAttribute("listproduct", listProduct);

                    //Delete all product in cart cookie
                    if (arr != null) {
                        for (Cookie o : arr) {
                            if (o.getName().equals("cart")) {
                                o.setMaxAge(0);
                                response.addCookie(o);
                                break;
                            }
                        }
                    }
                    request.getRequestDispatcher("./common/order.jsp").forward(request, response);
                }
            //cart.deleteAllCart(AccountID);

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

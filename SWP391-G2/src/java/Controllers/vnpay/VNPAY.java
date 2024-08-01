/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.vnpay;

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
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Response;

/**
 *
 * @author hatru
 */
public class VNPAY extends HttpServlet {

    protected void order(HttpServletRequest request, HttpServletResponse response) throws SecurityException, IOException, ServletException {
        // Code xử lý cho "direct"
        HttpSession session = request.getSession();

        //response.getWriter().print(sqlOrderDate);
        // Code xử lý cho "direct"
        Orders o = (Orders) session.getAttribute("order");
        //response.getWriter().print(sqlOrderDate);
        boolean check = o.getAccountID() == -1 ? false : true;
        request.setAttribute("fullname", o.getOrderContactName());
        request.setAttribute("email", o.getEmail());
        request.setAttribute("phone", o.getOrderPhone());
        request.setAttribute("address", o.getOrderAddress());
        request.setAttribute("note", o.getOrderNote());
        request.setAttribute("accountID", o.getAccountID());
        request.setAttribute("method", "Payment on VNpay");

        CartsDAO cart = new CartsDAO();
        ProductDetailDAO productDAO = new ProductDetailDAO();
        List<ProductDetail> listProduct = new ArrayList<>();
        OrderDAO dao = new OrderDAO();
        OrderDetailDAO detailDao = new OrderDetailDAO();
        int orderID = -1;
        dao.insertOrder(o);
        if (check) {
            List<Carts> listCart = cart.getAllCart();
            orderID = dao.getOrderID();
            for (Carts carts : listCart) {
                ProductDetail p = productDAO.getInforProductDetail(carts.getProductFullDetailID());
                listProduct.add(p);
                detailDao.insertOrderDetail(orderID, carts.getProductFullDetailID(), carts.getQuantity(), p.getProductPrice().floatValue(), carts.getName());
            }
            request.setAttribute("listcart", listCart);
            request.setAttribute("total", o.getOrderTotalPrice());
            request.setAttribute("listproduct", listProduct);
            //response.getWriter().println(AccountID);
            cart.deleteAllCart(o.getAccountID());
            session.removeAttribute("dis");
            request.getRequestDispatcher("./common/order.jsp").forward(request, response);
        } else {
            Cart ca = new Cart();
            ProductDetailDAO d = new ProductDetailDAO();
            List<ProductDetail> list = d.getAll();
            Cookie[] arr = request.getCookies();
            String txt = "";
            if (arr != null) {
                for (Cookie c : arr) {
                    if (c.getName().equals("cart")) {
                        txt = URLDecoder.decode(c.getValue(), StandardCharsets.UTF_8.toString());
                        break;
                    }
                }
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
            request.setAttribute("total", o.getOrderTotalPrice());
            request.setAttribute("listproduct", listProduct);

            //Delete all product in cart cookie
            if (arr != null) {
                for (Cookie c : arr) {
                    if (c.getName().equals("cart")) {
                        c.setMaxAge(0);
                        response.addCookie(c);
                        break;
                    }
                }
            }
            request.getRequestDispatcher("./common/order.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }

            // Check checksum
            String signValue = Config.hashAllFields(fields);
            if (signValue.equals(vnp_SecureHash)) {

                boolean checkOrderId = true; // vnp_TxnRef exists in your database
                boolean checkAmount = true; // vnp_Amount is valid (Check vnp_Amount VNPAY returns compared to the 
                boolean checkOrderStatus = true; // PaymnentStatus = 0 (pending)

                if (checkOrderId) {
                    if (checkAmount) {
                        if (checkOrderStatus) {
                            if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
                                order(request, response);
                                //Here Code update PaymnentStatus = 1 into your Database
                            } else {
                                HttpSession session = request.getSession();
                                Orders o = (Orders) session.getAttribute("order");
                                response.sendRedirect("checkout?totalprice=" + o.getOrderTotalPrice()+"&&r=1");
                            }
                        } else {

                        }
                    } else {

                    }
                } else {

                }
            } else {

            }
        } catch (Exception e) {

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Define the minimum and maximum transaction amounts (in VND)
        long minAmount = 0; // 0 VND
        long maxAmount = 5000000000L; // Example: 50,000,000 VND (depending on bank regulations)

        // Get the total price from the request
        double totalpriceUSD = Double.parseDouble(req.getParameter("total"));

        // Define the exchange rate (1 USD = 25.419 VND)
        double exchangeRate = 25419;

        // Convert the total price from USD to VND and to the smallest unit of currency (dongs)
        long amount = Math.round(totalpriceUSD * exchangeRate);  // Convert dollars to VND

        // Validate the transaction amount
        if (amount < minAmount || amount > maxAmount) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid transaction amount. Amount must be between the minimum limit and the maximum of each bank regulations.");
            return;
        }

        String bankCode = "NCB";

        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";

        String vnp_TxnRef = Config.getRandomNumber(8);
        String vnp_IpAddr = Config.getIpAddress(req);
        String vnp_TmnCode = Config.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount * 100)); // Multiply by 100 to convert to the smallest unit
        vnp_Params.put("vnp_CurrCode", "VND"); // Set the currency code to VND

        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);

        String locate = req.getParameter("language");
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        for (String fieldName : fieldNames) {
            String fieldValue = vnp_Params.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString())).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (!fieldName.equals(fieldNames.get(fieldNames.size() - 1))) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String secureHashInput = hashData.toString();
        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, secureHashInput);
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;

        // Redirect to the payment URL
        resp.sendRedirect(paymentUrl);
    }

}

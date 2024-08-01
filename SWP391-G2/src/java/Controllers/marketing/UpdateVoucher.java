/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.marketing;

import Dal.VouchersDAO;
import Models.Vouchers;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.SecureRandom;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author admin
 */
public class UpdateVoucher extends HttpServlet {

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
            out.println("<title>Servlet UpdateVoucher</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateVoucher at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final int LENGTH = 7;
    private static final SecureRandom random = new SecureRandom();

    public static String generateRandomString() {
        StringBuilder sb = new StringBuilder(LENGTH);
        for (int i = 0; i < LENGTH; i++) {
            int index = random.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(index));
        }
        return sb.toString();
    }

    public boolean isCodeExist(String code) {
        VouchersDAO vouchersDAO = new VouchersDAO();
        List<Vouchers> vouchers = vouchersDAO.getVoucherByName();
        for (Vouchers voucher : vouchers) {
            if (voucher.getCode().equals(code)) {
                return true;
            }
        }
        return false;
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

        int voucherID = -1;

        try {
            voucherID = request.getParameter("voucherID") == null ? -1 : Integer.parseInt(request.getParameter("voucherID"));

        } catch (Exception e) {
        }
        if (voucherID == -1) {
            Date startdate = new Date(System.currentTimeMillis());
            request.setAttribute("startdate", startdate);
            Date createdate = new Date(System.currentTimeMillis());
            request.setAttribute("create", createdate);
            String code;
            do {
                code = generateRandomString();
            } while (isCodeExist(code));

            request.setAttribute("code", code);
        }
        String search = "";
        int status = -1;
        int pageNo = 1;
        final int pageSize = 10;
        try {

        } catch (Exception e) {
            search = request.getParameter("search") == null ? "" : request.getParameter("search");
            status = request.getParameter("status") == null ? -1 : Integer.parseInt(request.getParameter("status"));
            pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));
        }

        VouchersDAO voucherDAO = new VouchersDAO();
        Vouchers voucher = voucherDAO.getVoucherById(voucherID);
        int totalPage = voucherDAO.getTotalPage(status, search, pageSize);
        request.setAttribute("search", search);
        request.setAttribute("status", status);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", pageNo);
        request.setAttribute("voucher", voucher);

        request.getRequestDispatcher("voucher/update-mange-vouchers.jsp").forward(request, response);
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
        String voucherID = request.getParameter("voucherId");
        String statusnew = request.getParameter("statusnew");
        String quantity_raw = request.getParameter("quantity");
        String code = request.getParameter("voucherName");
        String discounts = request.getParameter("discount");
        String CreateDate = request.getParameter("createDate");
        String StartDate = request.getParameter("startDate");
        String EndDate = request.getParameter("endDate");
        VouchersDAO voucherDAO = new VouchersDAO();

        try {
            int id = Integer.parseInt(voucherID);
            int status = Integer.parseInt(statusnew);
            double discount = Double.parseDouble(discounts);
            int quantity = Integer.parseInt(quantity_raw);
            Date create = Date.valueOf(CreateDate);
            Date start = Date.valueOf(StartDate);
            Date end = Date.valueOf(EndDate);
            boolean hasError = false;
            code = code.trim().toUpperCase();
            if (code.isEmpty() || code.matches(".*\\d.*")) {
                if (code.isEmpty()) {
                    request.setAttribute("codeErr", "Code must not be empty or whitespace");
                } else if (code.matches(".*\\d.*")) {
                    request.setAttribute("codeErr", "Code must not contain numbers");
                }
                hasError = true;
            }

            if (end.before(start)) {
                request.setAttribute("dateErr", "End date must be after start date");
                hasError = true;
            }

            if (hasError) {
                request.setAttribute("id", id);
                request.setAttribute("code", code);
                request.setAttribute("discounts", discounts);
                request.setAttribute("startdate", start);
                request.setAttribute("quantity", quantity);
                request.setAttribute("statusnew", statusnew);
                request.setAttribute("enddate", end);
                  request.setAttribute("create", create);

                request.getRequestDispatcher("voucher/update-mange-vouchers.jsp").forward(request, response);
                return;
            } else {
                voucherDAO.UpdateVoucher(code, discount, end, start, quantity, create, status, id);
                response.sendRedirect("voucher");
            }

        } catch (Exception e) {
            response.sendRedirect("voucher");
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

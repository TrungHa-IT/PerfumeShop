/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.marketing;

import Dal.VouchersDAO;
import Models.Vouchers;
import jakarta.el.ELException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 *
 * @author admin
 */
public class VoucherManager extends HttpServlet {

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
            out.println("<title>Servlet VoucherManager</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VoucherManager at " + request.getContextPath() + "</h1>");
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
        int status_new = -1;
        int voucherID = -1;

        try {
            status_new = request.getParameter("statusnew") == null ? -1 : Integer.parseInt(request.getParameter("statusnew"));
            voucherID = request.getParameter("voucherID") == null ? -1 : Integer.parseInt(request.getParameter("voucherID"));
        } catch (Exception e) {
        }

        if (status_new != -1) {
            VouchersDAO voucherDAO = new VouchersDAO();
            voucherDAO.updateStatusVoucher(status_new, voucherID);
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
        String startStr = request.getParameter("start");
        String endStr = request.getParameter("end");
        String start = null;
        String end = null;

        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            if (startStr != null && !startStr.isEmpty()) {
                Date startDate_raw = Date.valueOf(startStr);
                start = dateFormat.format(startDate_raw);
            }
            if (endStr != null && !endStr.isEmpty()) {
                Date end_raw = Date.valueOf(endStr);
                end = dateFormat.format(end_raw);
            }

        } catch (ELException e) {

        }

        VouchersDAO voucherDAO = new VouchersDAO();
        List<Vouchers> listvoucher = voucherDAO.getVouchersByFilter(status, search, pageNo, pageSize, start, end);
        int totalPage = voucherDAO.getTotalPage(status, search, pageSize);

        request.setAttribute("search", search);
        request.setAttribute("status", status);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", pageNo);
        request.setAttribute("listvoucher", listvoucher);
        request.setAttribute("start", start);
        request.setAttribute("end", end);
        request.getRequestDispatcher("voucher/manageVouchers.jsp").forward(request, response);
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
        int status_new = -1;
        int voucherID = -1;
        String statusnew = request.getParameter("statusnew");
        String quantity_raw = request.getParameter("quantity");
        String code = request.getParameter("voucherName");
        String discounts = request.getParameter("discount");
        String StartDate = request.getParameter("startDate");
        String EndDate = request.getParameter("endDate");

        try {
            int status = Integer.parseInt(statusnew);
            double discount = Double.parseDouble(discounts);
            int quantity = Integer.parseInt(quantity_raw);
            Date create = new Date(System.currentTimeMillis());
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
            } else if (isCodeExist(code)) {
                request.setAttribute("codeErr", "Code already exists");
                hasError = true;
            }

            if (end.before(start)) {
                request.setAttribute("dateErr", "End date must be after start date");
                hasError = true;
            }

            if (hasError) {
                request.setAttribute("code", code);
                request.setAttribute("discounts", discounts);
                request.setAttribute("startdate", start);
                request.setAttribute("quantity", quantity);
                request.setAttribute("statusnew", status);
                request.setAttribute("create", create);

                request.getRequestDispatcher("voucher/update-mange-vouchers.jsp").forward(request, response);
                return;
            }
            VouchersDAO voucherDAO = new VouchersDAO();
            voucherDAO.InsertVoucher(code, discount, end, start, quantity, create, status);
        } catch (Exception e) {

        }
        try {
            status_new = request.getParameter("statusnew") == null ? -1 : Integer.parseInt(request.getParameter("statusnew"));
            voucherID = request.getParameter("voucherID") == null ? -1 : Integer.parseInt(request.getParameter("voucherID"));
        } catch (Exception e) {
        }

        if (status_new != -1) {
            VouchersDAO voucherDAO = new VouchersDAO();
            voucherDAO.updateStatusVoucher(status_new, voucherID);
        }
        String search = "";
        int status = -1;
        int pageNo = 1;
        final int pageSize = 10;
        String startStr = request.getParameter("start");
        String endStr = request.getParameter("end");
        String start = null;
        String end = null;

        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            if (startStr != null && !startStr.isEmpty()) {
                Date startDate_raw = Date.valueOf(startStr);
                start = dateFormat.format(startDate_raw);
            }
            if (endStr != null && !endStr.isEmpty()) {
                Date end_raw = Date.valueOf(endStr);
                end = dateFormat.format(end_raw);
            }

        } catch (ELException e) {

        }
        try {
            search = request.getParameter("search") == null ? "" : request.getParameter("search");
            status = request.getParameter("status") == null ? -1 : Integer.parseInt(request.getParameter("status"));
            pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));

        } catch (Exception e) {
        }

        VouchersDAO voucherDAO = new VouchersDAO();
        List<Vouchers> listvoucher = voucherDAO.getVouchersByFilter(status, search, pageNo, pageSize, start, end);
        int totalPage = voucherDAO.getTotalPage(status, search, pageSize);

        request.setAttribute("search", search);
        request.setAttribute("status", status);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", pageNo);
        request.setAttribute("listvoucher", listvoucher);

        request.getRequestDispatcher("voucher/manageVouchers.jsp").forward(request, response);
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

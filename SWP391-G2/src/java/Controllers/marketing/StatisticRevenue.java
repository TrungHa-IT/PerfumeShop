/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.marketing;

import Dal.OrderDAO;
import Dal.ProductDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.DayOfWeek;
import java.time.LocalDate;

/**
 *
 * @author pna29
 */
@WebServlet(name = "StatisticRevenue", urlPatterns = {"/statisticRevenue"})
public class StatisticRevenue extends HttpServlet {

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
            out.println("<title>Servlet StatisticRevenue</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StatisticRevenue at " + request.getContextPath() + "</h1>");
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
        ProductDetailDAO prdDAO = new ProductDetailDAO();
        OrderDAO odDAO = new OrderDAO();
//        int count = prdDAO.countAllProduct();
        int totalmoneyAll = odDAO.getSumRevenue();
        int sumquantitySold = odDAO.getSumQuantitySold();
        int totalDeals = odDAO.getTotalDeals();
        String year_raw = request.getParameter("year");
        String month_raw = request.getParameter("month");
        String from_raw = request.getParameter("from");
        String to_raw = request.getParameter("to");

        LocalDate currentDate = LocalDate.now();
        LocalDate startOfWeek = currentDate.with(DayOfWeek.MONDAY);
        LocalDate endOfWeek = startOfWeek.plusDays(6);
        int startDay = startOfWeek.getDayOfMonth();
        int endDay = endOfWeek.getDayOfMonth();
        int monthValue = startOfWeek.getMonthValue();

        int year = (year_raw == null ? 2024 : Integer.parseInt(year_raw));
        int month = (month_raw == null ? monthValue : Integer.parseInt(month_raw));
        int from = (from_raw == null ? startDay : Integer.parseInt(from_raw));
        int to = (to_raw == null ? endDay : Integer.parseInt(to_raw));

        OrderDAO dao = new OrderDAO();
        double totalMoney1 = dao.totalRevenueByWeek(1, from, to, year, month);
        double totalMoney2 = dao.totalRevenueByWeek(2, from, to, year, month);
        double totalMoney3 = dao.totalRevenueByWeek(3, from, to, year, month);
        double totalMoney4 = dao.totalRevenueByWeek(4, from, to, year, month);
        double totalMoney5 = dao.totalRevenueByWeek(5, from, to, year, month);
        double totalMoney6 = dao.totalRevenueByWeek(6, from, to, year, month);
        double totalMoney7 = dao.totalRevenueByWeek(7, from, to, year, month);

        request.setAttribute("totalMoney1", totalMoney1);
        request.setAttribute("totalMoney2", totalMoney2);
        request.setAttribute("totalMoney3", totalMoney3);
        request.setAttribute("totalMoney4", totalMoney4);
        request.setAttribute("totalMoney5", totalMoney5);
        request.setAttribute("totalMoney6", totalMoney6);
        request.setAttribute("totalMoney7", totalMoney7);

        double totalMoneyMonth1 = dao.totalRevenueMonth(1, year);
        double totalMoneyMonth2 = dao.totalRevenueMonth(2, year);
        double totalMoneyMonth3 = dao.totalRevenueMonth(3, year);
        double totalMoneyMonth4 = dao.totalRevenueMonth(4, year);
        double totalMoneyMonth5 = dao.totalRevenueMonth(5, year);
        double totalMoneyMonth6 = dao.totalRevenueMonth(6, year);
        double totalMoneyMonth7 = dao.totalRevenueMonth(7, year);
        double totalMoneyMonth8 = dao.totalRevenueMonth(8, year);
        double totalMoneyMonth9 = dao.totalRevenueMonth(9, year);
        double totalMoneyMonth10 = dao.totalRevenueMonth(10, year);
        double totalMoneyMonth11 = dao.totalRevenueMonth(11, year);
        double totalMoneyMonth12 = dao.totalRevenueMonth(12, year);

        request.setAttribute("totalMoneyMonth1", totalMoneyMonth1);
        request.setAttribute("totalMoneyMonth2", totalMoneyMonth2);
        request.setAttribute("totalMoneyMonth3", totalMoneyMonth3);
        request.setAttribute("totalMoneyMonth4", totalMoneyMonth4);
        request.setAttribute("totalMoneyMonth5", totalMoneyMonth5);
        request.setAttribute("totalMoneyMonth6", totalMoneyMonth6);
        request.setAttribute("totalMoneyMonth7", totalMoneyMonth7);
        request.setAttribute("totalMoneyMonth8", totalMoneyMonth8);
        request.setAttribute("totalMoneyMonth9", totalMoneyMonth9);
        request.setAttribute("totalMoneyMonth10", totalMoneyMonth10);
        request.setAttribute("totalMoneyMonth11", totalMoneyMonth11);
        request.setAttribute("totalMoneyMonth12", totalMoneyMonth12);
        request.setAttribute("year", year);

        request.setAttribute("totalDeals", totalDeals);
        request.setAttribute("totalmoneyAll", totalmoneyAll);
        request.setAttribute("sumquantitySold", sumquantitySold);
//        request.setAttribute("countProduct", count);
        request.getRequestDispatcher("marketing/statistic-revenue.jsp").forward(request, response);
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

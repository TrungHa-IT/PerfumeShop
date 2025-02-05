/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.common;

import Dal.AccountsDAO;
import Dal.AddressDAO;
import Models.Accounts;
import Models.Address;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author ROG
 */
public class AddressDetail extends HttpServlet {

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
            out.println("<title>Servlet AddressDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddressDetail at " + request.getContextPath() + "</h1>");
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
        int accountid = account.getAccountID();
        Address address = new Address();
        AddressDAO addressdao = new AddressDAO();
        

        request.getRequestDispatcher("common/addressdetail.jsp").forward(request, response);
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
        String emaill = account.getEmail();
        AccountsDAO Accdao = new AccountsDAO();
        Accounts acc = Accdao.getAccount(emaill);
        int accountid = acc.getAccountID();
        AddressDAO addressdao = new AddressDAO();
        Address address = new Address();
        String phone = request.getParameter("phone");
        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String homeaddress = request.getParameter("homeaddress");
        String button = request.getParameter("save");
        boolean status = request.getParameter("status") != null;
        try {

            if (button != null) {
                address.setAccountId(accountid);
                if (isValidPhone(phone)) {
                    address.setPhone(phone);
                   address.setCity(city);
                address.setDistrict(district);
                address.setWards(ward);
                address.setAddressLine(homeaddress);
                if (status) {
                    address.setStatus(1);
                } else {
                    address.setStatus(0);
                }
                 addressdao.setInsertAddress(address);
                response.sendRedirect("./AddressMain");
                } else {
                    request.setAttribute("mess", "phone number fail syntax");
                    request.getRequestDispatcher("common/addressdetail.jsp").forward(request, response);
                }

               
            }
        } catch (Exception e) {
            response.getWriter().print(e.getMessage());
        }

    }
    private static final String PHONE_REGEX = "^\\(?(\\+\\d{1,3})?\\)?[-.\\s]?\\d{3}[-.\\s]?\\d{3}[-.\\s]?\\d{4}$";

    public boolean isValidPhone(String phone) {
        Pattern pattern = Pattern.compile(PHONE_REGEX);
        Matcher matcher = pattern.matcher(phone);
        return matcher.matches();
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

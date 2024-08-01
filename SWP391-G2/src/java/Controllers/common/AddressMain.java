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
import java.util.List;

/**
 *
 * @author ROG
 */
public class AddressMain extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet AddressMain</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddressMain at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
        String emaill = account.getEmail();
        AccountsDAO Accdao = new AccountsDAO();
        Accounts acc = Accdao.getAccount(emaill);
        int accountid = acc.getAccountID();
        AddressDAO addressdao = new AddressDAO();
        List<Address> addresslist = addressdao.getAllAddress(accountid);
        request.setAttribute("address", addresslist);
        request.getRequestDispatcher("common/addressmain.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//            HttpSession session = request.getSession();
//        Accounts account = (Accounts) session.getAttribute("account");
//        int accountid = account.getAccountID();
//        AddressDAO Addressdao = new AddressDAO();
//        Address address = Addressdao.getAdress(accountid);
//
//        String phone = request.getParameter("phone");
//        String city = request.getParameter("city");
//        String district = request.getParameter("district");
//        String homeaddress = request.getParameter("homeaddress");
//        String button = request.getParameter("save");
//        boolean status = request.getParameter("status") != null;
//        try {
//
//            if (button != null) {
//                if (isValidPhone(phone)) {
//                    address.setPhone(phone);
//                } else {
//                    request.setAttribute("mess", "phone number fail syntax");
//                }
//                address.setCity(city);
//                address.setDistrict(district);
//                address.setAddress_line(homeaddress);
//                if (status) {
//                    address.setStatus(1);
//                } else {
//                    address.setStatus(0);
//                }
//                Addressdao.setInsertAddress(address);
//                request.setAttribute("address", address);
//                request.getRequestDispatcher("addressdetail.jsp").forward(request, response);
//            }
//        } catch (Exception e) {
//            response.getWriter().print(e.getMessage());
//        }

    
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

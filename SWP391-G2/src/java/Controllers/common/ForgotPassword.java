/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers.common;

import Dal.AccountsDAO;
import Models.Accounts;
import Util.Security;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import javax.mail.Session;

/**
 *
 * @author ROG
 */
public class ForgotPassword extends HttpServlet {
   
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
            out.println("<title>Servlet FogotPassword</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FogotPassword at " + request.getContextPath () + "</h1>");
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
        String email = (String)session.getAttribute("email");
        if(email == null){
            response.sendRedirect(request.getContextPath()+"/login");
        }else{
            request.getRequestDispatcher("common/forgotpassword.jsp").forward(request, response);
        }     
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
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        
        AccountsDAO Accdao = new AccountsDAO();
        String button = request.getParameter("save");
        
        Security security = new Security();

        String newpassword = request.getParameter("newpass");
        String confirmpassword = request.getParameter("confirmpass");
        try {
            if (button != null) {
                    if (CheckPass(newpassword)) {
                        if (confirmpassword.equals(newpassword)) {
                            Accdao.updatePassWord(security.getPasswordSecurity(newpassword), email);
                            session.removeAttribute("email");
                            request.getRequestDispatcher("login.jsp").forward(request, response);                           
                        } else {
                            request.setAttribute("mess2", "Confirm password Not Correct");
                            request.getRequestDispatcher("common/forgotpassword.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("mess1", "Password is not in correct format");
                        request.getRequestDispatcher("common/forgotpassword.jsp").forward(request, response);
                    }
                }
        } catch (Exception e) {
            e.printStackTrace();
        }


    
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
   
    
    public boolean CheckPass(String password) {
        boolean islower = false;
        boolean isupper = false;
        boolean isNumber = false;
        boolean isspecital = false;
        if (password.length() < 8) {
            return false;
        }
        for (char p : password.toCharArray()) {
            if (Character.isUpperCase(p)) {
                islower = true;
            } else if (Character.isLowerCase(p)) {
                isupper = true;
            } else if (Character.isDigit(p)) {
                isNumber = true;
            } else {
                isspecital = true;
            }
        }
        if (password.contains(" ")) {
            return false;
        }
        return isNumber && islower && isspecital && isupper;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

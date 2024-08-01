/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.email;

import Dal.AccountsDAO;
import Models.Accounts;
import Util.Email;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;

/**
 *
 * @author nguye
 */
public class EmailService extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Accounts account = (Accounts) session.getAttribute("accountForSign");
        Email e = new Email();

        String otps = String.valueOf(e.randomOTP());
        String sub = e.subjectEmail();

        session.setAttribute("otpmain", otps);
        session.setAttribute("otpTime", new Date());

        String sendOTP = e.SendOTP(account.getEmail(), otps);
        e.sendEmail(sub, sendOTP, account.getEmail());
        response.getWriter().print("d");
        response.sendRedirect("common/email.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AccountsDAO Adao = new AccountsDAO();
        HttpSession session = request.getSession();

        // get OTP from user
        String otp = request.getParameter("OTP");
        // get OTP send for user
        String ots = (String) session.getAttribute("otpmain");
        Date otpTime = (Date) session.getAttribute("otpTime");
        Date currentTime = new Date();
        long timeElapsedInSeconds = (currentTime.getTime() - otpTime.getTime()) / 1000;
        if (timeElapsedInSeconds <= 120) {
            // Compare both OTP
            if (otp.equals(ots)) {
                Accounts account = (Accounts) session.getAttribute("accountForSign");
                Adao.setInsert(account);
                response.sendRedirect("login");
            } else {
                request.setAttribute("err", "OTP is incorrect!!");
                request.getRequestDispatcher("common/email.jsp").forward(request, response);
            }
        } else {

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

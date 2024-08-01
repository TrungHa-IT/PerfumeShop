/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.common;

import Dal.AccountsDAO;
import Models.Accounts;
import Util.Security;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author nguye
 */
public class Login extends HttpServlet {

    /**
     * This function use for logout function
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("account") != null) {
            rememberMe(request, response);
        }
        session.invalidate();
        request.getRequestDispatcher("common/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountsDAO Adao = new AccountsDAO();
        Security security = new Security();
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        boolean remember = request.getParameter("remember") != null;
        String password = request.getParameter("password");
        Accounts account = Adao.getAccount(email);
        request.setAttribute("email", email);
        try {
            if (account != null) {

                if (account.getStatus() == 1) {
                    if (account.getPassword().equals(security.getPasswordSecurity(password))) {
                        session.setAttribute("account", account);
                        Cookie cookieEmail = new Cookie("em", email);
                        cookieEmail.setMaxAge(36000);
//                        cookieEmail.setSecure(true);
                        response.addCookie(cookieEmail);
                        if (remember) {
                            Cookie cookiePassword = new Cookie("cp", password);
                            cookiePassword.setMaxAge(30);
                            cookiePassword.setSecure(true);
                            response.addCookie(cookiePassword);
                            session.setAttribute("save", "1");
                        }
                        switch (account.getRoleID()) {
                            case 4 ->
                                response.sendRedirect("home");
                            case 3 ->
                                response.sendRedirect("marketing-manager-products");
                            case 2 ->
                                response.sendRedirect("saleorder");
                            case 1 ->
                                response.sendRedirect("admincontrolaccount");
                        }
                    } else {
                        throw new Exception("Password is incorrect, please check again!!");
                    }
                } else {
                    throw new Exception("Your account was ban please enter another account!!");
                }
            } else {
                throw new Exception("email is not exsit, please check agian!");
            }
        } catch (Exception e) {
            request.setAttribute("err", e.getMessage());
            request.getRequestDispatcher("common/login.jsp").forward(request, response);
        }
    }

    protected void rememberMe(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Cookie arrayCookie[] = request.getCookies();
        for (Cookie cookie : arrayCookie) {
            if (cookie.getName().equals("em")) {
                request.setAttribute("email", cookie.getValue());
                continue;
            }
            if (cookie.getName().equals("cp")) {
                if (session.getAttribute("save") != null) {
                    request.setAttribute("password", cookie.getValue());
                } else {
                    cookie.setMaxAge(0);
                }
            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

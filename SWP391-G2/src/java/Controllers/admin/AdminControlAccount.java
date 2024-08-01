/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.admin;

import Dal.AccountsDAO;
import Dal.RoleDAO;
import Models.Accounts;
import Models.AccountsEmployee;
import Models.Role;
import Util.Security;
import Util.Validation;
import static Util.Validation.isValidFirstName;
import static Util.Validation.isValidLastName;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 *
 * @author hatru
 */
public class AdminControlAccount extends HttpServlet {

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
            out.println("<title>Servlet AdminControlAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminControlAccount at " + request.getContextPath() + "</h1>");
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
        session.setAttribute("role", 1);
        //processRequest(request, response);
        //String status_raw = request.getParameter("statusnew");
        //String accountID_raw = request.getParameter("accountID");
        int status_new = -1;
        int accountID = -1;
        try {
            status_new = request.getParameter("statusnew") == null ? -1 : Integer.parseInt(request.getParameter("statusnew"));
            accountID = request.getParameter("accountID") == null ? -1 : Integer.parseInt(request.getParameter("accountID"));
        } catch (Exception e) {
        }

        if (status_new != -1) {
            AccountsDAO dao = new AccountsDAO();
            dao.updateStatusAccount(status_new, accountID);
        }

        String search = "";
        int roleId = -1;
        int status = -1;
        int pageNo = 1;
        final int pageSize = 10;
        try {

            search = request.getParameter("search") == null ? "" : request.getParameter("search");
            roleId = request.getParameter("roleId") == null ? -1 : Integer.parseInt(request.getParameter("roleId"));
            status = request.getParameter("status") == null ? -1 : Integer.parseInt(request.getParameter("status"));
            pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));

        } catch (Exception e) {
        }
        AccountsDAO daoAccount = new AccountsDAO();
        List<Accounts> listAccount = daoAccount.getListByFilter(roleId, status, search, pageNo, pageSize);
        int totalPage = daoAccount.getTotalPage(roleId, status, search, pageSize);
        RoleDAO daoRole = new RoleDAO();
        List<Role> listRole = daoRole.getAllRoles();

        request.setAttribute("search", search);
        request.setAttribute("roleId", roleId);
        request.setAttribute("status", status);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", pageNo);

        request.setAttribute("listUser", listAccount);
        request.setAttribute("listRole", listRole);
        request.getRequestDispatcher("admin/admin.jsp").forward(request, response);
        //response.getWriter().print(listAccount.get(0).toString());
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
        PrintWriter out = response.getWriter();
        AccountsDAO dao = new AccountsDAO();
        Validation valid = new Validation();
        RoleDAO roledao = new RoleDAO();
        List<Role> listRole = roledao.getAllRolesSaleMarket();

        String search = "";
        int roleId = -1;
        int status = -1;
        int pageNo = 1;
        final int pageSize = 10;
        try {

            search = request.getParameter("search") == null ? "" : request.getParameter("search");
            //roleId = request.getParameter("roleId") == null ? -1 : Integer.parseInt(request.getParameter("roleId"));
            status = request.getParameter("status") == null ? -1 : Integer.parseInt(request.getParameter("status"));
            pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));

        } catch (Exception e) {
        }

        String password = request.getParameter("password");
        String email = request.getParameter("email");

        try {
            Accounts account = dao.getAccount(email);
            if (account == null) {
                String firstName = request.getParameter("firstname");
                if (isValidFirstName(firstName) == false) {
                    request.setAttribute("error", "firstname is wrong format!");
                    request.setAttribute("listRole", listRole);
                    request.getRequestDispatcher("admin/adminadd.jsp").forward(request, response);
                }
                String lastName = request.getParameter("lastname");
                if (isValidLastName(lastName) == false) {
                    request.setAttribute("error", "lastname is wrong format!");
                    request.setAttribute("listRole", listRole);
                    request.getRequestDispatcher("admin/adminadd.jsp").forward(request, response);
                }
                if (!valid.CheckPass(password)) {
                    request.setAttribute("error", "Password must containsAt least 8 characters length At least 1 number (0..9) At least 1 lowercase letter (a..z)At least 1 special symbol (!..$)At least 1 uppercase letter (A..Z)");
                    request.setAttribute("listRole", listRole);
                    request.getRequestDispatcher("admin/adminadd.jsp").forward(request, response);
                }
                String image = "";
// Removed unnecessary parts for brevity

                String gender1 = request.getParameter("gender");

                String roleID1 = request.getParameter("roleId");

                int roleID = -1;
                int gender = -1;

                try {

                    roleID = Integer.parseInt(roleID1);
                    gender = Integer.parseInt(gender1);
                } catch (NumberFormatException e) {
                    System.out.println(e);
                }
                String datebirthday = request.getParameter("birthDate");
                Date createdate = new Date(System.currentTimeMillis());

// Add debugging information
                SimpleDateFormat formatdate = new SimpleDateFormat("yyyy-MM-dd");
                Security security = new Security();

                java.util.Date utilDate = formatdate.parse(datebirthday);
                Date birthday = new Date(utilDate.getTime());
                String p = security.getPasswordSecurity(password);
                Accounts a = new Accounts(firstName, lastName, p, image, gender, birthday, email, 1, createdate, roleID);

//                response.getWriter().println(firstName);
//                response.getWriter().println(lastName);
//                response.getWriter().println(p);
//                response.getWriter().println(gender);
//                response.getWriter().println(birthday);
//                response.getWriter().println(email);
//                response.getWriter().println(createdate);
//                response.getWriter().println(roleID);
                dao.setInsert(a);

            } else {
                request.setAttribute("error", "Email already exist!");
                request.setAttribute("listRole", listRole);
                request.getRequestDispatcher("admin/adminadd.jsp").forward(request, response);
            }
            response.getWriter().println(email);
        } catch (Exception e) {

        }
        //response.getWriter().print(email);

        //List<Accounts> listAccount = dao.getListAdminByFilter(roleId, status, search, pageNo, pageSize);
        List<Accounts> listAccount = dao.getListByFilter(roleId, status, search, pageNo, pageSize);
        int totalPage = dao.getTotalPage(roleId, status, search, pageSize);
       
        request.setAttribute("search", search);
        request.setAttribute("roleId", roleId);
        request.setAttribute("status", status);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", pageNo);
        request.setAttribute("listUser", listAccount);
        request.setAttribute("listRole", listRole);
        request.getRequestDispatcher("admin/admin.jsp").forward(request, response);
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

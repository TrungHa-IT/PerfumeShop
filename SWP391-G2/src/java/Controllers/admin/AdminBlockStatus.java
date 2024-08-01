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
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author hatru
 */
public class AdminBlockStatus extends HttpServlet {
   
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
            out.println("<title>Servlet AdminBlockStatus</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminBlockStatus at " + request.getContextPath () + "</h1>");
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
        //processRequest(request, response);
        String status_raw = request.getParameter("statusnew");
        String accountID_raw = request.getParameter("accountID");
        
        int status_new = -1;
        int accountID = -1;
        try {
            status_new = Integer.parseInt(status_raw);
            accountID = Integer.parseInt(accountID_raw);
        } catch (Exception e) {
        }
        AccountsDAO dao = new AccountsDAO();
        dao.updateStatusAccount(status_new, accountID);

        //request.setAttribute("search", search_raw);
       // request.setAttribute("roleId", roleID_raw);
        //request.setAttribute("status", statusnow_raw);
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
//           response.getWriter().println(search_raw);
//           response.getWriter().print(statusnow_raw);
        //response.getWriter().print(currentpage_raw);
        //response.sendRedirect("admincontrolaccount");
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
        processRequest(request, response);
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

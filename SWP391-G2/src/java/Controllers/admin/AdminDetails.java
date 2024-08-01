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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

/**
 *
 * @author hatru
 */
@MultipartConfig
public class AdminDetails extends HttpServlet {

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
            out.println("<title>Servlet AdminDetails</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminDetails at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        int accountID = Integer.parseInt(request.getParameter("id"));
        int roleID = Integer.parseInt(request.getParameter("roleID"));
        AccountsDAO dao = new AccountsDAO();
        RoleDAO daoRole = new RoleDAO();

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

            request.setAttribute("search", search);
            request.setAttribute("roleId", roleId);
            request.setAttribute("status", status);
            request.setAttribute("currentPage", pageNo);
        } catch (Exception e) {
        }
        if (roleID == 1 || roleID == 4) {
            Accounts account = dao.getAccoutByID(accountID);
            List<Role> listRole = daoRole.getAllRolesByID(roleID);
            request.setAttribute("listRole", listRole);
            //request.setAttribute("status", 1);
            request.setAttribute("data", account);

        } else {
            Accounts account = dao.getAccoutByID(accountID);
            List<Role> listRole = daoRole.getAllRolesSaleMarket();
            request.setAttribute("listRole", listRole);
            //request.setAttribute("status", 1);
            request.setAttribute("data", account);

        }
        request.getRequestDispatcher("admin/admindetails.jsp").forward(request, response);
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
        //processRequest(request, response);

        String roleID_raw = request.getParameter("roleIDnew");
        String status_raw = request.getParameter("statusnew");
        String accountID_raw = request.getParameter("id");
        int roleID = -1;
        int statusnew = -1;
        int accountID = -1;

        String search = "";
        int roleId = -1;
        int status = -1;
        int pageNo = 1;
        final int pageSize = 10;
        AccountsDAO dao = new AccountsDAO();
        String imageURL = "";
        String filename = "";
        try {
            roleID = Integer.parseInt(roleID_raw);
            statusnew = Integer.parseInt(status_raw);
            accountID = Integer.parseInt(accountID_raw);
            search = request.getParameter("search") == null ? "" : request.getParameter("search");
            roleId = request.getParameter("roleId") == null ? -1 : Integer.parseInt(request.getParameter("roleId"));
            status = request.getParameter("status") == null ? -1 : Integer.parseInt(request.getParameter("status"));
            pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));

            Part part = request.getPart("img");
            String realPath = request.getServletContext().getRealPath("/images/Account");
            String source = Path.of(part.getSubmittedFileName()).getFileName().toString();
            if (!source.isEmpty()) {
                filename = accountID + ".png";

                if (!Files.exists(Path.of(realPath))) {
                    Files.createDirectory(Path.of(realPath));
                }

                part.write(realPath + "/" + filename);
                response.getWriter().print(imageURL);
            }
        } catch (Exception e) {

        }

        dao.updateAccount(statusnew, roleID, filename, accountID);
        response.sendRedirect("./admincontrolaccount?search=" + search + "&roleId=" + roleId + "&status=" + status + "&pageNo=" + pageNo);
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

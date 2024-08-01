/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.marketing.blog;

import Dal.BlogDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author TNO
 */
@WebServlet(name = "deleteBlogController", urlPatterns = {"/deleteBlog"})
public class deleteBlogController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            BlogDAO blogDAO = new BlogDAO();
            if (blogDAO.deleteBlog(id, 0)) {
                response.sendRedirect("manageBlog");
            } else {
                throw new Exception("Delete Failed");
            }
        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
        } catch (Exception ex) {
            Logger.getLogger(deleteBlogController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}

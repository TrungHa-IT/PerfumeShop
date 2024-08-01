/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.marketing;

import Dal.SliderDAO;
import Models.Sliders;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author pna29
 */
public class MakertingManageSlider extends HttpServlet {

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

        SliderDAO sliDAO = new SliderDAO();
        List<Sliders> slider = sliDAO.getAllActiveStatus();
        String nameSearch = request.getParameter("nameSearch");
        String statusStr = request.getParameter("status");
        Integer status = null;
        if (statusStr != null && !statusStr.isEmpty()) {
            status = Integer.parseInt(statusStr);
        }

        //Paging
        int page = 1, numberPage = 5;
        int size = slider.size();
        int numberpage = ((size % numberPage == 0) ? (size / 5) : (size / 5) + 1);
        String xpage = request.getParameter("page");
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start, end;
        start = (page - 1) * 5;
        end = Math.min(page * numberPage, size);
        List<Sliders> listByPage = sliDAO.getListByPage(slider, start, end);
        if (nameSearch != null && !nameSearch.isEmpty()) {
            listByPage = sliDAO.searchSlidersByTitle(nameSearch);
        }

        request.setAttribute("searchValue", nameSearch);
        request.setAttribute("listByPage", listByPage);
        request.setAttribute("page", page);
        request.setAttribute("start", start);
        request.setAttribute("end", end);
        request.setAttribute("numberpage", numberpage);
        request.setAttribute("sliderList", slider);
        request.getRequestDispatcher("marketing/marketing-manage-sliders.jsp").forward(request, response);
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
        int status = -1;
        try {
            status = request.getParameter("status") == null ? -1 : Integer.parseInt(request.getParameter("status"));
        } catch (Exception e) {
            // Handle exception
        }

        SliderDAO sliDAO = new SliderDAO();
        List<Sliders> slider;

        if (status == -1) {
            slider = sliDAO.getAllActiveStatus();
        } else {
            slider = sliDAO.searchSlidersByStatus(status);
        }

// Paging
        int page = 1, numberPage = 5;
        int size = slider.size();
        int numberpage = ((size % numberPage == 0) ? (size / 5) : (size / 5) + 1);
        String xpage = request.getParameter("page");
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start = (page - 1) * 5;
        int end = Math.min(page * numberPage, size);
        List<Sliders> listByPage = sliDAO.getListByPage(slider, start, end);

        request.setAttribute("listByPage", listByPage);
        request.setAttribute("page", page);
        request.setAttribute("start", start);
        request.setAttribute("end", end);
        request.setAttribute("numberpage", numberpage);
        request.setAttribute("sliderList", slider);
        request.setAttribute("status", status);
        request.getRequestDispatcher("marketing/marketing-manage-sliders.jsp").forward(request, response);

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

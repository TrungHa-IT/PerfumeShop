/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.marketing;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import Dal.SliderDAO;
import Models.Sliders;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;

/**
 *
 * @author pna29
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
@WebServlet(name = "MarketingManageSliderDetail", urlPatterns = {"/sliderDetails"})
public class MarketingManageSliderDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("sliderId");
        SliderDAO dao = new SliderDAO();
        Sliders slider = dao.getSliderById(Integer.parseInt(id));
        request.setAttribute("slider", slider);
        request.getRequestDispatcher("marketing/marketing-manage-sliderDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");

        String uploadFolder = getServletContext().getRealPath("") + "../../web/images/Sliders/";

        File folder = new File(uploadFolder);
        if (!folder.exists()) {
            folder.mkdirs();
        }

        Part filePart = request.getPart("image");
        String fileName ="images/Sliders/slider" + id + ".jpg";
        OutputStream out = null;
        InputStream fileContent = null;

        try {
            out = new FileOutputStream(new File(uploadFolder + File.separator + fileName));
            fileContent = filePart.getInputStream();
            int read = 0;
            final byte[] bytes = new byte[1024];

            while ((read = fileContent.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (out != null) {
                out.close();
            }
            if (fileContent != null) {
                fileContent.close();
            }
        }

        String title = request.getParameter("title");
        String status = request.getParameter("status");
        String accountIdStr = request.getParameter("accountId");

        // Create a current Date object for updatedAt
        Date updateAt = new Date();

        Sliders slider = new Sliders();
        slider.setSliderID(Integer.parseInt(id));
        slider.setSliderImage(fileName);
        slider.setSliderTitle(title);
        slider.setSliderStatus(Integer.parseInt(status));
        slider.setUpdateAt(updateAt);

        if (accountIdStr != null && !accountIdStr.isEmpty()) {
            slider.setAccountId(Integer.valueOf(accountIdStr));
        } else {
            slider.setAccountId(null); // Set null if accountId is not provided
        }

        new SliderDAO().updateSlider(slider);

        response.sendRedirect("manageSlider");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

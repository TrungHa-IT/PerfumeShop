/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.marketing.blog;

import Dal.BlogDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
@WebServlet(name = "UpdateBlogController", urlPatterns = {"/updateBlog"})
public class UpdateBlogController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String brief = request.getParameter("brief");
        String content = request.getParameter("descriptionBlog");
        int status = Integer.parseInt(request.getParameter("status"));

        Part filePart = request.getPart("thumbnail");
        String fileName = getSubmittedFileName(filePart);
        int updateImageMode = 0;
        String imgPath = "";
        BlogDAO blogDAO = new BlogDAO();
        String msg = "";

        if (!(fileName.isEmpty())) {
            updateImageMode = 1;

            String uploadFolder = getServletContext().getRealPath("") + "../../web/images";

            File folder = new File(uploadFolder);
            if (!folder.exists()) {
                folder.mkdirs();
            }
            imgPath = "images/" + fileName;

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

            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            } finally {
                if (out != null) {
                    out.close();
                }
                if (fileContent != null) {
                    fileContent.close();
                }
            }

            if (blogDAO.updateBlog(id, title, brief, content, status, imgPath, updateImageMode)) {
                msg = "Update successfully!";
            } else {
                msg = "Update failed!";
            }

        } else {
            updateImageMode = 0;
            if (blogDAO.updateBlog(id, title, brief, content, status, imgPath, updateImageMode)) {
                msg = "Update successfully!";
            } else {
                msg = "Update failed!";
            }
        }
        request.setAttribute("msg", msg);
        response.sendRedirect("formInforBlog?id=" + id);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

}

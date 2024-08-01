/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.common;

import Dal.AccountsDAO;
import Dal.AddressDAO;
import Models.Accounts;
import Models.Address;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;

/**
 *
 * @author ROG
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class Profile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Accounts account = (Accounts) session.getAttribute("account");
        String emaill = account.getEmail();
        AccountsDAO Accdao = new AccountsDAO();
        Accounts acc = Accdao.getAccount(emaill);
        int accountid = acc.getAccountID();
        AddressDAO addressDAO = new AddressDAO();
        Address address = addressDAO.getAddressByStatus(accountid);
        request.setAttribute("address", address);
        request.setAttribute("profile", acc);
        request.getRequestDispatcher("common/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Accounts account = (Accounts) session.getAttribute("account");
        String emaill = account.getEmail();
        AccountsDAO Accdao = new AccountsDAO();
        Accounts acc = Accdao.getAccount(emaill);

        String firstName = request.getParameter("firstname").trim();
        String lastName = request.getParameter("lastname").trim();
        String gender = request.getParameter("gender");
        String birthday = request.getParameter("birth");
        String button = request.getParameter("save");
        Part filePart = request.getPart("img");

        //upload image start
        String uploadFolder = getServletContext().getRealPath("") + "../../web/images/Account/";

        File folder = new File(uploadFolder);
        if (!folder.exists()) {
            folder.mkdirs();
        }

        String fileName = "";
        OutputStream out = null;
        InputStream fileContent = null;
        if (filePart != null) {
            try {
                fileName = String.valueOf(acc.getAccountID()) + ".jpg";
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
        }

        //end upload
        try {
            SimpleDateFormat formatdate = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilDate = formatdate.parse(birthday);
            Date dob = new Date(utilDate.getTime());
            if (button != null) {

                acc.setFirstName(firstName);
                acc.setLastName(lastName);

                acc.setGender(Integer.parseInt(gender));
                acc.setBirthDay(dob);
                if (!fileName.isEmpty()) {
                    acc.setImage(fileName);
                }
                acc.setEmail(emaill);
            }
            Accdao.updateProfile(acc);
            request.setAttribute("profile", acc);
            request.getRequestDispatcher("common/profile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
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

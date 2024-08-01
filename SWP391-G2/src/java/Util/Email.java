/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Util;

import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author nguye
 */
public class Email {

    public int randomOTP() {
        Random random = new Random();
        return random.nextInt(900000) + 100000;
    }
    private final String emailFrom = "bichnqhe173220@fpt.edu.vn";
    private final String emailPass = "tuiacsucdmecoivn";

    public void sendEmail(String subject, String messgage, String to) {
        try {

        } catch (Exception e) {
        }
        // Properties
        Properties props = new Properties();

        //Su dung server nao de gui mail- smtp host
        props.put("mail.smtp.host", "smtp.gmail.com");

        // TLS 587 SSL 465
        props.put("mail.smtp.port", "587");

        // dang nhap
        props.put("mail.smtp.auth", "true");

        props.put("mail.smtp.starttls.enable", "true");

        //dang nhap tai khoan
        Authenticator au = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(emailFrom, emailPass);
            }

        };
        // phien lam viec
        Session session = Session.getInstance(props, au);

        try {
            MimeMessage msg = new MimeMessage(session);
            //kieu noi dung
            msg.addHeader("Content-type", "text/HTML, charset=UTF-8");
            //nguoi gui
            msg.setFrom(new InternetAddress(emailFrom));
            //nguoi nhan 
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            // tieu de
            msg.setSubject(subject, "UTF-8");
            // Noi dung
            msg.setContent(messgage, "text/html; charset=UTF-8");
            // Gui email
            Transport.send(msg);
        } catch (MessagingException e) {

            System.out.println("Send email failed");
            System.err.println(e);
        }
    }

    public static void main(String[] args) {
        Email e = new Email();
        System.out.println(e.randomOTP());
        String otps = String.valueOf(e.randomOTP());
        String su = e.subjectEmail();
        e.sendEmail(su, otps, "bichnqhe173220@fpt.edu.vn");
    }

    public Email() {

    }

    public String subjectEmail() {
        return "The Perfume Shop - Verify your recovery email";
    }

    public String SendOTP(String email, String OTP) {
        return "<!DOCTYPE html>\n"
                + "<html>\n"
                + "<head>\n"
                + "  <title>The perfume shop Email</title>\n"
                + "  <style>\n"
                + "    body {\n"
                + "      font-family: Arial, sans-serif;\n"
                + "      margin: 0;\n"
                + "      padding: 0;\n"
                + "      background-color: #f4f4f4;\n"
                + "    }\n"
                + "\n"
                + "    .container {\n"
                + "      width: 500px;\n"
                + "      margin: 100px auto;\n"
                + "      background-color: #fff;\n"
                + "      padding: 30px;\n"
                + "      border-radius: 5px;\n"
                + "      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);\n"
                + "    }\n"
                + "\n"
                + "    h1 {\n"
                + "      color: pink;\n"
                + "      text-align: center;\n"
                + "      margin-bottom: 20px;\n"
                + "    }\n"
                + "    h2{\n"
                + "    text-align: center;\n"
                + "    }\n"
                + "\n"
                + "    p {\n"
                + "      line-height: 1.6;\n"
                + "      margin-bottom: 15px;\n"
                + "    }\n"
                + "\n"
                + "    .code {\n"
                + "      font-size: 24px;\n"
                + "      font-weight: bold;\n"
                + "      text-align: center;\n"
                + "      margin-bottom: 20px;\n"
                + "    }\n"
                + "\n"
                + "    .footer {\n"
                + "      text-align: center;\n"
                + "      font-size: 12px;\n"
                + "      color: #888;\n"
                + "      margin-top: 20px;\n"
                + "    }\n"
                + "  </style>\n"
                + "</head>\n"
                + "<body>\n"
                + "  <div class=\"container\">\n"
                + "    <h1>THE PERFUME SHOP</h1>\n"
                + "    <h2>Verify your recovery email</h2>\n"
                + "    <p>The perfume shop has received a request to use " + email + " as an account to access our products.</p>\n"
                + "    <p>Use this code to finish setting up this recovery email:</p>\n"
                + "    <div class=\"code\">" + OTP + "</div>\n"
                + "    <p></p>\n"
                + "    <div class=\"footer\">\n"
                + "      <p>Welcome to!!</p>\n"
                + "      <p>© 2024 The Perfume Shop TPS, Km39 Cao tốc Láng Hòa Lạc,Hà Nội, Việt Nam</p>\n"
                + "    </div>\n"
                + "  </div>\n"
                + "</body>\n"
                + "</html>";

    }
}

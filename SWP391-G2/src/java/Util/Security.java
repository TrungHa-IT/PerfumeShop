/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Util;

/**
 *
 * @author nguye
 */
import java.security.NoSuchAlgorithmException;
import java.security.MessageDigest;
import javax.xml.bind.DatatypeConverter;

public class Security {

    public String getPasswordSecurity(String srcText) throws NoSuchAlgorithmException {
        String enrText;
        MessageDigest msd = MessageDigest.getInstance("SHA-256");
        msd.update(srcText.getBytes());
        byte[] digest = msd.digest();
        enrText = DatatypeConverter.printHexBinary(digest).toLowerCase();
        return enrText;
    }

    public static void main(String[] args) throws NoSuchAlgorithmException {
        Security s = new Security();
        System.out.println(s.getPasswordSecurity("Tridung123-"));
    }
}
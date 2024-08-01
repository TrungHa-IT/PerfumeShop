/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Models.Sliders;
import context.DBContext;

/**
 *
 * @author nguye
 */
public class SliderDAO extends DBContext {

    public List<Sliders> getAll() {
        List<Sliders> slider = new ArrayList<>();
        String sql = "select * from Sliders where SliderStatus = 1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                slider.add(new Sliders(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getInt(6)
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slider;
    }

    public List<Sliders> getSlidersByStatus(int status) {
        List<Sliders> sliders = new ArrayList<>();
        String sql = "SELECT * FROM Sliders WHERE status = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Sliders slider = new Sliders(
                            rs.getInt("SliderID"),
                            rs.getString("SliderImage"),
                            rs.getInt("SliderStatus"),
                            rs.getString("SliderTitle"),
                            rs.getDate("UpdateAt"),
                            rs.getInt("AccountID"));
                    sliders.add(slider);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public List<Sliders> getAllActiveStatus() {
        List<Sliders> slider = new ArrayList<>();
        String sql = "select * from Sliders";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                slider.add(new Sliders(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getInt(6)
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slider;
    }

    //Get Slider by SliderID
    public Sliders getSliderById(int sliderID) {
        String sql = "SELECT SliderID, SliderImage, SliderTitle, SliderStatus, UpdateAt, AccountID FROM Sliders WHERE SliderID = ? AND SliderStatus = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, sliderID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Sliders slider = new Sliders(
                            rs.getInt("SliderID"),
                            rs.getString("SliderImage"),
                            rs.getInt("SliderStatus"),
                            rs.getString("SliderTitle"),
                            rs.getDate("UpdateAt"),
                            rs.getInt("AccountId")
                    );
                    return slider;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    //Search by Title
    public List<Sliders> searchSlidersByTitle(String text) {
        List<Sliders> sliders = new ArrayList<>();
        String sql = "SELECT SliderID, SliderImage, SliderTitle, SliderStatus, UpdateAt, AccountID FROM Sliders WHERE SliderTitle LIKE ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + text + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Sliders slider = new Sliders(
                        rs.getInt("SliderID"),
                        rs.getString("SliderImage"),
                        rs.getInt("SliderStatus"),
                        rs.getString("SliderTitle"),
                        rs.getDate("UpdateAt"),
                        rs.getInt("AccountID")
                );
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    //Search by status
    public List<Sliders> searchSlidersByStatus(Integer status) {
        List<Sliders> slidersList = new ArrayList<>();
        String sql = "SELECT SliderID, SliderImage, SliderTitle, SliderStatus, UpdateAt, AccountID FROM Sliders WHERE SliderStatus = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            if (status != null) {
                preparedStatement.setInt(1, status);
            } else {
                preparedStatement.setNull(1, java.sql.Types.INTEGER);
            }
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Sliders slider = new Sliders(
                            rs.getInt("SliderID"),
                            rs.getString("SliderImage"),
                            rs.getInt("SliderStatus"),
                            rs.getString("SliderTitle"),
                            rs.getDate("UpdateAt"),
                            rs.getInt("AccountID")
                    );
                    slidersList.add(slider);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slidersList;
    }

    // Get list sliders by page
    public List<Sliders> getListByPage(List<Sliders> list, int start, int end) {
        ArrayList<Sliders> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    //INSERT SLIDER
    public void insertSlider(Sliders slider) {
        String sql = "INSERT INTO Sliders (SliderImage, SliderTitle, SliderStatus, UpdateAt, AccountID) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, slider.getSliderImage());
            preparedStatement.setString(2, slider.getSliderTitle());
            preparedStatement.setInt(3, slider.getSliderStatus());
            preparedStatement.setDate(4, new java.sql.Date(slider.getUpdateAt().getTime()));

            Integer accountId = slider.getAccountId();
            if (accountId != null) {
                preparedStatement.setInt(5, accountId);
            } else {
                preparedStatement.setNull(5, java.sql.Types.INTEGER);
            }

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //UPDATE SLIDER
    public void updateSlider(Sliders slider) {
        String sql = "UPDATE Sliders SET SliderImage = ?, SliderTitle = ?, UpdateAt = ?, SliderStatus = ?";
        if (slider.getAccountId() != null) {
            sql += ", AccountID = ?";
        }
        sql += " WHERE SliderID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int parameterIndex = 1;
            ps.setString(parameterIndex++, slider.getSliderImage());
            ps.setString(parameterIndex++, slider.getSliderTitle());
            ps.setDate(parameterIndex++, new java.sql.Date(slider.getUpdateAt().getTime()));
            ps.setInt(parameterIndex++, slider.getSliderStatus());

            if (slider.getAccountId() != null) {
                ps.setInt(parameterIndex++, slider.getAccountId());
            }

            ps.setInt(parameterIndex, slider.getSliderID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateSliderStatus(int sliderId, int status) {
        String sql = "UPDATE Sliders SET SliderStatus = ? WHERE SliderID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, sliderId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        SliderDAO Sdao = new SliderDAO();

        List<Sliders> slider = Sdao.getAll();
        for (Sliders sliders : slider) {
            System.out.println(sliders.getSliderImage());
        }

    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import Models.FeedBacks;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import context.DBContext;

/**
 *
 * @author admin
 */
public class FeedbackDAO extends DBContext {
    
    public List<FeedBacks> getListFeedback(Boolean replyNotNull) {
        List<FeedBacks> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedbacks";

        if (replyNotNull != null) {
            sql += " WHERE reply " + (replyNotNull ? "IS NOT NULL" : "IS NULL");
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                FeedBacks feedback = new FeedBacks(
                        rs.getInt(1), // FeedbackID
                        rs.getInt(2), // fbAccountID
                        rs.getInt(3), // fbProductID
                        rs.getInt(4), // fbRating
                        rs.getString(5), // fbComment
                        rs.getString(6), // reply
                        rs.getDate(7), // fbDate
                        rs.getInt(8), // AccountID
                        rs.getString(9) // AccountName
                );
                list.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Thêm in ra lỗi để dễ dàng kiểm tra và debug
        }
        return list;
    }

    public void updateReplyFeedback(String reply, int id) {
        String sql = "UPDATE [dbo].[Feedbacks]\n"
                + "   SET [reply] = ?\n"
                + " WHERE [fbID] = ?";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setString(1, reply);
            ur.setInt(2, id);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<FeedBacks> getFeedbacksByProductID(int productID) {
        List<FeedBacks> feedbacks = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Feedbacks] WHERE fbProductID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, productID);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    FeedBacks feedback = new FeedBacks(
                            rs.getInt("fbID"),
                            rs.getInt("fbAccountID"),
                            rs.getInt("fbProductID"),
                            rs.getInt("fbStar"),
                            rs.getString("fbContent"),
                            rs.getString("fbImage"),
                            rs.getDate("fbDate"),
                            rs.getInt("fbStatus"),
                            rs.getString("reply")
                    );
                    feedbacks.add(feedback);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }

    public int getTotalFeedbackByProductId(int id) {
        String sql = "select COUNT(fbProductID) from Feedbacks where fbProductID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getAverageStartByProductID(int productid) {
        String sql = "  select AVG(fbStar * 1) AS AverageStars\n"
                + "  from Feedbacks where fbProductID = ?";
        int average = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                average = rs.getInt("AverageStars");
            }
        } catch (Exception e) {

        }
        return average;
    }

    public void insertFeedback(int idAccount, int idProduct, int star, String content, String image, Date date, int status, String reply) {
        String sql = "INSERT INTO [dbo].[Feedbacks] "
                + "([fbAccountID], [fbProductID], [fbStar], [fbContent], [fbImage], [fbDate], [fbStatus], [reply]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, idAccount);
            st.setInt(2, idProduct);
            st.setInt(3, star);
            st.setString(4, content);
            st.setString(5, image);
            st.setDate(6, (Date) date);
            st.setInt(7, status);
            st.setString(8, reply);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<FeedBacks> getListFeedback(int id) {
        List<FeedBacks> list = new ArrayList<>();
        String sql = "select * from Feedbacks fb join Accounts a on fb.fbAccountID = a.AccountID where fb.fbProductID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new FeedBacks(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getDate(7),
                        rs.getInt(8),
                        rs.getString(9)));
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public ArrayList<FeedBacks> getFeedbacksByFilter(int status, String search, Boolean filterByReply, int pageNo, int pageSize) {
        ArrayList<FeedBacks> listFeedback = new ArrayList<>();
        String sql = "SELECT * FROM Feedbacks";

        boolean whereAdded = false; // A flag to track whether "WHERE" has been added to the SQL query.
        if (status != -1 || !search.isEmpty() || filterByReply != null) {
            sql += " WHERE";
            if (status != -1) {
                sql += " fbStatus = ?";
                whereAdded = true;
            }
            if (!search.isEmpty()) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " (fbContent LIKE ? OR reply LIKE ?)";
                whereAdded = true;
            }
            if (filterByReply != null) {
                if (whereAdded) {
                    sql += " AND";
                }
                if (filterByReply) {
                    sql += " reply IS NOT NULL";
                } else {
                    sql += " reply IS NULL";
                }
            }
        }

        sql += " ORDER BY fbID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            int parameterIndex = 1; // Start with the first parameter index
            if (status != -1) {
                ur.setInt(parameterIndex, status);
                parameterIndex++;
            }
            if (!search.isEmpty()) {
                ur.setString(parameterIndex, "%" + search + "%");
                parameterIndex++;
                ur.setString(parameterIndex, "%" + search + "%");
                parameterIndex++;
            }
            if (filterByReply != null) {
                // No need to set parameters for filterByReply here since it's handled in the SQL directly
            }
            // Set the limit and offset parameters for pagination
            ur.setInt(parameterIndex, (pageNo - 1) * pageSize);
            parameterIndex++;
            ur.setInt(parameterIndex, pageSize);

            ResultSet rs = ur.executeQuery();
            while (rs.next()) {
                FeedBacks feedback = new FeedBacks(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getDate(7),
                        rs.getInt(8),
                        rs.getString(9)
                );

                listFeedback.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle or log the exception appropriately
        }

        return listFeedback;
    }

    public int getTotalPage(int status, String search, int pageSize) {
        String sql = "SELECT COUNT(*) FROM Feedbacks";
        boolean whereAdded = false; // A flag to track whether "WHERE" has been added to the SQL query.
        if (status != -1 || !search.isEmpty()) {
            sql += " WHERE";
            if (status != -1) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " fbStatus = ?";
                whereAdded = true;
            }
            if (!search.isEmpty()) {
                if (whereAdded) {
                    sql += " AND";
                }
                sql += " (fbContent LIKE ?)";
            }
        }

        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            int parameterIndex = 1; // Start with the first parameter index
            if (status != -1) {
                ur.setInt(parameterIndex, status);
                parameterIndex++;
            }
            if (!search.isEmpty()) {
                for (int i = 0; i < 2; i++) {
                    ur.setString(parameterIndex, "%" + search + "%");
                    parameterIndex++;
                }
            }
            ResultSet rs = ur.executeQuery();
            if (rs.next()) {
                int totalRecord = rs.getInt(1);
                int totalPage = totalRecord / pageSize;
                if (totalRecord % pageSize != 0) {
                    totalPage++;
                }
                return totalPage;
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public void updateStatusFeedback(int status, int categoryID) {
        String sql = "UPDATE [dbo].[Feedbacks]\n"
                + "   SET [fbStatus] = ?\n"
                + " WHERE [fbID] = ?;";
        try {
            PreparedStatement ur = connection.prepareStatement(sql);
            ur.setInt(1, status);
            ur.setInt(2, categoryID);
            ur.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public FeedBacks getFeedback(int id) {
        String sql = "select * from Feedbacks where fbID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new FeedBacks(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getDate(7),
                        rs.getInt(8),
                        rs.getString(9));
            }
        } catch (SQLException e) {

        }
        return null;
    }
}

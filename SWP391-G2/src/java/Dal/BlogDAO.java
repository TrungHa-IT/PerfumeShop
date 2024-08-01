/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

/**
 *
 * @author TNO
 */
import static Constant.constant.RECORD_PER_PAGE;
import Models.BlogResponseDTO;
import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO extends DBContext {

    private PreparedStatement ps;
    private ResultSet rs;
    private List<BlogResponseDTO> listBlog;

    public BlogDAO() {
        listBlog = new ArrayList<>();

    }

    public boolean addBlog(String title, String brief, String contentBlog, String status, String imgPath, int authorId) {
        String sql = "INSERT INTO [dbo].[Blog]\n"
                + "           ([title]\n"
                + "           ,[brief_infor]\n"
                + "           ,[content_blog]\n"
                + "           ,[thumbnail]\n"
                + "           ,[author_id]\n"
                + "           ,[status])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ?, ?)";
        try (Connection connection = new DBContext().connection) {
            ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, brief);
            ps.setString(3, contentBlog);
            ps.setString(4, imgPath);
            ps.setInt(5, authorId);
            ps.setString(6, status);

            int rowAffected = ps.executeUpdate();

            if (rowAffected > 0) {
                return true;
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResultSetAndStatement(rs, ps);
        }
        return false;
    }

    public int findTotalRecord(int status) {
        String sql = "select count(b.blog_id) from Blog b\n"
                + "where b.[status] = ?";
        try (Connection connection = new DBContext().connection) {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResultSetAndStatement(rs, ps);
        }
        return -1;
    }

    public List<BlogResponseDTO> findBlogByPage(int page, int statusInput) {
        String sql = "select b.blog_id, b.title, b.brief_infor, b.content_blog, b.thumbnail, \n"
                + "b.createdAt, b.updateAt, b.author_id, b.[status], a.FirstName, a.LastName \n"
                + "from Blog b\n"
                + "join Accounts a\n"
                + "on b.author_id = a.AccountID\n"
                + "where b.[status] = ?\n"
                + "ORDER BY b.author_id\n"
                + "OFFSET ? ROWS\n"
                + "FETCH NEXT ? ROWS ONLY;";
        try (Connection connection = new DBContext().connection) {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, statusInput);
            ps.setInt(2, (page - 1) * RECORD_PER_PAGE);
            ps.setInt(3, RECORD_PER_PAGE);

            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String brief = rs.getString(3);
                String content = rs.getString(4);
                String thumbnail = rs.getString(5);
                Timestamp createdAt = rs.getTimestamp(6);
                Timestamp updateAt = rs.getTimestamp(7);
                int authorId = rs.getInt(8);
                boolean status = rs.getBoolean(9);
                String firstName = rs.getString(10);
                String lastName = rs.getString(11);

                BlogResponseDTO responseBlog = new BlogResponseDTO(id, title, brief, content, thumbnail, createdAt, updateAt, authorId, status, firstName, lastName);

                listBlog.add(responseBlog);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResultSetAndStatement(rs, ps);
        }
        return listBlog;
    }

    public BlogResponseDTO findBlogById(int idBlog) {
        String sql = "select b.blog_id, b.title, b.brief_infor, b.content_blog, b.thumbnail, \n"
                + "b.createdAt, b.updateAt, b.author_id, b.[status], a.FirstName, a.LastName \n"
                + "from Blog b\n"
                + "join Accounts a\n"
                + "on b.author_id = a.AccountID\n"
                + "where b.blog_id = ?";

        BlogResponseDTO blogResponse = null;

        try (Connection connection = new DBContext().connection) {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, idBlog);

            rs = ps.executeQuery();

            if (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String brief = rs.getString(3);
                String content = rs.getString(4);
                String thumbnail = rs.getString(5);
                Timestamp createdAt = rs.getTimestamp(6);
                Timestamp updateAt = rs.getTimestamp(7);
                int authorId = rs.getInt(8);
                boolean status = rs.getBoolean(9);
                String firstName = rs.getString(10);
                String lastName = rs.getString(11);

                blogResponse = new BlogResponseDTO(id, title, brief, content, thumbnail, createdAt, updateAt, authorId, status, firstName, lastName);

            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResultSetAndStatement(rs, ps);
        }
        return blogResponse;
    }

    private void closeResultSetAndStatement(ResultSet rs, PreparedStatement ps) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                System.out.println(e + "ham mypurchase");
            }
        }

    }

    public boolean updateBlog(int id, String title, String brief, String content, int status, String imgPath, int updateImageMode) {
        String sql = "";
        switch (updateImageMode) {
            case 1:
                sql = "UPDATE [dbo].[Blog]\n"
                        + "   SET [title] = ?,\n"
                        + "       [brief_infor] = ?,\n"
                        + "       [content_blog] = ?,\n"
                        + "       [thumbnail] = ?,\n"
                        + "       [status] = ?\n"
                        + " WHERE [blog_id] = ?";
                break;
            case 0:
                sql = "UPDATE [dbo].[Blog]\n"
                        + "   SET [title] = ?,\n"
                        + "       [brief_infor] = ?,\n"
                        + "       [content_blog] = ?,\n"
                        + "       [status] = ?\n"
                        + " WHERE [blog_id] = ?";
                break;
            default:
                throw new AssertionError();
        }

        try (Connection connection = new DBContext().connection) {
            ps = connection.prepareStatement(sql);

            // Set common parameters
            ps.setString(1, title);
            ps.setString(2, brief);
            ps.setString(3, content);

            if (updateImageMode == 1) {
                ps.setString(4, imgPath);
                ps.setInt(5, status);
                ps.setInt(6, id);
            } else {
                ps.setInt(4, status);
                ps.setInt(5, id);
            }

            int rowAffected = ps.executeUpdate();

            if (rowAffected > 0) {
                return true;
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResultSetAndStatement(rs, ps);
        }

        return false;
    }

    public boolean deleteBlog(int id, int status) {
        String sql = "UPDATE [dbo].[Blog]\n"
                + "   SET [status] = ?\n"
                + " WHERE [blog_id] = ?";

        try (Connection connection = new DBContext().connection) {

            ps = connection.prepareStatement(sql);

            ps.setInt(1, status);
            ps.setInt(2, id);

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                return true;
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        } finally {
            closeResultSetAndStatement(rs, ps);
        }
        return false;
    }

}

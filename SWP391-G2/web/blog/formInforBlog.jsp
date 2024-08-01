<%-- 
    Document   : formInforBlog
    Created on : Jun 18, 2024, 9:58:26 AM
    Author     : TNO
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en"> 
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="megakit,business,company,agency,multipurpose,modern,bootstrap4">

        <meta name="author" content="themefisher.com">

        <title>View details Blog | Megakit</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
        <!-- Icon Font CSS -->
        <link rel="stylesheet" href="plugins/themify/css/themify-icons.css">
        <link rel="stylesheet" href="plugins/fontawesome/css/all.css">
        <!-- Main Stylesheet -->
        <link rel="stylesheet" href="css/styleBlog.css">
    </head>
    <body>
        <div class="main-wrapper">
            <section class="section blog-wrap bg-gray">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 offset-lg-2">
                            <div class="card border-0 p-5">
                                <h4 class="mb-4">View details Blog Post</h4>
                                <h3>${msg}</h3>
                                <form action="updateBlog" method="post" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label for="title">Title:</label>
                                        <input type="text" class="form-control" id="title" value="${blog.title}" name="title" required>
                                        <input style="display: none" type="text" class="form-control" id="title" value="${blog.id}" name="id" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="brief">Brief Information:</label>
                                        <input type="text" class="form-control" id="brief" value="${blog.brief}" name="brief" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="content">Content:</label>
                                        <div id="descriptionBlog" ></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="status">Status:</label>
                                        <select class="form-control" id="status" name="status" required>
                                            <option ${blog.status == false ? 'selected' : ""} value="0">Draft</option>
                                            <option ${blog.status == true ? 'selected' : ""} value="1">Published</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="thumbnail">Thumbnail:</label>
                                        <input type="file" class="form-control" id="thumbnail" name="thumbnail" class="img-fluid responsive-image" accept="image/*">
                                    </div>
                                    <div class="mt-2">
                                        <img src="${blog.thumbnail}" alt="Current Additional Image" class="img-fluid" id="currentAdditionalImage">
                                    </div>
                                    <div style="padding-top: 20px">
                                        <button type="submit" class="btn btn-main btn-round-full">Submit</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- footer Start -->

        </div>

        <!-- Essential Scripts -->
        <!-- Main jQuery -->
        <script src="plugins/jquery/jquery.js"></script>
        <script src="js/contact.js"></script>
        <!-- Bootstrap 4.3.1 -->
        <script src="plugins/bootstrap/js/popper.js"></script>
        <script src="plugins/bootstrap/js/bootstrap.min.js"></script>

        <script src="https://cdn.tiny.cloud/1/3dnf4g9cgv4sfog9pgz0n3f33fqrskhx8tz3ejpcmhn480gh/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>

        <script>
            tinymce.init({
                selector: '#descriptionBlog',
                height: 300,
                language: 'vi',
                plugins: 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount linkchecker',
                toolbar: 'undo redo | formatselect | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help',
                setup: function (editor) {
                    editor.on('init', function (e) {
                        editor.setContent(`${blog.content}`);
                    });
                }
            });
        </script>
    </body>
</html>

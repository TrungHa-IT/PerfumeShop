<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile | iLocal Shop</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/logo.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <!-- Include Bootstrap CSS via CDN link -->
        <!-- ======= Styles ====== -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin_manager.css">

        <style>
            .image-preview-container {
                display: flex;
                align-items: center;
            }

            .image-preview {
                width: 15%; /* Đặt kích thước hiển thị ảnh */
                height: auto; /* Đảm bảo tỷ lệ khung hình bảo toàn */
                border: 1px solid #ccc; /* Đường viền để phân biệt vùng ảnh */
            }

            .file-input {
                margin-left: 10px; /* Khoảng cách giữa ảnh và nút chọn tệp tin */
            }

            label{
                font-weight: bold;
            }
        </style>

    </head>

    <body>
        <div class="container-fluid">
            <!-- Navigation -->
            <jsp:include page="admin/admin-navigation.jsp"></jsp:include>

                <!-- Main Content -->
                <div class="main" style="margin-left: 50px; margin-right: 50px;">
                    <div class="topbar">
                        <!-- <div class="toggle">
        <ion-icon name="menu-outline"></ion-icon>
    </div>
    <div class="user">
        <img src="assets/imgs/customer01.jpg" alt="">
    </div> -->
                    </div>

                    <div class="row" style="margin-right: 70px;  padding: 10px; border: 1.5px solid #000;">
                        <input type="hidden" id="pageNo" name="pageNo" value="${currentPage}">
                    <div class="col-12" style="margin-bottom: 40px;">
                        <h1>Profile</h1>
                        <c:if test="${param.error != null}">
                            <h6 style="color: red;">In-valid information to add new customer!</h6>
                        </c:if>
                    </div>
                    <form action="./profile" method="post"  enctype="multipart/form-data">

                        <div class="form-group row">
                            <label for="adminFirstName">First Name:</label>
                            <input style="width: 50%"type="text" class="form-control" id="productName" name="adminFirstName"
                                   value="${ad.adFirstName}" required="">
                        </div>
                        <div class="form-group row">
                            <label for="adminLastName">Last Name:</label>
                            <input style="width: 50%"type="text" class="form-control" id="productName" name="adminLastName"
                                   value="${ad.adLastName}" required="">
                        </div>

                        <div class="form-group row">
                            <label for="adminAddress">Address:</label>
                            <input style="width: 50%"type="text" class="form-control" id="color" name="adminAddress"
                                   value="${ad.adAddress}" required="">
                        </div>

                        <div class="form-group row">
                            <label for="adminUsername">Username:</label>
                            <input readonly="" style="width: 50%"type="text" class="form-control" id="color" name="adminUsername"
                                   value="${admin.adUsername}" >
                        </div>

                        <div class="form-group row">
                            <label for="adminEmail">Email:</label>
                            <input readonly=""style="width: 50%"type="text" class="form-control" id="color" name="adminEmail"
                                   value="${admin.adEmail}">
                        </div>

                        <div class="form-group row">
                            <label for="role">Role:</label>
                            <input readonly=""style="width: 50%"type="text" class="form-control" id="available" name="role"
                                   value="${admin.getRoleName()}">
                        </div>
                        <div> <span class="error" style="color: red;">${message}</span> </div>

                        <!-- Update the "Change Password" link -->
                        <div class="form-group row">
                            <a style="width: 30%; " class="btn btn-primary" href="updatePassword" >Change Password </a>
                        </div>


                        <a class="btn btn-primary" href="manage">Cancel</a>
                        <button type="submit" class="btn btn-primary">Update</button>
                    </form>
                </div>

            </div>
        </div>




       
    </body>


    <!-- =========== Scripts =========  -->
    <script src="js/admin_manager.js"></script>
    <!-- ====== ionicons ======= -->
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
    crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
    crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
    crossorigin="anonymous"></script>
    <script>
        function updatePreview(event) {
            var input = event.target;
            var reader = new FileReader();

            reader.onload = function () {
                var imgElement = document.getElementById('previewImage');
                imgElement.src = reader.result;
            }

            reader.readAsDataURL(input.files[0]);
        }
    </script>

    <script>
        var alertMessage = ${sessionScope.alertMessage};

        if (alertMessage) {
            alert("Update product detail successfully!");
        }

        <%
                session.removeAttribute("alertMessage");
        %>
    </script>

    <!-- Add this script in the head section or at the end of the body -->
    <script>
        function togglePasswordChangeForm() {
            var passwordChangeForm = document.getElementById('passwordChangeForm');
            if (passwordChangeForm.style.display === 'none') {
                passwordChangeForm.style.display = 'block';
            } else {
                passwordChangeForm.style.display = 'none';
            }
        }
    </script>


</html>
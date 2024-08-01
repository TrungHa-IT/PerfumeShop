<%-- 
    Document   : manage-category-detail
    Created on : Jul 12, 2024, 4:50:15 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Category Detail</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/logo.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <!-- Include Bootstrap CSS via CDN link -->
        <!-- ======= Styles ====== -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin_manager.css">
        <style>
            .error-message {
                color: red;
                font-size: 0.9em;
            }
        </style>
    </style>
</head>

<body>
    <div class="container-fluid">
        <!-- Navigation -->


        <!-- Main Content -->
        <div class="main" style="margin-left: 50px; margin-right: 50px;">
            <div class="topbar">
            </div>

            <div class="row" style="margin-right: 70px;  padding: 10px; border: 1.5px solid #000;">
                <input type="hidden" id="pageNo" name="pageNo" value="${currentPage}">
                <div class="col-12" style="margin-bottom: 40px;">
                    <h1>Category details</h1>
                </div>

                <form action="categorydetail" method="post" onsubmit="return validateForm()" >
                    <input type="text" value="${requestScope.data.getCategoryID()}" name="id" hidden>
                    <input type="text" value="${requestScope.status}" name="status" id="status" hidden> 
                    <input type="text" value="${requestScope.currentPage}" name="pageNo" id="pageNo" hidden>
                    <input type="text" value="${requestScope.search}" name="search" id="search" hidden>

                    <div class="form-group row">
                        <div class="col-4">
                            <label for="name">Category Name</label>
                            <input type="text" class="form-control" id="name" name="name" placeholder="${requestScope.data.getCategoryName()}">
                            <div id="nameError" class="error-message"></div>
                        </div>
                        <div class="col-4">
                            <label for="description">Category Description:</label>
                            <textarea type="text" class="form-control" id="description" name="description" placeholder="${requestScope.data.getDescription()}"></textarea>
                            <div id="descriptionError" class="error-message"></div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-4">
                            <label>Status:</label>
                            <select class="form-control"  name="statusnew">
                                <option value="1" ${requestScope.data.getStatus()==1 ? 'selected' : '' }>Active</option>
                                <option value="0" ${requestScope.data.getStatus()==0 ? 'selected' : '' }>In-Active</option>
                            </select>
                        </div>
                    </div>
                    <a class="btn btn-primary" onclick="cancel()">Cancel</a>
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
                        function showUpdateAlert() {
                            alert("Account details updated successfully!");
                        }

                        function cancel() {
                            const search = document.querySelector('#search').value;
                            const status = document.querySelector('#status').value;
                            const pageNo = document.querySelector('#pageNo').value;
                            window.location.href = 'category?search=' + search +
                                    '&status=' + status + '&pageNo=' + pageNo;
                        }
</script>

<script>
    function validateForm() {
        // Lấy giá trị của các input
        var name = document.getElementById('name').value;
        var description = document.getElementById('description').value;

        // Lấy các phần tử để hiển thị lỗi
        var nameError = document.getElementById('nameError');
        var descriptionError = document.getElementById('descriptionError');

        // Định nghĩa các regex cho kiểm tra input
        //var nameRegex = /^(?=.*[a-zA-Z])[a-zA-Z0-9 ]{3,200}$/; // Chỉ chấp nhận chữ cái, số và khoảng trắng, độ dài từ 3 đến 50 ký tự
        var nameRegex = /^(?!\s)[a-zA-Z0-9 ]{3,200}(?<!\s)$/;
        var descriptionRegex = /^.{10,200}$/; // Chấp nhận mọi ký tự, độ dài từ 10 đến 200 ký tự

        // Xóa thông báo lỗi trước đóx
        nameError.textContent = '';
        descriptionError.textContent = '';

        // Kiểm tra input
        var valid = true;
        if (!nameRegex.test(name)) {
            nameError.textContent = 'Category names must be between 3 and 200 characters and contain only letters, numbers and spaces.';
            valid = false;
        }

        // Kiểm tra xem name có phải là chuỗi số hoàn toàn không
        if (/^\d+$/.test(name)) {
            nameError.textContent = 'Category Name cannot contain whole numbers.';
            valid = false;
        }

        if (/^\s{2,}/.test(name)) {
            nameError.textContent = 'Category Name cannot start with multiple spaces.';
            valid = false;
        }

        if (!descriptionRegex.test(description)) {
            descriptionError.textContent = 'Category Description must be from 10 to 200 characters.';
            valid = false;
        }

        // Nếu tất cả đều hợp lệ, return true để submit form
        return valid;
    }
</script>
</script>
</html>

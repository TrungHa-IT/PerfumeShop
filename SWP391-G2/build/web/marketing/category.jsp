<%-- 
    Document   : category
    Created on : Jul 12, 2024, 4:27:25 PM
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
        <title> Manage Admin | The Perfume Shop</title>
        <link rel="icon" type="image/x-icon" href="img/logo.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <!-- Include Bootstrap CSS via CDN link -->
        <!-- ======= Styles ====== -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin_manager.css"/>
    </head>
    <style>
        .form-control.custom-width {
            width: 400px; /* Thay đổi giá trị này theo nhu cầu của bạn */
        }
        .error-message {
            color: red;
            font-size: 0.9em;
        }


        th {
            white-space: nowrap;
        }
        .custom-button {
            background: none; /* Không có màu nền */
            border: none; /* Bỏ viền */
            padding: 10px 20px; /* Khoảng cách bên trong nút bấm */
            font-size: 16px; /* Kích thước chữ */
            cursor: pointer; /* Con trỏ chuột */
            color: #1E90FF; /* Màu chữ xanh nước biển nhẹ */
            text-decoration: none; /* Bỏ gạch chân mặc định */
            position: relative; /* Để tạo đường gạch ngang bên dưới */
        }

        .custom-button::after {
            content: ""; /* Nội dung giả */
            position: absolute; /* Định vị tuyệt đối */
            left: 0; /* Căn trái */
            bottom: 0; /* Căn dưới */
            width: 0; /* Chiều rộng ban đầu */
            height: 2px; /* Độ dày của đường gạch ngang */
            background-color: #1E90FF; /* Màu của đường gạch ngang */
            transition: width 0.3s ease; /* Hiệu ứng chuyển đổi chiều rộng */
        }

        .custom-button:hover::after {
            width: 100%; /* Chiều rộng khi hover */
        }

        .custom-button:focus {
            outline: none; /* Bỏ viền focus mặc định */
        }

        .table-button {
            text-align: center; /* Căn giữa nút bấm trong ô bảng */
        }

    </style>
    <body>
        <c:if test="${requestScope.error !=null}">
            <div class="row fixed-top text-center">

                <div class=" alert alert-warning" role="alert">
                    ${requestScope.error}

                </div>
            </div>

        </c:if>
        <c:if test="${requestScope.success !=null}">
            <div class="row fixed-top text-center">

                <div class=" alert alert-success" role="alert">
                    ${requestScope.success}
                </div>
            </div>
        </c:if>

        
        <jsp:include page="../partials/navigation.jsp"></jsp:include>
        <div class="container-fluid">
            <!-- Navigation -->

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
                        <h1>Category</h1>

                    </div>
                    <div class="col-3">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search" value="${search}"
                                   id="search">
                            <div class="input-group-append">
                                <button class="btn btn-secondary" type="button" id="btnSearch">
                                    <ion-icon name="search-outline"></ion-icon>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-3">

                    </div>
                    <div class="col-3">
                        <!-- <select class="form-control" id="status">
                            <option value="1" selected>Status: Active</option>
                            <option value="0">Status: In-Active</option>
                        </select> -->
                        <select class="form-control" id="status" name="status">
                            <option value="-1" ${status==null ? 'selected' : '' }>All status</option>
                            <option value="1" ${status==1 ? 'selected' : '' }>Active</option>
                            <option value="0" ${status==0 ? 'selected' : '' }>In-Active</option>
                        </select>
                    </div>

                    <div class="col-3">
                        <div class="text-right">
                            <button type="button" class="btn btn-success" data-toggle="modal"
                                    data-target="#addnewModal">
                                <ion-icon style="margin-top: 2px;" name="add-outline"></ion-icon> Add New
                            </button>
                        </div>
                    </div>
                    <div class="col-12" style="margin-top: 10px;">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th scope="col">No</th>
                                        <th scope="col">Name</th>             
                                        <th scope="col">Description</th>
                                        <th scope="col">Create Date</th>
                                        <th scope="col">Details</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listcategory}" var="category" varStatus="loop">
                                        <tr>
                                            <td>${(requestScope.currentPage-1)*10+loop.index+1}</td>      
                                            <td class="table-button">
                                                <a onclick="showDetail(${category.getCategoryID()})">
                                                    <button type="button" class="custom-button">${category.getCategoryName()}</button>
                                                </a>
                                            </td>
                                            <td>${category.getDescription()}</td>
                                            <td>${category.getCreateAt()}</td>
                                            <!-- create button Block if status is 1 and Unblock if status is 0 and have tag a href is updateStatusAdmin?status?id-->
                                            <td>
                                                <c:choose>
                                                    <c:when test="${category.getStatus() == 1}">
                                                        <a  onclick="showAlert('Maketing blocked successfully!',${category.getCategoryID()}, 0)">
                                                            <button type="button" class="btn btn-danger">
                                                                View
                                                            </button>
                                                        </a>
                                                    </c:when>
                                                    <c:when test="${category.getStatus() == 0}">
                                                        <a  onclick="showAlert('Maketing unblocked successfully!',${category.getCategoryID()}, 1);">
                                                            <button type="button" class="btn btn-success">
                                                                Hide
                                                            </button>
                                                        </a>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <!-- Pagination -->
                        <nav aria-label="...">
                            <ul class="pagination justify-content-end">
                                <c:if test="${currentPage == 1}">
                                    <li class="page-item disabled">
                                        <button class="page-link" onclick="changePage(${currentPage - 1})">
                                            Previous
                                        </button>
                                    </li>
                                </c:if>
                                <c:if test="${currentPage != 1}">
                                    <li class="page-item">
                                        <button class="page-link" onclick="changePage(${currentPage - 1})">
                                            Previous
                                        </button>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPage}" var="i">
                                    <c:if test="${currentPage == i}">
                                        <li class="page-item active" aria-current="page">
                                            <button class="page-link" onclick="changePage(${i})">
                                                ${i}
                                                <span class="sr-only">(current)</span>
                                            </button>
                                        </li>
                                    </c:if>
                                    <c:if test="${currentPage != i}">
                                        <li class="page-item">
                                            <button class="page-link" onclick="changePage(${i})">${i}</button>
                                        </li>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${currentPage == totalPage}">
                                    <li class="page-item disabled">
                                        <button class="page-link"
                                                onclick="changePage(${currentPage + 1})">Next</button>
                                    </li>
                                </c:if>
                                <c:if test="${currentPage != totalPage}">
                                    <li class="page-item">
                                        <button class="page-link"
                                                onclick="changePage(${currentPage + 1})">Next</button>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>


                    </div>
                </div>

                <!-- Modal Add new-->
                <div class="modal fade" id="addnewModal" tabindex="-1" role="dialog"
                     aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLongTitle">Add New Category</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form action="category" method="post" onsubmit="return validateForm()">
                                <div class="modal-body">
                                    <input type="hidden" name="service" value="addNewAdmin">
                                    <div class="form-group">
                                        <label for="categoryName">Category Name</label>
                                        <input type="text" name="name" class="form-control" id="name" >
                                        <div id="nameError" class="error-message"></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <textarea class="form-control" name="description" id="description" rows="3" ></textarea>
                                        <div id="descriptionError" class="error-message"></div>
                                    </div>                                 
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary"
                                            data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary" >Add new</button>
                                </div>

                            </form>
                        </div>
                    </div>
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
                                function showAlert(message, categoryID, status1) {
                                    if (confirm(message)) {
                                        const search = document.querySelector('#search').value;
                                        const status = document.querySelector('#status').value;
                                        const pageNo = document.querySelector('#pageNo').value;
                                        window.location.href = 'category?search=' + search +
                                                '&status=' + status + '&pageNo=' + pageNo + "&categoryID=" + categoryID + "&statusnew=" + status1;
                                    }
                                }
                                function showDetail(categoryID) {
                                    const search = document.querySelector('#search').value;
                                    const status = document.querySelector('#status').value;
                                    const pageNo = document.querySelector('#pageNo').value;
                                    window.location.href = 'managecategory?search=' + search + 
                                            '&status=' + status + '&pageNo=' + pageNo + '&id=' + categoryID;
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
    <script>
        // handle filter search
        const searchInput = document.querySelector('#search');
        searchInput.addEventListener('keydown', (event) => {
            if (event.key === 'Enter') {
                performSearch();
            }
        });
        const btnSearch = document.querySelector('#btnSearch');
        btnSearch.addEventListener('click', () => {
            performSearch(); // call function
        });
        function performSearch() {
            const search = document.querySelector('#search').value;
            const status = document.querySelector('#status').value;
            window.location.href = 'category?search=' + search +
                    '&status=' + status + '&pageNo=1';
        }
        ;

        // handle filter role
        const status = document.querySelector('#status');
        status.addEventListener('change', () => {
            const search = document.querySelector('#search').value;
            const status = document.querySelector('#status').value;
            window.location.href = 'category?search=' + search +
                    '&status=' + status + '&pageNo=1';
        });


        // handle pagination
        function changePage(pageNo) {
            const search = document.querySelector('#search').value;
            const status = document.querySelector('#status').value;
            window.location.href = 'category?search=' + search +
                    '&status=' + status + '&pageNo=' + pageNo;
        }

    </script>

</html>
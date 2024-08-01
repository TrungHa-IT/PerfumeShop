<%-- 
    Document   : manageVouchers
    Created on : Jul 3, 2024, 3:37:55 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin_manager.css">
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
            rel="stylesheet"
            integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </head>
    <style>
        .form-control.custom-width {
            width: 400px; /* Thay đổi giá trị này theo nhu cầu của bạn */
        }
        .error-message {
            color: red;
            font-size: 0.9em;
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
          <jsp:include page="../partials/navigation.jsp"></jsp:include>
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
                        <h1>Vouchers</h1>

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

                    <div class="col-2">
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
                    <div class="col-2">
                        <div class="text-right">
                            <button type="button" class="btn btn-success" data-toggle="modal"
                                    onclick="addNew()" >
                                <ion-icon style="margin-top: 2px;" name="add-outline"></ion-icon> Add New
                            </button>
                        </div>
                    </div>
                    <div class="col-12" style="margin-top: 20px">
                        <form id="filterForm" action="voucher" method="get">
                            <div class="row">
                                <div class="col-2">
                                    <div class="col-12">Start Date</div>
                                    <div class="input-group">                           
                                        <input type="date" class="form-control" name="start" value="${start}"  id="start" >
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="col-12">End Date</div>
                                    <div class="input-group">                
                                        <input type="date" class="form-control" name="end" value="${end}"  id="end" >
                                    </div>
                                </div>
                                <button class="col-1" type="submit">Filter</button>
                            </div>
                        </form>
                    </div>

                    <!--                    <div class="col-3">
                    
                                            <div class="text-right">
                    
                                            </div>
                    
                                        </div>-->
                    <div class="col-12" style="margin-top: 10px;">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th scope="col">No</th>                                  
                                        <th scope="col" style="text-align: center">Code</th>             
                                        <th scope="col">Discount</th>
                                        <th scope="cod">Create At</th>
                                        <th scope="cod">Start Date</th>
                                        <th scope="cod">Expiry Date</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col" colspan="2" style="text-align: center;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listvoucher}" var="listvoucher" varStatus="loop">
                                        <tr>
                                            <td>${(requestScope.currentPage-1)*10+loop.index+1}</td>                              
                                            <td class="table-button">
                                                <a >
                                                    <button type="button" class="custom-button">${listvoucher.getCode()}</button>
                                                </a>
                                            </td>
                                            <td>${listvoucher.getDiscount()}</td>
                                            <td>${listvoucher.getCreateAt()}</td>
                                            <td>${listvoucher.getStartDate()}</td>
                                            <td>${listvoucher.getExpiryDate()}</td>      
                                            <td>${listvoucher.getQuantity()}</td>

                                            <!-- create button Block if status is 1 and Unblock if status is 0 and have tag a href is updateStatusAdmin?status?id-->
                                            <td style="width: 20px;">   

                                                <c:choose>
                                                    <c:when test="${listvoucher.getStatus() == 1}">
                                                        <a  onclick="showAlert('Maketing blocked successfully!',${listvoucher.getVoucherID()}, 0)">
                                                            <button type="button" class="btn btn-success">
                                                                UnBlock
                                                            </button>
                                                        </a>
                                                    </c:when>
                                                    <c:when test="${listvoucher.getStatus() == 0}">
                                                        <a  onclick="showAlert('Maketing unblocked successfully!',${listvoucher.getVoucherID()}, 1);">
                                                            <button style="width: 86px;" type="button" class="btn btn-danger" >
                                                                Block
                                                            </button>
                                                        </a>
                                                    </c:when>
                                                </c:choose>
                                            </td>   
                                            <td style="width: 20px;">
                                                <c:if test="${listvoucher.getStatus() == 0}">
                                                    <a  onclick="showDetail(${listvoucher.getVoucherID()})">
                                                        <button type="button" class="btn btn-success">
                                                            Update
                                                        </button>
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>

                                        <!-- Modal Add new-->
                                    <div class="modal fade" id="addnewModal" tabindex="-1" role="dialog"
                                         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLongTitle">Add Reply</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <form action="#" method="post" onsubmit="return validateForm()">

                                                    <div class="modal-body">
                                                        <div class="form-group">
                                                            <label for="description">Reply</label>
                                                            <textarea class="form-control" name="reply" id="reply" rows="3" ></textarea>
                                                            <div id="replyError" class="error-message"></div>
                                                        </div>                                 
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary"
                                                                data-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-primary" >Add</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div> 
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

                                                    function autoSubmitForm() {
                                                        document.getElementById('voucher').submit();
                                                    }
                                                    function showAlert(message, voucherID, status1) {


                                                        if (confirm(message)) {
                                                            const search = document.querySelector('#search').value;
                                                            const status = document.querySelector('#status').value;
                                                            const pageNo = document.querySelector('#pageNo').value;
                                                            window.location.href = 'voucher?search=' + search +
                                                                    '&status=' + status + '&pageNo=' + pageNo + "&voucherID=" + voucherID + "&statusnew=" + status1;
                                                        }
                                                    }



                                                    function showDetail(voucherID) {
                                                        const search = document.querySelector('#search').value;
                                                        const status = document.querySelector('#status').value;
                                                        const pageNo = document.querySelector('#pageNo').value;
                                                        window.location.href = 'updatevoucher?search=' + search +
                                                                '&status=' + status + '&pageNo=' + pageNo + '&voucherID=' + voucherID;
                                                    }
                                                    function addNew() {
                                                        const search = document.querySelector('#search').value;
                                                        const status = document.querySelector('#status').value;
                                                        const pageNo = document.querySelector('#pageNo').value;
                                                        window.location.href = 'updatevoucher'
                                                    }
    </script>

    <script>
        // handle filter search


        const btnSearch = document.querySelector('#btnSearch');
        btnSearch.addEventListener('click', () => {
            performSearch(); // call function
        });
        function performSearch() {
            const search = document.querySelector('#search').value;
            const status = document.querySelector('#status').value;
            window.location.href = 'voucher?search=' + search +
                    '&status=' + status + '&pageNo=1';
        }
        ;


        // handle filter role
        const status = document.querySelector('#status');
        status.addEventListener('change', () => {
            const search = document.querySelector('#search').value;
            const status = document.querySelector('#status').value;
            window.location.href = 'voucher?search=' + search +
                    '&status=' + status + '&pageNo=1';
        });




        // handle pagination
        function changePage(pageNo) {
            const search = document.querySelector('#search').value;
            const status = document.querySelector('#status').value;
            window.location.href = 'voucher?search=' + search +
                    '&status=' + status + '&pageNo=' + pageNo;
        }

    </script>

</html>

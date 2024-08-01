<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product | The Perfume Shop</title>
        <link rel="icon" type="image/x-icon" href="img/logo.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <!-- Include Bootstrap CSS via CDN link -->
        <!-- ======= Styles ====== -->
        <jsp:useBean id="proDao" class="Dal.ProductDetailDAO" scope="request"></jsp:useBean> 
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin_manager.css">

        <style>
            .image-preview-container {
                display: flex;
                align-items: center;
            }

            .image-preview {
                width: 60%; /* Đặt kích thước hiển thị ảnh */
                height: auto; /* Đảm bảo tỷ lệ khung hình bảo toàn */
                border: 1px solid #ccc; /* Đường viền để phân biệt vùng ảnh */
            }
        </style>

    </head>

    <body>
        <div class="container-fluid">
            <!-- Navigation -->
            <jsp:include page="../partials/navigation.jsp"></jsp:include>
            <input type="hidden" id="pageNo" name="pageNo" value="${currentPage}">
            <input type="hidden" id="cateId" name="cateId" value="${cateId}">
            <input type="hidden" id="proId" name="proId" value="${proId}">

            <!-- Main Content -->
            <div class="main" style="margin-left: 50px; margin-right: 50px;">
                <div class="topbar">
                </div>

                <input type="hidden" id="success" value="${requestScope.success}" >



                <!<!-- product detail list -->

                <div class="topbar mb-2">
                    <li style="list-style-type: none" class="breadcrumb-item"><a class="link-offset-2 fs-6 link-dark" href="./update-product?proId=${proId}"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8"/>
                            </svg>Previous page</a></li>
                </div>

                <div class="row" style="margin-right: 70px;  padding: 10px; border: 1px solid #cccc;">
                    <div class="col-12" style="margin-bottom: 40px;">
                        <h1>Product Detail</h1>
                    </div>
                    <div class="row col-12">
                        <div class="col-3">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Search" value="${search}"
                                       id="search" name="search">
                                <div class="input-group-append">
                                    <button class="btn btn-secondary" type="button" id="btnSearch">
                                        <ion-icon name="search-outline"></ion-icon>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row col-9 d-flex justify-content-end">
                            <div class="col-2">
                                <select class="form-control" id="status" name="status">
                                    <option value="-1" ${status==null ? 'selected' : '' }>All status</option>
                                    <option value="1" ${status==1 ? 'selected' : '' }>Show</option>
                                    <option value="0" ${status==0 ? 'selected' : '' }>Hidden</option>
                                </select>
                            </div>
                            <div class="col-2">
                                <select class="form-control" id="size" name="size">
                                    <option value="" ${size==null ? 'selected' : '' }>All Size</option>
                                    <c:forEach  items="${listSize}" var="sizes" varStatus="loop" >
                                        <option value="${sizes}" ${sizes == size ? 'selected' : '' }>${sizes}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-2">
                                <div class="text-center">
                                    <button type="button" class="btn btn-info text-center" data-toggle="modal"
                                            data-target="#addnewModal">
                                        <a href="add-product-detail?proId=${proId}&cateId=${cateId}" class="text-center p-2 text-decoration-none" style="color: white;" >Add New Product Detail</a>
                                    </button>
                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="col-12" style="margin-top: 10px;">
                        <div class="table-responsive mt-3">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Product Image</th>
                                        <th scope="col">Description</th>
                                        <th scope="col">Date of init</th>
                                        <th scope="col">Size</th>
                                        <th scope="col">Price</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.listDetail}" varStatus="loop" var="detail">
                                        <tr>
                                            <td>${(requestScope.currentPage-1)*10+loop.index+1}</td>
                                            <td><img src="${detail.image}" style="width: 75px; display: table; margin: 0px -10px;" alt=""></td>
                                            <td class="w-50" ><a  href="./update-product-detail?proId=${proId}&cateId=${cateId}&detailId=${detail.getProductFullDetailID()}" class="link-dark">${detail.getProductDescription()}</a></td>
                                            <td>${detail.getProductCreateDate()}</td>  
                                            <td>${detail.getProductSize()}</td> 
                                            <td>${detail.getProductPrice()}</td>   
                                            <td>${detail.getProductAvaiable()}</td>   
                                            <!-- create button Block if status is 1 and Unblock if status is 0 and have tag a href is updateStatusAdmin?status?id-->
                                            <td>
                                                <c:choose>
                                                    <c:when test="${detail.productStatus == 0}">
                                                        <button type="button" onclick="changeStatus('Do you want to change status',${detail.getProductFullDetailID()}, 1)" class=" w-75 btn btn-warning">
                                                            Hidden
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${detail.productStatus == 1}">
                                                        <button type="button" onclick="changeStatus('Do you want to change status',${detail.getProductFullDetailID()}, 0)"  class="w-75 btn btn-success">
                                                            Show
                                                        </button>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </div>

                    </div>
                    <nav aria-label="...">
                        <ul class="pagination justify-content-start">
                            <c:if test="${currentPage == 1}">
                                <li class="page-item disabled">
                                    <button class="page-link" onclick="changePage(${currentPage - 1})">
                                        Previous
                                    </button>
                                </li>
                            </c:if>
                            <c:if test="${currentPage != 1}">
                                <li class="page-item">
                                    <button  class="page-link" onclick="changePage(${currentPage - 1})">
                                        Previous
                                    </button>
                                </li>
                            </c:if>
                            <c:forEach begin="1" end="${totalPage}" var="i">
                                <c:if test="${currentPage == i}">
                                    <li class="page-item active" aria-current="page">
                                        <button type="button" class="page-link" ">
                                            ${i}
                                            <span class="sr-only">(current)</span>
                                        </button>
                                    </li>
                                </c:if>
                                <c:if test="${currentPage != i}">
                                    <li class="page-item">
                                        <button class="page-link" type="button" onclick="changePage(${i})">${i}</button>
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

    <script>                                  //set time for alertMessage
                                                document.addEventListener('DOMContentLoaded', function () {
                                                    var myDiv = document.getElementById('myDiv');
                                                    myDiv.style.display = 'block';
                                                    setTimeout(function () {
                                                        myDiv.style.display = 'none';
                                                    }, 10000); // 10 giây = 10,000 miligiây
                                                });

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
                                                    const size = document.querySelector('#size').value;
                                                    const search = document.querySelector('#search').value;
                                                    const status = document.querySelector('#status').value;
                                                    const cateId = document.querySelector('#cateId').value;
                                                    const proId = document.querySelector('#proId').value;
                                                    window.location.href = 'product-detail?search=' + search +
                                                            '&status=' + status + '&pageNo=1' + '&cateId=' + cateId + '&proId=' + proId + '&size=' + size;
                                                }
                                                ;

                                                // handle filter status
                                                const status = document.querySelector('#status');
                                                status.addEventListener('change', () => {
                                                    const size = document.querySelector('#size').value;
                                                    const search = document.querySelector('#search').value;
                                                    const status = document.querySelector('#status').value;
                                                    const cateId = document.querySelector('#cateId').value;
                                                    const proId = document.querySelector('#proId').value;
                                                    window.location.href = 'product-detail?search=' + search +
                                                            '&status=' + status + '&pageNo=1' + '&cateId=' + cateId + '&proId=' + proId + '&size=' + size;
                                                });


                                                // handle filter cateID
                                                const size = document.querySelector('#size');
                                                size.addEventListener('change', () => {
                                                    const size = document.querySelector('#size').value;
                                                    const search = document.querySelector('#search').value;
                                                    const status = document.querySelector('#status').value;
                                                    const cateID = document.querySelector('#cateId').value;
                                                    const proId = document.querySelector('#proId').value;
                                                    window.location.href = 'product-detail?search=' + search +
                                                            '&status=' + status + '&pageNo=1' + '&cateId=' + cateID + '&proId=' + proId + '&size=' + size;
                                                });


                                                // handle pagination
                                                function changeStatus(message, detailId, newStatus) {
                                                    const size = document.querySelector('#size').value;
                                                    const search = document.querySelector('#search').value;
                                                    const status = document.querySelector('#status').value;
                                                    const cateID = document.querySelector('#cateId').value;
                                                    const proId = document.querySelector('#proId').value;
                                                    Swal.fire({
                                                        title: message,
                                                        icon: "warning",
                                                        showCancelButton: true,
                                                        confirmButtonColor: "#3085d6",
                                                        cancelButtonColor: "#d33",
                                                        confirmButtonText: "Update"
                                                    }).then((result) => {
                                                        if (result.isConfirmed) {
                                                            let timerInterval;
                                                            Swal.fire({
                                                                title: "Product is changing state",
                                                                html: "",
                                                                timer: 1000,
                                                                timerProgressBar: true,
                                                                didOpen: () => {
                                                                    Swal.showLoading();
                                                                },
                                                                willClose: () => {
                                                                    clearInterval(timerInterval);
                                                                }
                                                            }).then((result) => {
                                                                /* Read more about handling dismissals below */
                                                                if (result.dismiss === Swal.DismissReason.timer) {
                                                                    console.log("I was closed by the timer");
                                                                }
                                                            });
                                                            window.location.href = 'product-detail?search=' + search +
                                                                    '&status=' + status + '&pageNo=1' + '&cateId=' + cateID + '&proId=' + proId + '&size=' + size + '&detailId=' + detailId + '&newstatus=' + newStatus;

                                                        }
                                                    });
                                                }
                                                function changePage(pageNo) {
                                                    const size = document.querySelector('#size').value;
                                                    const search = document.querySelector('#search').value;
                                                    const status = document.querySelector('#status').value;
                                                    const cateID = document.querySelector('#cateId').value;
                                                    const proId = document.querySelector('#proId').value;
                                                    window.location.href = 'product-detail?search=' + search +
                                                            '&status=' + status + '&pageNo=' + pageNo + '&cateId=' + cateID + '&proId=' + proId + '&size=' + size;
                                                }

                                                const successElement = document.getElementById('success');
                                                const errorElement = document.getElementById('error');

                                                if (successElement && successElement.value) {
                                                    successfully('success');
                                                }

                                                if (errorElement && errorElement.value) {
                                                    errors(errorElement.value);
                                                }
                                                function successfully(text) {
                                                    console.log(text);
                                                    let timerInterval;
                                                    Swal.fire({
                                                        title: text,
                                                        icon: "success",
                                                        showConfirmButton: false,
                                                        timer: 1500,
                                                        timerProgressBar: true,
                                                        didOpen: () => {
                                                            const timer = Swal.getPopup().querySelector("b");
                                                            timerInterval = setInterval(() => {

                                                            }, 100);
                                                        },
                                                        willClose: () => {
                                                            clearInterval(timerInterval);
                                                        }
                                                    }).then((result) => {
                                                    });
                                                }

    </script>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title> Manage Product | The Perfume Shop</title>
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


    </head>

    <body>
        <div class="container-fluid">
            <!-- Navigation -->
            <jsp:include page="../partials/navigation.jsp"></jsp:include>

                <!-- Main Content -->
                <div class="main" style="margin-left: 50px; margin-right: 50px;">
                    <div class="topbar">

                    </div>

                    <div class="row" style="margin-right: 70px;  padding: 10px; border: 1.5px solid #000;">
                        <input type="hidden" id="pageNo" name="pageNo" value="${currentPage}">
                    <div class="col-12" style="margin-bottom: 40px;">
                        <h1>Product</h1>
                        <input type="hidden" id="success" value="${requestScope.success}" >
                    </div>
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
                    <div class="col-1"></div>
                    <div class="col-2">
                        <select class="form-control" id="status" name="status">
                            <option value="-1" ${status==null ? 'selected' : '' }>All status</option>
                            <option value="1" ${status==1 ? 'selected' : '' }>Show</option>
                            <option value="0" ${status==0 ? 'selected' : '' }>Hidden</option>
                        </select>
                    </div>
                    <div class="col-2">
                        <select class="form-control" id="cateId" name="cateId">
                            <option value="-1" ${cateId==null ? 'selected' : '' }>All Category</option>
                            <c:forEach  items="${listCate}" var="cate" >
                                <option value="${cate.categoryID}" ${cate.categoryID == cateId ? 'selected' : '' }>${cate.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-2">
                        <select class="form-control" id="brandId" name="brandId">
                            <option value="-1" ${brandId==null ? 'selected' : '' }>All Brands</option>
                            <c:forEach  items="${listBrands}" var="brand" >
                                <option value="${brand.getBrandID()}" ${brandId==brand.getBrandID() ? 'selected' : '' } >${brand.getBrandName()}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-2">
                        <div class="text-right">

                            <a style="color: white;" href="add-new-product"> <button type="button" class="btn btn-info w-100" data-toggle="modal"
                                                                                     data-target="#addnewModal">Add New </button></a>

                        </div>
                    </div>
                    <div class="col-12" style="margin-top: 10px;">
                        <div class="table-responsive">
                            <table class="table table-striped align-items-center">

                                <thead>
                                    <tr>
                                        <th scope="col">Product ID</th>
                                        <th scope="col">Product Image</th>
                                        <th scope="col">Product Name</th>
                                        <th scope="col">Category</th>
                                        <th scope="col">Brands</th>
                                        <th scope="col">Date of init</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>   
                                    <c:forEach items="${listProduct}" varStatus="loop" var="listProduct">
                                        <tr class="">
                                            <td>${listProduct.productID}</td>
                                            <td><img src="${listProduct.productImageUrl}" style="width: 75px; display: table; margin: 0px -10px;" alt=""></td>
                                            <td><a class="link-dark" href="update-product?proId=${listProduct.productID}">${listProduct.productName}</a></td>
                                            <td>${listCate[listProduct.getCategoryID()-1].getCategoryName()}</td>                                      
                                            <td>${listBrands[listProduct.getBrandID()-1].getBrandName()}</td>   
                                            <td>${listProduct.productCreateDate}</td>   
                                            <!-- create button Block if status is 1 and Unblock if status is 0 and have tag a href is updateStatusAdmin?status?id-->
                                            <td>
                                                <c:choose>
                                                    <c:when test="${listProduct.productStatus == 0}">
                                                        <button type="button" onclick="changeStatus('Do you want to set view product?',${listProduct.productID}, 1)" class="btn w-75 btn-warning">
                                                            Hidden
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${listProduct.productStatus == 1}">
                                                        <button type="button" onclick="changeStatus('Do you want to set hine product?',${listProduct.productID}, 0)" class="btn w-75 btn-success">
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
    </script>
    <script>

        //set time for alertMessage
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
            const search = document.querySelector('#search').value;
            const status = document.querySelector('#status').value;
            const cateID = document.querySelector('#cateId').value;
            const brandId = document.querySelector('#brandId').value;
            window.location.href = 'marketing-manager-products?search=' + search +
                    '&status=' + status + '&pageNo=1' + '&cateID=' + cateID + '&brandId=' + brandId;
        }
        ;

        // handle filter status
        const status = document.querySelector('#status');
        status.addEventListener('change', () => {
            const search = document.querySelector('#search').value;
            const status = document.querySelector('#status').value;
            const cateID = document.querySelector('#cateId').value;
            const brandId = document.querySelector('#brandId').value;
            window.location.href = 'marketing-manager-products?search=' + search +
                    '&status=' + status + '&pageNo=1' + '&cateID=' + cateID + '&brandId=' + brandId;
        });


        // handle filter cateID
        const cateID = document.querySelector('#cateId');
        cateID.addEventListener('change', () => {
            const search = document.querySelector('#search').value;
            const status = document.querySelector('#status').value;
            const cateID = document.querySelector('#cateId').value;
            const brandId = document.querySelector('#brandId').value;
            window.location.href = 'marketing-manager-products?search=' + search +
                    '&status=' + status + '&pageNo=1' + '&cateID=' + cateID + '&brandId=' + brandId;
        });

        //handle filter brands
        const brandId = document.querySelector('#brandId');
        brandId.addEventListener('change', () => {
            const search = document.querySelector('#search').value;
            const status = document.querySelector('#status').value;
            const cateID = document.querySelector('#cateId').value;
            const brandId = document.querySelector('#brandId').value;
            window.location.href = 'marketing-manager-products?search=' + search +
                    '&status=' + status + '&pageNo=1' + '&cateID=' + cateID + '&brandId=' + brandId;
        });

        // handle pagination
        function changeStatus(message, pid, newStatus) {
            const search = document.querySelector('#search').value;
            const status = document.querySelector('#status').value;
            const cateID = document.querySelector('#cateId').value;
            const brandId = document.querySelector('#brandId').value;
            const pageNo = document.querySelector('#pageNo').value;
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
                            const timer = Swal.getPopup().querySelector("b");
                            timerInterval = setInterval(() => {
                                timer.textContent = `${Swal.getTimerLeft()}`;
                            }, 100);
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
                    window.location.href = 'marketing-manager-products?search=' + search +
                            '&status=' + status + '&cateID=' + cateID + '&brandId=' + brandId + "&pageNo=" + pageNo + "&proId=" + pid + "&newstatus=" + newStatus;

                }
            });

        }
        function changePage(pageNo) {
            const search = document.querySelector('#search').value;
            const status = document.querySelector('#status').value;
            const cateID = document.querySelector('#cateId').value;
            const brandId = document.querySelector('#brandId').value;
            window.location.href = 'marketing-manager-products?search=' + search +
                    '&status=' + status + '&cateID=' + cateID + '&brandId=' + brandId + "&pageNo=" + pageNo;
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

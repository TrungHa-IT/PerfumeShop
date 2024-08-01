<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>EShopper - Bootstrap Shop Template</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Free HTML Templates" name="keywords">
        <meta content="Free HTML Templates" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet"> 

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->

        <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        -->
        <style>
            /* General Styles */
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }

            .container-fluid {
                padding-top: 50px;
            }

            .table-responsive {
                margin-bottom: 30px;
            }

            /* Table Styles */
            .table {
                border-collapse: separate;
                border-spacing: 0 15px;
                border: none;
            }

            .table thead th {
                background-color: #343a40;
                color: #ffffff;
                border: none;
            }

            .table tbody tr {
                background-color: #ffffff;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .table tbody tr td {
                vertical-align: middle;
                border: none;
            }

            .table tbody tr td img {
                width: 50px;
            }

            .table tbody tr td form .input-group {
                width: 120px;
                margin: 0 auto;
            }

            .table tbody tr td form .input-group .btn {
                background-color: #007bff;
                color: #ffffff;
            }

            .table tbody tr td form .input-group .form-control {
                background-color: #e9ecef;
                color: #495057;
                border: none;
                text-align: center;
            }

            /* Card Styles */
            .card {
                border: none;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .card-header {
                background-color: #343a40;
                color: #ffffff;
                border: none;
            }

            .card-body h6 {
                font-weight: 500;
            }

            .card-footer {
                background-color: #ffffff;
                border: none;
            }

            /* Button Styles */
            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }

            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #004085;
            }

            .btn-block {
                display: block;
                width: 100%;
            }

            .my-3 {
                margin-top: 1rem !important;
                margin-bottom: 1rem !important;
            }

            .py-3 {
                padding-top: 1rem !important;
                padding-bottom: 1rem !important;
            }

            /* Input Styles */
            .form-control {
                border-radius: 0;
            }

            .input-group .form-control {
                border-right: 0;
            }

            .input-group .form-control:focus {
                border-color: #007bff;
            }

            .input-group .input-group-btn .btn {
                border-left: 0;
            }

            .text-danger {
                color: #dc3545 !important;
            }
            /* Adjust button and input size */
            .input-group-btn .btn {
                width: 30px;
                height: 30px;
                padding: 0;
                border-radius: 0;
            }
            .input-group .form-control {
                width: 50px;
                text-align: center;
                padding: 0.375rem 0.75rem;
                border-radius: 0;
            }

            .input-group {
                display: flex;
                align-items: center;
                justify-content: center;
            }

            /* General Button Styling */
            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
                color: #fff;
            }

            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #004085;
            }

            /* Ensuring input and buttons align correctly */
            .input-group-btn {
                display: flex;
                flex-direction: column;
            }
            .scroll{
                width: 100%;
                height: 550px;
                overflow-y: scroll;
            }

        </style>
    </head>

    <body>


        <!-- Page Header Start -->
        <header style="padding-bottom: 80px">
            <div class="main_header header_transparent header-mobile-m">
                <div class="header_container sticky-header" style="padding: 0">
                    <div class="container-fluid" style="background-color: black">
                        <div class="row align-items-center" style="padding: 8px 0">
                            <div class="col-lg-2">
                                <div class="logo">
                                    <a href="home"><img src="images/logo/logo0.png" alt=""></a>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="main_menu menu_two menu_position">
                                    <nav>
                                        <ul class="nav nav-pills nav-fill">
                                            <li class="nav-item active">
                                                <a class="nav-link" href="home">HOME</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="#">ABOUT US</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" class="${cid_refine==0?"active":""}" href="refine?cid=${0}">PERFUMES
                                                    <i class="fa fa-caret-down" data-toggle="dropdown"></i>
                                                </a>
                                                <ul class="dropdown-menu">
                                                    <c:forEach var="category" items="${requestScope.categories}">
                                                        <li class="nav-item-lv2">
                                                            <a class="nav-link" class="${category.categoryID==cid_refine?"active":""}" href="refine?cid_refinee=${category.categoryID}">
                                                                ${category.categoryName}'s Perfumes
                                                            </a>
                                                        </li>
                                                    </c:forEach>                                                  
                                                </ul>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="#">BRANDS
                                                    <i class="fa fa-caret-down" data-toggle="dropdown"></i>
                                                </a>
                                                <ul class="dropdown-menu multi-column">
                                                    <div class="row">
                                                        <c:forEach var="brand" items="${requestScope.brands}">
                                                            <div class="col-md-4">
                                                                <li class="nav-item-lv2">
                                                                    <a class="nav-link" href="refine?bid_refinee=${brand.getBrandID()}">${brand.getBrandName()}</a>
                                                                </li>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </ul>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="">CONTACT US</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="">BLOGS</a>
                                            </li>

                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <div class="header_search search_form">
                                    <form class="input-group search-bar search_form has-validation-callback " action="searchHome" method="get" role="search"> 
                                        <input type="text" name="query" value placeholder="Search your products..." class="input-group-field st-default-search-input search-text" autocomplete="off">
                                        <span class="input-group-btn">
                                            <button class="btn icon-fallback-text">
                                                <i class="fa fa-search"></i>
                                            </button>
                                        </span>
                                    </form>
                                </div>
                            </div>                 
                            <div class="col-lg-2">
                                <jsp:include page="header_right.jsp"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- Page Header End -->


        <!-- Cart Start -->
        <div class="container-fluid pt-5" >
            <div class="row px-xl-5">
                <div class="col-lg-8 table-responsive mb-5">
                    <div class="row scroll">
                        <table class="table table-bordered text-center mb-0">
                            <thead class="bg-secondary text-dark">

                                <tr>
                                    <th>Product Image</th>
                                    <th>Product Name</th>
                                    <th>Size</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th>Remove</th>
                                </tr>
                            </thead>

                            <c:set var="total" value="0"/>
                            <c:set var="o" value="${requestScope.cart}"/>

                            <tbody class="align-middle">

                                <c:forEach items="${o.items}" var="i" varStatus="loop">


                                    <tr>
                                        <td class="align-middle"><img src="${i.product.getImage()}" alt="" style="width: 60px; height: 60px"></td>
                                        <td class="align-middle">${i.getName()}</td>
                                <input name="name" value="${i.getName()}" type="hidden"/>
                                <td class="align-middle">${i.product.getProductSize()}</td>
                                <td class="align-middle">${i.product.getProductPrice()}$</td>
                                <td class="align-middle">
                                    <form action="shop" method="post" id="myForm${loop.index}" class="form">
                                        <input type="hidden" name="deletecard" value="">
                                        <div class="input-group quantity mx-auto">
                                            <input type="hidden" value="${i.product.getProductFullDetailID()}" name="pdID"/>
                                            <span id="quanError${loop.index}" class="text-danger"></span>
                                            <div class="input-group-btn">
                                                <button class="btn btn-sm  bg-dark btn-minus" type="submit" class="changeQuantity" name="minus" value="1">
                                                    <i class="fa fa-minus"></i>
                                                </button>
                                            </div>
                                            <input type="text" disabled="" pattern="[0-9]*" maxlength="3" class="form-control form-control-sm  text-center" id="newquant${loop.index}" placeholder="${i.getQuantity()}">
                                            <div class="input-group-btn">
                                                <button class="btn btn-sm bg-dark btn-plus" type="submit" class="changeQuantity" ${i.product.getProductAvaiable()- i.getQuantity() <= 0 ? 'disabled' : ''} name="add" value="1">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </td>
                                <td class="align-middle">
                                    <c:set var="itemTotal" value="${i.product.getProductPrice() * i.getQuantity()}"/>
                                    <fmt:formatNumber value="${itemTotal}" type="number" pattern="#,##0.00"/>$
                                </td>
                                <td class="align-middle ">
                                    <button class="btn text-warning" style="background-color: #ffffff" type="submit"  onclick="deleteCart('${loop.index}')" >DELETE</button>
                                </td>
                                </tr>
                                <c:set var="total" value="${total + itemTotal}"/>


                            </c:forEach>

                            </tbody>

                        </table>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card border-secondary mb-5">
                        <div class="card-header bg-secondary border-0">
                            <h4 class="font-weight-semi-bold m-0">Cart Summary</h4>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-3 pt-1">
                                <h6 class="font-weight-medium">Subtotal</h6>
                                <h6 class="font-weight-medium">${total}$</h6>
                            </div>

                            <div class="d-flex justify-content-between">
                                <h6 class="font-weight-medium">Shipping</h6>
                                <h6 class="font-weight-medium">Freeship</h6>
                            </div>
                        </div>
                        <form action="checkout">
                            <div class="card-footer border-secondary bg-transparent">
                                <div class="d-flex justify-content-between mt-2">
                                    <h5 class="font-weight-bold">Total</h5>
                                    <h5 class="font-weight-bold"><fmt:formatNumber value="${total}" type="number"  pattern="#,##0.00"/>$</h5>
                                </div>
                                <input type ="hidden" value="${total}" name="totalprice"/>
                                <button  class="btn btn-block bg-dark mb-3 my-3 py-3"><span style="color: #fff; font-weight: bold">Proceed To Checkout</span></button>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
        <!-- Cart End -->

        <!-- Footer Start -->
        <footer class="footer">        
            <jsp:include page="footer.jsp"/>
        </footer>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-primary back-to-top"><i class="fa fa-angle-double-up"></i></a>

    </body>
    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Contact Javascript File -->
    <script src="mail/jqBootstrapValidation.min.js"></script>
    <script src="mail/contact.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
                                        function notice() {
                                            if (confirm("Delete all items in cart?")) {
                                                document.getElementById("deleteForm").submit();
                                            }
                                        }

                                        function deleteCart(index) {
                                            if (confirm("Do you want delete product?")) {
                                                const form = document.getElementById('myForm' + index);
                                                var inputElement = form.querySelector('input[name="deletecard"]');
                                                inputElement.value = index;
                                                form.submit();
                                            }
                                        }

                                        function sendCode(code) {
                                            window.location.href = 'applyvouchers?code=' + code;
                                        }



                                        document.querySelectorAll('.quantity').forEach((inputElement, index) => {
                                            inputElement.addEventListener('keypress', (event) => {
                                                if (event.key === 'Enter') {
                                                    event.preventDefault();
                                                    const value = document.getElementById('newquant' + index).value;
                                                    const value1 = document.getElementById('quantity' + index).value;
                                                    if (value1 < value) {
                                                        document.getElementById('quanError' + index).innerText = 'fail';
                                                        return false;
                                                    } else {
                                                        document.getElementById('newquantity' + index).setAttribute('value', value);
                                                        document.getElementById('myForm' + index).submit();
                                                    }

                                                }
                                            });
                                        });
    </script>


</html>
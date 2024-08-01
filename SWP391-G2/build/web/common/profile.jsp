<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="icon" href="./assets/img/M.png" type="image/x-icon" />
        <link rel="stylesheet" href="assets/css/style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <style type="text/css">
            .nav-borders .nav-link.active {
                color: #0061f2;
                border-bottom-color: #0061f2;
            }
            .nav-borders .nav-link {
                color: #69707a;
                border-bottom-width: 0.125rem;
                border-bottom-style: solid;
                border-bottom-color: transparent;
                padding-top: 0.5rem;
                padding-bottom: 0.5rem;
                padding-left: 0;
                padding-right: 0;
                margin-left: 1rem;
                margin-right: 1rem;
            }
            .card {
                border: none;
                border-radius: 10px;
                width: 100%;
                margin-top: 10%;
            }
            .btn-secondary {
                height: 40px !important;
                margin-top: 3px;
            }
            .btn-secondary:focus {
                box-shadow: none;
            }
            .container-xl {
                padding-top: 100px;
                padding-bottom: 100px;
            }
            .header_container {
                padding: 0;
            }
            .header_container .container-fluid {
                background-color: black;
            }
            .header_container .row {
                padding: 8px 0;
            }
            .main_menu ul {
                display: flex;
                justify-content: space-around;
            }
            .search_form {
                display: flex;
                justify-content: center;
            }
            .block-account ul {
                padding: 0;
                list-style: none;
            }
            .block-account ul li a {
                display: block;
                padding: 10px;
                text-decoration: none;
                color: #000;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            .block-account ul li a:hover, .block-account ul li a.active {
                background-color: #0074bf;
                color: #fff;
            }
            .title-head {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 20px;
            }
            .form-signup p {
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="main_header header_transparent header-mobile-m">
                <div class="header_container sticky-header">
                    <div class="container-fluid">
                        <div class="row align-items-center">
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
                                    <form class="input-group search-bar search_form has-validation-callback" action="searchHome" method="get" role="search"> 
                                        <input type="text" name="query" placeholder="Search your products..." class="input-group-field st-default-search-input search-text" autocomplete="off">
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
        <div class="container-xl px-4 mt-4">
            <section class="signup page_customer_account">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-lg-3 col-left-ac">
                            <div class="block-account">
                                <h5 class="title-account">Trang tài khoản</h5>
                                <p>Xin chào, <span style="color:#0074bf;">Trung Hà</span>&nbsp;!</p>
                                <ul>
                                    <li>
                                        <a disabled="disabled" class="title-info active" title="Thông tin tài khoản" href="javascript:void(0);">Thông tin tài khoản</a>
                                    </li>
                                    <li>
                                        <a class="title-info" href="myorder" title="Đơn hàng của bạn">Đơn hàng của bạn</a>
                                    </li>
                                    <li>
                                        <a class="title-info" href="./commonchangepassword.jsp" title="Đổi mật khẩu">Đổi mật khẩu</a>
                                    </li>
                                    <li>
                                        <a class="title-info" href="/account/logout" title="Đăng xuất">Đăng xuất</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-lg-9 col-right-ac">
                            <h1 class="title-head margin-top-0">Thông tin tài khoản</h1>
                            <div class="form-signup name-account m992">
                                <p><strong>Họ tên:</strong>  Trung Hà</p>
                                <p> <strong>Email:</strong> hatrung03022003@gmail.com</p>
                                <p> <strong>Điện thoại:</strong> 0944362886 </p>
                                <p><strong>Công ty:</strong> An Giang</p>
                                <p><strong>Địa chỉ :</strong> ${requestScope.address}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </body>
    <!-- Footer Start -->
    <footer class="footer">        
        <jsp:include page="footer.jsp"/>
    </footer>
    <!-- Footer End -->
</html>

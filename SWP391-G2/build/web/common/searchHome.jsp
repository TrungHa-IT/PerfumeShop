<%-- 
    Document   : searchHome
    Created on : 26 thg 6, 2024, 22:25:06
    Author     : pna29
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>The Perfume Shop | Genuine Perfume Store</title>
        <link rel="icon" href="./images/logo/image.png" type="image/x-icon" />
        <link href="css/homestyle.css" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdn.tailwindcss.com/3.3.2"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js"/>
        <style>
        </style>
    </head>

    <body style="background: #f8f8f8">

        <header>
            <div class="main_header header_transparent header-mobile-m">
                <div class="header_container sticky-header" style="padding: 0">
                    <div class="container-fluid" style="background-color: black">
                        <div class="row align-items-center" style="padding: 8px 0">
                            <div class="col-lg-3">
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
                            <div class="col-lg-3">
                                <jsp:include page="header_right.jsp"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <div class="home_section_two color_two mb-70" style="margin-top: 100px; margin-bottom: 50px">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12 mx-auto">
                        <div class="home_section_right">
                            <div class="product_area">
                                <div class="section_title_style2" style="margin-top: 50px">
                                    <c:if test="${empty productList}">
                                        <div style="text-align: center; font-size: 18px; text-transform: uppercase">
                                            Can't find what you're looking for ? Explore our favorites—they could be your next perfect choice ! Don't miss out—discover now !
                                            <div style="text-align: center; font-size: 13px; text-transform: uppercase">
                                                Please enter another search keyword!
                                            </div>
                                            <div class="row justify-content-center">
                                                <div class="header_search search_form">
                                                    <form class="input-group search-bar search_form has-validation-callback " action="searchHome" method="get" role="search" style="max-width: 500px"> 
                                                        <input type="text" name="query" value placeholder="Search your products..." class="input-group-field st-default-search-input search-text" autocomplete="off" style="color: #000">
                                                        <span class="input-group-btn">
                                                            <button class="btn icon-fallback-text">
                                                                <i class="fa fa-search"></i>
                                                            </button>
                                                        </span>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>                     
                                </div>
                                <c:if test="${not empty productList}">
                                    <div class="header_search search_form">
                                        <form class="input-group search-bar search_form has-validation-callback " action="searchHome" method="get" role="search" style="max-width: 500px"> 
                                            <input type="text" name="query" value placeholder="Search your products..." class="input-group-field st-default-search-input search-text" autocomplete="off">
                                            <span class="input-group-btn">
                                                <button class="btn icon-fallback-text">
                                                    <i class="fa fa-search"></i>
                                                </button>
                                            </span>
                                        </form>
                                    </div>

                                    <div  style="text-align: center; font-size: 18px; text-transform: uppercase; font-weight: bold; padding-top: 20px">
                                        Results : ${totalResult} products
                                    </div>

                                    <div class="row justify-content-center" style="padding: 20px;">
                                        <c:forEach var="i" items="${productList}">
                                            <div class="product_items col-lg-3 col-md-4 col-sm-6" style="margin: 30px 0;">
                                                <div class="single_product" style="border: 2px solid #f6692a; border-radius: 3px; width: 100%; height: auto;">
                                                    <figure>
                                                        <div class="product_thumb">
                                                            <a href="detailofproduct?productID=${i.getProductID()}" class="primary_img">
                                                                <img src="${i.productImageUrl}" alt="" style="width: 100%; height: auto;">
                                                            </a>
                                                            <div class="action_links" style="margin-top: 10px;">
                                                                <ul>
                                                                    <li class="add_to_cart" onclick="">
                                                                        <a href="#" data-toggle="modal" data-target="#modal_box" title="Add to cart">
                                                                            <i class="fa fa-shopping-cart"></i>
                                                                        </a>
                                                                    </li>
                                                                    <li class="wishlist">
                                                                        <a href="#" onclick="addToWishlist(event, ${i.getProductID()})" title="Thêm vào mục yêu thích">
                                                                            <i style="color: #f6692a" class="fa-solid fa-heart"></i>
                                                                        </a>
                                                                    </li>
                                                                    <li style="border-color: orange" class="quick_button" onclick="">
                                                                        <a href="#" data-toggle="modal" data-target="#modal_box" title="Quick view">
                                                                            <i class="fa fa-eye"></i>
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <figcaption class="product_content" style="text-align: center; margin-top: 10px;">
                                                            <h4 class="product_name ani-fire" style="font-size: 15px;padding: 10px">
                                                                <a href="#">${i.productName}</a>
                                                            </h4>
                                                            <div class="price_box" style="padding-left: 10px">
                                                                <span class="current_price" >$${i.priceMin} - $${i.priceMax}</span>

                                                        </figcaption>
                                                    </figure>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <section class="blog_section blog_two color_two mb-65" style="padding-top: 50px">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section_title">
                        <h2><span class="ani-fire">From Our Blog</span></h2>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="blog_carousel blog_column3 owl-carousel">
                    <div class="col-lg-3">
                        <div class="single_blog">
                            <figure>
                                <div class="blog_thumb">
                                    <a href="#">
                                        <img src="images/blog1.jpg" alt="">
                                    </a>
                                </div>

                            </figure>
                        </div>
                    </div>

                    <div class="col-lg-3">
                        <div class="single_blog">
                            <figure>
                                <div class="blog_thumb">
                                    <a href="#">
                                        <img src="images/blog2.jpg" alt="">
                                    </a>
                                </div>

                            </figure>
                        </div>
                    </div>

                    <div class="col-lg-3">
                        <div class="single_blog">
                            <figure>
                                <div class="blog_thumb">
                                    <a href="#">
                                        <img src="images/blog3.jpg" alt="">
                                    </a>
                                </div>

                            </figure>
                        </div>
                    </div>

                    <div class="col-lg-3">
                        <div class="single_blog">
                            <figure>
                                <div class="blog_thumb">
                                    <a href="#">
                                        <img src="images/blog4.jpg" alt="">
                                    </a>
                                </div>
                            </figure>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <footer class="footer">

        <jsp:include page="footer.jsp"/>
    </footer>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>   
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/owl.carousel.min.js"></script>
    <script src="js/clickevents.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>

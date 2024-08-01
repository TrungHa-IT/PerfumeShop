<%-- 
    Document   : viewWishlist
    Created on : 15 thg 7, 2024, 11:34:51
    Author     : pna29
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Wishlist | The Perfume Shop</title>
        <link rel="icon" href="images/logo1.png"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.carousel.min.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
        <style>
            /* General styling */
            .container {
                max-width: 960px;
                margin: 0 auto;
            }

            .text_page_head, .text_page {
                font-weight: bold;
                color: #333;
            }

            .product-image img {
                max-width: 100%;
                height: auto;
            }

            .btn-select {
                background-color: #333;
                color: white;
                border: none;
                padding: 8px 16px;
                cursor: pointer;
                border-radius: 3px;
                margin-bottom: 10px;
                width: 150px;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }
            .btn-select:hover {
                background-color: #fd7e14;
            }
            .delete-wishlist .btn-delete:hover{
                background-color: #fd7e14;
            }
            .delete-wishlist .btn-delete{
                background-color: #b93f06;
                color: white;
                border: none;
                padding: 8px 16px;
                cursor: pointer;
                border-radius: 3px;
                margin-bottom: 10px;
                width: 150px;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }

            @keyframes fire {
                from {
                    transform: translateY(0);
                }
                to {
                    transform: translateY(-5px);
                }
            }

        </style>
    </head>
    <body>
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
        <div class="container px-4 py-5 mx-auto text-center" >
            <c:if test="${empty wishlist}">
                <img src="images/emptycart2.png" width="700px" alt="Emptycart" />
            </c:if>
            <c:if test="${not empty wishlist}">
                <h2 class="ani-fire" style="padding: 60px;
                    font-weight: bold ">YOUR WISHLIST</h2>
                <div class="wishlist-table">
                    <div class="row text-left" style="background-color: #f8f8f8;
                         margin-bottom: 10px;
                         border: 2px solid #ddd;
                         padding: 10px;">
                        <div class="col mt-2 text_page_head ani-fire">
                            <span style=" font-weight: bolder;">NO</span>
                        </div>
                        <div class="col-2 mt-2 text_page_head ani-fire">
                            <span style=" font-weight: bolder;">PRODUCT IMAGE</span>
                        </div>
                        <div class="col-3 mt-2 text_page_head ani-fire">
                            <span style=" font-weight: bolder;">PRODUCT NAME</span> 
                        </div>
                        <div class="col mt-2 text_page_head ani-fire">
                            <span style=" font-weight: bolder;">STATUS</span>
                        </div>
                        <div class="col mt-2 text_page_head ani-fire">
                            <span style=" font-weight: bolder;">PRICE</span>
                        </div>
                        <div class="col-2 mt-2 text_page_head ani-fire">
                            <span style=" font-weight: bolder;">DATE ADDED </span>
                        </div>
                        <div class="col-2 mt-2 text_page_head ani-fire">
                            <span style=" font-weight: bolder;">OPTIONS</span>
                        </div>
                    </div>
                    <c:set var="stt" value="0"/>
                    <c:forEach var="item" items="${wishlist}">
                        <c:set var="stt" value="${stt+1}"/>
                        <div class="row text-left" style="background-color: #f8f8f8";
                             margin-bottom: 10px;
                             border: 2px solid #ddd;
                             padding: 10px;">
                            <div class="col mt-2 text_page">
                                ${stt}
                            </div>
                            <div class="col-2 mt-2 text_page">
                                <div class="product-image">
                                    <img src="${item.product.productImageUrl}" style="width: 110px;
                                         height: 110px" alt="Product Image">
                                </div>
                            </div>
                            <div class="col-3 mt-2 text_page">
                                ${item.product.productName} 
                            </div>
                            <div class="col mt-2 text_page">
                                ${(item.product.productStatus == 0  ? 'Out Of Stock' : 'In Stock')}
                            </div>
                            <div class="col mt-2 text_page">
                                $${item.productFullDetail.productPrice}
                            </div>
                            <div class="col-2 mt-2 text_page">
                                ${item.dateAdded} 
                            </div>
                            <div class="col-2 mt-2 text_page">
                                <div class="select-options">
                                    <button class="btn-select"><a href="detailofproduct?productID=${item.product.getProductID()}">Select Options</a></button>
                                </div>
                                <div class="delete-wishlist">
                                    <form action="viewWishlist" method="post" onsubmit="return confirm('Are you sure you want to delete this item?');" >
                                        <input type="hidden" name="accountID" value="${sessionScope.account.accountID}" />
                                        <input type="hidden" name="productID" value="${item.product.productID}" />
                                        <button type="submit" class="btn-delete">Delete</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
        <div class="footer">
            <jsp:include page="footer.jsp"/>
        </div>
        <script>
        </script>

    </body>
</html>

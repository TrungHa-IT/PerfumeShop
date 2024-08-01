<%-- 
    Document   : header_right
    Created on : 17 thg 6, 2024, 22:49:41
    Author     : pna29
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.DecimalFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfume | E-Commerce</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css">
        <link rel="stylesheet" href="css/homestyle.css">   
        <style>
            .auth-links {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 1rem;
            }

            .nav-link {
                text-decoration: none;
                color: #fff;
                padding: 0.5rem;
                transition: color 0.3s ease, background-color 0.3s ease;
                font-weight: bold;
            }

            .nav-link:hover {
                color: #f44336;
                background-color: #e9ecef;
                border-radius: 0.25rem;
            }

            .auth-links span {
                color: #fff;
            }

            .mini_cart_wrapper span.item_count {
                position: absolute;
                top: -6px;
                right: -10px;
                width: 17px;
                height: 17px;
                line-height: 17px;
                border-radius: 100%;
                text-align: center;
                background: #f6692a;
                font-weight: 400;
                font-size: 10px;
                color: #fff;
            }
        </style>

    </head>
    <body>
        <div class="header_right">
            <div class="header_top_right" >
                <div class="my-wishlist">
                    <a href="viewWishlist">
                        <i class="fa fa-heart"></i>
                    </a>
                </div>   
                <div class="my-cart top-cart-contain mini-cart">
                    <c:if test="${sessionScope.account != null}">
                        <a href="cartcontroller" class="a-cart">
                            <i class="fa fa-cart-plus"></i>
                        </a>
                    </c:if>
                    <c:if test="${sessionScope.account == null}">
                        <a href="shop" class="a-cart">
                            <i class="fa fa-cart-plus"></i>
                        </a>
                    </c:if>
                </div>     

                <c:if test="${sessionScope.account == null}">
                    <div class="auth-links">
                        <a class="nav-link" href="login">Log In</a>
                        <span>|</span>
                        <a class="nav-link" href="signup">Sign Up</a>
                    </div>
                </c:if>
                <c:if test="${sessionScope.account != null}">
                    <div class="my-user">
                        <a href="Profile" class="user-profile">
                            <i class="fa fa-solid fa-user"></i>
                        </a>
                    </div>
                    <div class="logout">
                        <a id="logout" href="#" onclick="confirmLogout('logoutModal')">
                            <i class="fa-solid fa-right-from-bracket"></i>

                        </a>
                        <div id="logoutModal" class="modal"></div>

                    </div>


                </c:if> 


            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>   
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/owl.carousel.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
        <script src="js/clickeventss.js"></script>      
    </body>
</html>

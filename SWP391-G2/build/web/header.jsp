<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Home | iLocal Shop</title>
        <link rel="icon" type="image/x-icon" href="img/logo.png">
        <!-- Link Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- Link File CSS -->
        <link rel="stylesheet" href="css/styles.css">
    </head>
    <body>
        <header>
            <nav>
                <div class="logo-search">

                    <a href="home" class="logo">
                        ilocal<span>shop</span>
                    </a>
                    <form action="search#category" method="post">

                        <input type="hidden" name="option" value="search"/>
                        <div class="search-box">
                            <input type="search" name="productName" id="productName" placeholder="Search Here..." value="${productName}">
                            <i id="searchIcon" class="fa-solid fa-magnifying-glass"></i>
                        </div>
                    </form>
                    <c:choose>
                        <c:when test ="${empty sessionScope['customer']}">
                            <div class="icon">
                                <a href="${pageContext.request.contextPath}/login">Login</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="icon">
                                <a href="${pageContext.request.contextPath}/profile">Hello ${customer.cusContactName}</a>
                                <a href="cart"><i class="fa-solid fa-cart-shopping"></i></a>
                                <a href="${pageContext.request.contextPath}/logout">Logout</a>
                            </div>
                        </c:otherwise> 
                    </c:choose>
                </div>

                <ul>
                    <li class="home"><a href="home#anchor">Home</a></li>
                    <li><a href="home#anchor">contact</a></li>
                </ul>
            </nav>
        </header>
    </body>
</html>

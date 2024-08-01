<%-- 
    Document   : search_ajax
    Created on : 24 thg 6, 2024, 22:25:14
    Author     : pna29
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Perfume Shop | Genuine Perfume Store</title>
        <link rel="icon" href="./images/logo/image.png" type="image/x-icon" />
    </head>
    <body>

        <c:forEach items="${requestScope.productPage}" var="i">
            <div class="product_items ${(requestScope.col == 4)?"col-lg-4":"col-lg-3"}" style="margin: 30px 0">
                <article class="single_product" style="border: 2px solid #f6692a; border-radius: 3px; padding: 20px; width: 100%; height: auto;">
                    <figure>
                        <div class="product_thumb">
                            <a href="detailofproduct?productID=${product.getProductID()}" class="primary_img">
                                <img src="${i.productImageUrl}" alt="">
                            </a>
                            <div class="action_links">
                                <ul>
                                    <li class="add_to_cart" 
                                        onclick="" >
                                        <a href="#" data-toggle="modal" data-target="#modal_box" title="Thêm vào giỏ hàng">
                                            <i class="fa fa-shopping-cart"></i>
                                        </a>
                                    </li>
                                    <li class="wishlist">
                                        <a href="#" onclick="addToWishlist(event, ${i.getProductID()})" title="Thêm vào mục yêu thích">
                                            <i style="color: #f6692a" class="fa-solid fa-heart"></i>
                                        </a>
                                    </li>
                                    <li style="border-color: orange" class="quick_button"
                                        onclick="" 
                                        >
                                        <a  href="#" data-toggle="modal"
                                            data-target="#modal_box" title="Xem sản phẩm">
                                            <i style="" class="fa fa-eye"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <figcaption class="product_content">
                            <h4 class="product_name ani-fire" style="font-size: 15px; padding-left: 10px">                                             
                                <a href="#">${i.productName}</a>
                            </h4>
                            <div class="price_box" style="padding-left: 10px">
                                <span class="current_price">$${product.priceMin} - $${product.priceMax}</span>
                            </div>
                        </figcaption>
                    </figure>
                </article>
            </div>
        </c:forEach>

    </body>
</html>

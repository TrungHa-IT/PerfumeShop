<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Status</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            .main-content {
                padding: 20px;
            }

            .os-header {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }

            .os-header svg {
                margin-right: 15px;
            }

            .os-header-heading {
                margin-left: 15px;
            }

            .product-thumbnail img {
                max-width: 50px;
                max-height: 50px;
            }

            .section {
                margin-bottom: 20px;
            }

            .content-box {
                border: 1px solid #e0e0e0;
                border-radius: 5px;
                padding: 15px;
            }

            .content-box-row {
                margin-bottom: 10px;
            }

            .step-footer {
                margin-top: 20px;
            }

            .order-summary-section {
                margin-bottom: 20px;
            }

            .total-line-table {
                width: 100%;
            }

            .total-line-table td {
                padding: 5px 10px;
            }

            /* Added CSS for better layout */
            .left-section, .right-section {
                padding: 15px;
                background-color: #f9f9f9;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .left-section {
                margin-right: 20px;
            }

            @media (min-width: 768px) {
                .main-content {
                    display: flex;
                    justify-content: space-between;
                }

                .left-section, .right-section {
                    flex: 0 0 48%;
                }
            }
            .scroll{
                width: 100%;
                height: 350px;
                overflow-y: scroll;
            }

        </style>
    </head>
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
    <body>
        <div class="main-content container-fluid">
            <div class="left-section col-md-6">
                <div class="section">
                    <div class="section-header os-header">
                        <svg width="50" height="50" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#000" stroke-width="2" class="hanging-icon checkmark">
                        <path class="checkmark_circle" d="M25 49c13.255 0 24-10.745 24-24S38.255 1 25 1 1 11.745 1 25s10.745 24 24 24z"></path>
                        <path class="checkmark_check" d="M15 24.51l7.307 7.308L35.125 19"></path>
                        </svg>
                        <div class="os-header-heading">
                            <h2 class="os-header-title">
                                Order Successful
                            </h2>
                            <span class="os-description">
                                Thank you for your purchase!
                            </span>
                        </div>
                    </div>
                </div>

                <div class="section thank-you-checkout-info">
                    <div class="section-content">
                        <div class="content-box">
                            <div class="content-box-row content-box-row-padding content-box-row-no-border">
                                <h2>Order Information</h2>
                            </div>
                            <% String selectedCity = request.getParameter("selectedCity"); %>
                            <% String selectedDistrict = request.getParameter("selectedDistrict"); %>
                            <% String selectedWard = request.getParameter("selectedWard"); %>
                            <div class="content-box-row content-box-row-padding">
                                <div class="section-content">
                                    <div class="section-content-column">
                                        <h3>Shipping Information</h3>
                                        <p>Customer Name: ${requestScope.fullname}<br>Phone Number: ${requestScope.phone}<br>Address Customer: ${requestScope.address}<br>
                                          <br>Viet Nam</p>
                                        <h3>Payment Method</h3>
                                        <p> ${requestScope.method}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="step-footer">
                    <a href="home" class="step-footer-continue-btn btn btn-primary">
                        <span class="btn-content">Continue Shopping</span>
                    </a>
                    <p class="step-footer-info">
                        <i class="icon icon-os-question"></i>
                        <span>Need help? <a href="mailto:hotro@namperfume.net">Contact us</a></span>
                    </p>
                </div>
            </div>
            <div class="left-section col-md-6">
                <div class="sidebar-content">
                    <div class="order-summary">
                        <h2 class="visually-hidden">Order Information</h2>
                        <div class="order-summary-sections">
                            <div class="order-summary-section order-summary-section-product-list" data-order-summary-section="line-items">
                                <div class="row scroll ">
                                    <table class="product-table table table-borderless">
                                        <thead>
                                            <tr>
                                                <th scope="col"><span class="visually-hidden">Image</span></th>
                                                <th scope="col"><span class="visually-hidden">Description</span></th>
                                                <th scope="col"><span class="visually-hidden">Size</span></th>
                                                <th scope="col"><span class="visually-hidden">Quantity</span></th>
                                                <th scope="col"><span class="visually-hidden">Price</span></th>
                                            </tr>
                                        </thead>
                                        <c:if test="${requestScope.listcart != null}">
                                            <c:forEach items="${requestScope.listcart}" var="cart" varStatus="loop">
                                                <tbody>
                                                    <tr class="product" data-product-id="1019508805" data-variant-id="1043378289">
                                                        <td class="product-image">
                                                            <div class="product-thumbnail">
                                                                <div class="product-thumbnail-wrapper">
                                                                    <img class="product-thumbnail-image" alt="Product Image" src="${listproduct[loop.index].getImage()}">
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="product-description">
                                                            <span class="product-description-name order-summary-emphasis">${listcart[loop.index].getName()}</span>

                                                        </td>
                                                        <td class="product-description">
                                                            <span class="product-description-name order-summary-emphasis">${listproduct[loop.index].getProductSize()}</span>

                                                        </td>
                                                        <td class="product-description">
                                                            <span class="product-description-name order-summary-emphasis">${listcart[loop.index].getQuantity()}</span>

                                                        </td>
                                                        <td class="product-price">
                                                            <span class="order-summary-emphasis">${listproduct[loop.index].getProductPrice()}$</span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${requestScope.cookieCart != null}">
                                            <c:set var="o" value="${requestScope.cookieCart}"/>
                                            <c:forEach items="${o.items}" var="i" >
                                                <tbody>
                                                    <tr class="product" data-product-id="1019508805" data-variant-id="1043378289">
                                                        <td class="product-image">
                                                            <div class="product-thumbnail">
                                                                <div class="product-thumbnail-wrapper">
                                                                    <img class="product-thumbnail-image" alt="Versace Bright Crystal Absolu" src="${i.product.getImage()}" style="width: 60px; height: 60px">
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="product-description">
                                                            <span class="product-description-name order-summary-emphasis">${i.getName()}</span>

                                                        </td>
                                                        <td class="product-description">
                                                            <span class="product-description-name order-summary-emphasis">${i.product.getProductSize()}</span>

                                                        </td>
                                                        <td class="product-description">
                                                            <span class="product-description-name order-summary-emphasis">${i.getQuantity()}</span>

                                                        </td>
                                                        <td class="product-price">
                                                            <span class="order-summary-emphasis">${i.product.getProductPrice()}$</span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </c:forEach>
                                        </c:if>
                                    </table>
                                </div>
                            </div>
                            <div class="order-summary-section order-summary-section-total-lines payment-lines" data-order-summary-section="payment-lines">
                                <table class="total-line-table table table-borderless">
                                    <thead>
                                        <tr>
                                            <th scope="col"><span class="visually-hidden">Description</span></th>
                                            <th scope="col"><span class="visually-hidden">Price</span></th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <tr class="total-line total-line-shipping">
                                            <td class="total-line-name">Shipping Fee</td>
                                            <td class="total-line-price">
                                                <span class="order-summary-emphasis" data-checkout-total-shipping-target="0">Free</span>
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot class="total-line-table-footer">
                                        <tr class="total-line">
                                            <td class="total-line-name payment-due-label">
                                                <span class="payment-due-label-total">Total</span>
                                            </td>
                                            <td class="total-line-name payment-due">
                                                <span class="payment-due-currency"></span>
                                                <span class="payment-due-price" data-checkout-payment-due-target="137750000">${requestScope.total}$</span>
                                                     
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

<!-- Footer Start -->
<footer class="footer">        
    <jsp:include page="footer.jsp"/>
</footer>
<!-- Footer End -->

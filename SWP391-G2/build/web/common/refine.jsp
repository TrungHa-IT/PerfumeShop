<%-- 
    Document   : product
    Created on : Mar 5, 2024, 4:07:55 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="./images/logo/image.png" type="image/x-icon" />
        <link href="css/homestyle.css" rel="stylesheet">
        <title>The Perfume Shop | Genuine Perfume Store</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css">
        <style>
            li a:hover {
                color: #f6692a;
            }
            ul li a.active {
                color: #f6692a;
            }

            .li_header {
                color: white;
                margin-left: 50px;
                font-size: 18px;
            }

            .submit-price {
                font-size: 16px;
                background-color: black;
                color: white;
                font-weight: 600;
                padding: 5px 40px;
                border-radius: 20px;
                margin: 10px 0 20px
            }

            .submit-price:hover {
                background-color: rgba(0,0,0,0.3);
                color: black;
                font-weight: 600;
            }

            /* CSS for making the brand section scrollable */
            .scrollable-section {
                max-height: 200px; /* Adjust the height as needed */
                overflow-y: auto;
                border: 1px solid #ddd;
                padding: 10px;
            }

            #refineProduct {
                max-height: 200px; /* Adjust this value as needed */
                overflow-y: auto;
                width: max-content;
                padding: 10px;
            }
            input[type=checkbox], input[type=radio] {
                box-sizing: border-box;
                padding: 0;
                width:20px;
                height: 20px;
            }

            /* Styling the sorting-options container */
            .sorting-options {
                margin: 20px 0;
                display: flex;
                align-items: center;
                justify-content: flex-end; /* Aligns the sorting options to the right */
                font-family: Arial, sans-serif;
            }

            /* Styling the label */
            .sorting-options label {
                margin-right: 10px;
                font-weight: bold;
                font-size: 16px;
                color: #333;
            }

            /* Styling the select box */
            .sorting-options select {
                padding: 8px 12px;
                border: 2px solid #000;
                border-radius: 4px;
                background-color: #f9f9f9;
                font-size: 16px;
                color: #333;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-bottom :7px;
            }

            /* Adding focus and hover effects */
            .sorting-options select:focus,
            .sorting-options select:hover {
                border-color: #007BFF;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
                outline: none;
            }

            /* Adding transition effect for the select box */
            .sorting-options select option {
                padding: 10px;
            }

            /* Adjusting form submission on select change */
            .sorting-options select:active {
                outline: none;
                border-color: #007BFF;
                box-shadow: none;
            }


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
                                <div class="header_search search_form">
                                    <form class="input-group search-bar search_form has-validation-callback " action="" style="max-width: 500px"> 
                                        <input value="${requestScope.searchAtHome != null ? requestScope.searchAtHome : ""}" id="searchId" type="search" oninput="searchByName()" placeholder="Search your products..." class="input-group-field st-default-search-input search-text" autocomplete="off">
                                        <span class="input-group-btn">
                                            <button class="btn icon-fallback-text">
                                                <i class="fa fa-search"></i>
                                            </button>
                                        </span>
                                    </form>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <jsp:include page="header_right.jsp"/>
                            </div>
                        </div>
                        <div class="row" style="justify-content: center; padding: 5px 0"">
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
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="home_section_two color_two mb-70" style="margin-top: 100px; margin-bottom: 50px">
            <div class="container" >
                <div class="row" style="width: 1400px;">
                    <div class="col-lg-2 col-md-12">
                        <div class="home_section_left">      
                            <c:set var="cat" value="${requestScope.categories}"/>
                            <div class="testimonial_style_two mb-60 rightleft">
                                <div class="testimonial_container">
                                    <div class="section_title section_title_style2">
                                        <h2 style="font-size: 20px"><span class="ani-fire">Filter</span></h2>
                                        <i style="font-size: 25px; margin-left: 5px; color:#f6692a" class="fa fa-filter"></i>
                                    </div>
                                    <form id="f1" action="refine" method="get">
                                        <div class="section_title section_title_style2">
                                            <h2 style="font-size: 16px;"><span class="ani-fire">Categories</span></h2>
                                            <fieldset class="responsiveFacets_sectionContent" aria-hidden="false">
                                                <c:if test="${cat != null}">
                                                    <c:forEach var="category" items="${cat}">
                                                        <div class="responsiveFacets_sectionItemLabel">
                                                            <input
                                                                type="checkbox"
                                                                name="cid_refinee"
                                                                value="${category.categoryID}"
                                                                ${category.categoryID == cid_refine ? "checked" : ""}
                                                                class="responsiveFacets_sectionItemCheckbox"
                                                                ${chid[category.categoryID] ? "checked" : ""}
                                                                onclick="setCheck(this)"/>
                                                            <label class="responsiveFacets_sectionItem" for="brand" style="font-weight: bold">
                                                                ${category.categoryName}
                                                            </label>
                                                        </div>
                                                    </c:forEach>
                                                </c:if>
                                            </fieldset>
                                        </div>
                                        <div class="section_title section_title_style2">
                                            <h2 style="font-size: 16px;"><span class="ani-fire">Brands</span></h2>
                                            <fieldset id="refineProduct" class="responsiveFacets_sectionContent" aria-hidden="false">
                                                <c:if test="${brands != null}">
                                                    <c:forEach var="brand" items="${brands}">
                                                        <div class="responsiveFacets_sectionItemLabel">
                                                            <input
                                                                type="checkbox"
                                                                name="bid_refinee"
                                                                value="${brand.brandID}"
                                                                ${bhid[brand.brandID] ? "checked" : ""}
                                                                class="responsiveFacets_sectionItemCheckbox"
                                                                onclick="setCheck(this)"/>
                                                            <label class="responsiveFacets_sectionItem" for="brand" style="font-size: 13px; font-weight: bold">
                                                                ${brand.brandName}
                                                            </label>
                                                        </div>
                                                    </c:forEach>
                                                </c:if>
                                            </fieldset>  
                                        </div> 
                                        <div class="section_title section_title_style2">
                                            <h2 style="font-size: 16px;"><span class="ani-fire">Price</span></h2>
                                            <fieldset id="refineProduct" class="responsiveFacets_sectionContent" aria-hidden="false">
                                                <div class="responsiveFacets_sectionItemLabel">
                                                    <input type="radio"
                                                           name="priceRange"
                                                           id="under25"
                                                           value="under25"
                                                           ${param.priceRange == 'under25' ? 'checked' : ''}
                                                           class="responsiveFacets_sectionItemCheckbox"
                                                           onclick="setCheck(this)"/>
                                                    <label class="responsiveFacets_sectionItem" for="under25" style="font-size: 13px; font-weight: bold">
                                                        Under $25
                                                    </label>
                                                </div>
                                                <div class="responsiveFacets_sectionItemLabel">
                                                    <input type="radio"
                                                           name="priceRange"
                                                           id="25to50"
                                                           value="25to50"
                                                           ${param.priceRange == '25to50' ? 'checked' : ''}
                                                           class="responsiveFacets_sectionItemCheckbox"
                                                           onclick="setCheck(this)"/>
                                                    <label class="responsiveFacets_sectionItem" for="25to50" style="font-size: 13px; font-weight: bold">
                                                        $25 - $50
                                                    </label>
                                                </div>
                                                <div class="responsiveFacets_sectionItemLabel">
                                                    <input type="radio"
                                                           name="priceRange"
                                                           id="50to100"
                                                           value="50to100"
                                                           ${param.priceRange == '50to100' ? 'checked' : ''}
                                                           class="responsiveFacets_sectionItemCheckbox"
                                                           onclick="setCheck(this)"/>
                                                    <label class="responsiveFacets_sectionItem" for="50to100" style="font-size: 13px; font-weight: bold">
                                                        $50 - $100
                                                    </label>
                                                </div>
                                                <div class="responsiveFacets_sectionItemLabel">
                                                    <input type="radio"
                                                           name="priceRange"
                                                           id="100to150"
                                                           value="100to150"
                                                           ${param.priceRange == '100to150' ? 'checked' : ''}
                                                           class="responsiveFacets_sectionItemCheckbox"
                                                           onclick="setCheck(this)"/>
                                                    <label class="responsiveFacets_sectionItem" for="100to150" style="font-size: 13px; font-weight: bold">
                                                        $100 - $150
                                                    </label>
                                                </div>
                                                <div class="responsiveFacets_sectionItemLabel">
                                                    <input type="radio"
                                                           name="priceRange"
                                                           id="over150"
                                                           value="over150"
                                                           ${param.priceRange == 'over150' ? 'checked' : ''}
                                                           class="responsiveFacets_sectionItemCheckbox"
                                                           onclick="setCheck(this)"/>
                                                    <label class="responsiveFacets_sectionItem" for="over150" style="font-size: 13px; font-weight: bold">
                                                        Over $150
                                                    </label>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-10 col-md-12">
                        <div class="home_section_right">
                            <div class="product_area">
                                <div class="section_title_style2" style="margin-top: 50px">

                                    <div style="text-align: start; font-size: 18px; text-transform: uppercase" class="ani-fire">
                                        Products Available
                                    </div>

                                </div>
                                <form action="refine" method="get">
                                    <!-- Existing form fields for category, brand, price range, etc. -->

                                    <!-- Sorting options -->
                                    <div class="sorting-options">
                                        <label for="sortOrder">Sort by:</label>
                                        <select name="sortOrder" id="sortOrder" onchange="this.form.submit()">
                                            <option value="">Select</option>
                                            <option value="lowToHigh" ${param.sortOrder == 'lowToHigh' ? 'selected' : ''}>Price: Low to High</option>
                                            <option value="highToLow" ${param.sortOrder == 'highToLow' ? 'selected' : ''}>Price: High to Low</option>
                                        </select>
                                    </div>
                                </form>
                                <c:set var="page" value="${requestScope.page}"/>
                                <div id="contentt" class="row">
                                    <c:set var="proA" value=""/>
                                    <c:forEach items="${requestScope.productPage}" var="product">
                                        <div class="product_items col-lg-3" style="margin: 30px 0">
                                            <article class="single_product" style="border: 2px solid #f6692a; border-radius: 3px; width: 100%; height: auto;">
                                                <figure>
                                                    <div class="product_thumb">
                                                        <a href="detailofproduct?productID=${product.getProductID()}" class="primary_img">
                                                            <img src="${product.productImageUrl}" alt="">
                                                        </a>
                                                        <div class="action_links">
                                                            <ul>
                                                                <li class="add_to_cart">
                                                                    <a href="#" data-toggle="modal" data-target="#modal_box" title="Thêm vào giỏ hàng">
                                                                        <i class="fa fa-shopping-cart"></i>
                                                                    </a>
                                                                </li>
                                                                <li class="wishlist">
                                                                    <a href="#" onclick="addToWishlist(event, ${product.getProductID()})" title="Thêm vào mục yêu thích">
                                                                        <i style="color: #f6692a" class="fa-solid fa-heart"></i>
                                                                    </a>
                                                                </li>
                                                                <li style="border-color: orange" class="quick_button">
                                                                    <a href="#" data-toggle="modal" data-target="#modal_box" title="Xem sản phẩm">
                                                                        <i class="fa fa-eye"></i>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <figcaption class="product_content">
                                                        <h4 class="product_name ani-fire" style="font-size: 15px; padding-left: 10px">
                                                            <a href="#">${product.productName}</a>
                                                        </h4>
                                                        <div class="price_box" style="padding-left: 10px">
                                                            <span class="current_price">$${product.priceMin} - $${product.priceMax}</span>
                                                        </div>
                                                        <div class="product_rating" style="font-size: 18px; padding-bottom: 12px ; padding-right: 10px">

                                                            <c:forEach begin="1" end="${productRatings[product.productID]}" var="i">
                                                                <small style="color: #ffca08;" class="fas fa-star"></small>
                                                            </c:forEach>
                                                            <!-- Check for half-star -->
                                                            <c:if test="${productRatings[product.productID] != productRatings[product.productID]}">
                                                                <small style="color: #ffca08;" class="fas fa-star-half-alt"></small>
                                                            </c:if>
                                                            <!-- Calculate empty stars -->
                                                            <c:forEach begin="1" end="${5 - productRatings[product.productID]}" var="i">
                                                                <small style="color: #ddd;" class="far fa-star"></small>
                                                            </c:forEach>

                                                        </div>
                                                    </figcaption>
                                                </figure>
                                            </article>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="pagination col-md-12 active" style="margin-top: 20px; display: flex; justify-content: center">

                                    <c:if test="${requestScope.cid_refinee == null && requestScope.bid_refinee == null && requestScope.priceRange == null && requestScope.sortOrder == null}">
                                        <c:choose>
                                            <c:when test="${requestScope.currentPage > 1}">
                                                <a href="refine?page=${requestScope.currentPage - 1}">&laquo;</a>
                                            </c:when>
                                            <c:otherwise>
                                                <span>&laquo;</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:forEach begin="1" end="${requestScope.numberpage}" var="i">
                                            <a href="refine?page=${i}" class="${requestScope.currentPage == i ? 'active' : ''}">${i}</a>
                                        </c:forEach>
                                        <c:choose>
                                            <c:when test="${requestScope.currentPage < requestScope.numberpage}">
                                                <a href="refine?page=${requestScope.currentPage + 1}">&raquo;</a>
                                            </c:when>
                                            <c:otherwise>
                                                <span>&raquo;</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                    <c:if test="${requestScope.cid_refinee != null || requestScope.bid_refinee != null || requestScope.priceRange != null}">
                                        <c:choose>
                                            <c:when test="${requestScope.currentPage > 1}">
                                                <a href="refine?page=${requestScope.currentPage - 1}&${requestScope.stringForLink}">&laquo;</a>
                                            </c:when>
                                            <c:otherwise>
                                                <span>&laquo;</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:forEach begin="1" end="${requestScope.numberpage}" var="i">
                                            <a href="refine?page=${i}&${requestScope.stringForLink}" class="${requestScope.currentPage == i ? 'active' : ''}">${i}</a>
                                        </c:forEach>
                                        <c:choose>
                                            <c:when test="${requestScope.currentPage < requestScope.numberpage}">
                                                <a href="refine?page=${requestScope.currentPage + 1}&${requestScope.stringForLink}">&raquo;</a>
                                            </c:when>
                                            <c:otherwise>
                                                <span>&raquo;</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <footer class="footer">

            <jsp:include page="footer.jsp"/>
        </footer>
        <div class="modal fade" id="modal_box" role="dialog"></div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>   
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/owl.carousel.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
        <script src="js/clickevents.js"></script>
        <script src="js/main.js"></script>
        <script type="text/javascript">

                                                                        function setCheck(obj) {

                                                                            document.getElementById('f1').submit();
                                                                        }

                                                                        function searchByName() {
                                                                            var text = document.querySelector("#searchId").value;
                                                                            $.ajax({
                                                                                url: "/SWP391-G2/searchRefine",
                                                                                type: "get",
                                                                                data: {
                                                                                    txt: text
                                                                                },
                                                                                success: function (data) {
                                                                                    var row = document.getElementById("contentt");
                                                                                    row.innerHTML = data;
                                                                                },
                                                                                error: function (xhr) {
                                                                                }
                                                                            });
                                                                        }

        </script>
    </body>
</html>

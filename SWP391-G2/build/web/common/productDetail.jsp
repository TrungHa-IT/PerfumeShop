
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Chi Tiết Sản Phẩm Nước Hoa</title>

        <link
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
            rel="stylesheet"
            integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="css/prdDetails.css" rel="stylesheet">
    </head>
    <body>
        <header>
            <input type="text" id="productname" value="${p.getProductName()}" hidden="">
            <input type="text" id="productductFullDetailID" value="${priceandsize[0].productFullDetailID}" hidden="">
            <div class="main_header header_transparent header-mobile-m">
                <div class="header_container sticky-header" style="padding: 0">
                    <div class="container-fluid" style="background-color: black">
                        <div class="row align-items-center" style="padding: 8px 0">
                            <div class="col-lg-1">
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
                            <div class="col-lg-3">
                                <jsp:include page="header_right.jsp"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <section class="py-5">
            <div class="container">
                <div class="row gx-5 align-items-center">
                    <aside class="col-lg-5">
                        <div class="mb-3">
                            <img src="${p.getProductImageUrl()}" alt="Ảnh sản phẩm 1" class="img-fluid rounded-4 shadow">
                        </div>
                        <button class="prev" onclick="changeImage(-1)">&#10094;</button>
                        <button class="next" onclick="changeImage(1)">&#10095;</button>
                        <div class="d-flex justify-content-center mb-3">
                            <div class="row gx-2">
                                <div class="col-3">
                                    <img src="${p.getProductImageUrl()}" alt="Ảnh sản phẩm 1" class="img-fluid rounded cursor-pointer" onclick="showImage('${p.getProductImageUrl()}')">
                                </div>
                                <c:forEach items="${priceandsize}" var="img">
                                    <div class="col-3">
                                        <img src="${img.getImage()}" alt="Ảnh sản phẩm 2" class="img-fluid rounded cursor-pointer" onclick="showImage('${img.getImage()}')">
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </aside>
                    <main class="col-lg-7">
                        <div>
                            <h2 class="ani-fire">${p.getProductName()}</h2>
                            <div class="my-3">
                                <div class="text-warning mb-1 me-2">
                                    <c:forEach var="i" begin="1" end="${averageStart}">
                                        <i class="fas fa-star text-warning"></i>
                                    </c:forEach>
                                    <c:forEach var="i" begin="${averageStart + 1}" end="5">
                                        <i class="far fa-star text-secondary"></i>
                                    </c:forEach>
                                    <span class="small ms-2">(${getTotalFeedback} Reviews)</span>
                                </div>
                            </div>
                            <dl class="row">
                                <dt class="col-sm-4">Trademark:</dt>
                                <dd class="col-sm-8">${b.getBrandName()}</dd>
                                <dt class="col-sm-4" id="status">Status:</dt>
                                <dd class="col-sm-8">${(priceandsize[0].productStatus == 0  ? 'Out Of Stock' : 'In Stock')}</dd>
                                <dt class="col-sm-4" id="quantitie" >Quantity:</dt>
                                <dd class="col-sm-8">${priceandsize[0].productAvaiable}</dd>
                                <dt class="col-sm-4">Price:</dt>
                                <dd class="col-sm-8" id="price"><input type="text" value="${priceandsize[0].productPrice}" id="priceofproduct" hidden="">${priceandsize[0].productPrice} $</dd>
                            </dl>
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="perfume-type" class="form-label">Size</label>
                                    <select class="form-select mb-3" id="perfume-type">
                                        <c:forEach items="${priceandsize}" var="size">
                                            <option value="${size.getProductSize()}">${size.getProductSize()}</option>
                                        </c:forEach>
                                    </select>

                                    <label for="quantity" class="form-label">Quantity</label>
                                    <div class="quantity-wrapper">
                                        <button class="quantity-btn" type="button" onclick="changeQuantity(-1)">-</button>
                                        <input type="number" class="quantity-input" id="quantity" value="1" min="1" max="${priceandsize[0].productAvaiable}">
                                        <button class="quantity-btn" type="button" onclick="changeQuantity(1)">+</button>
                                    </div>
                                </div>
                            </div>

                            <c:if test="${sessionScope.account != null}">
                                <div class="button-group">
                                    <button type="button" class="btn btn-add-to-cart" id="addToCartBtn" onclick="addToCart(${priceandsize[0].productFullDetailID})"><i class="fa-solid fa-cart-plus" style="color: #fff; padding-right: 5px"></i><span style="color: #fff;font-weight: bold">Add to Cart</span></button>
                                    <button type="button" class="btn btn-add-to-wishlist"><i class="fa-regular fa-heart" style="color: #fff"></i></button>
                                </div>
                            </c:if>

                            <c:if test="${sessionScope.account == null}">
                                <div class="button-group">
                                    <button type="button" class="btn btn-add-to-cart" id="addToCartBtn" onclick="addToCartCookie(${priceandsize[0].productFullDetailID})"><i class="fa-solid fa-cart-plus" style="color: #fff; padding-right: 5px"></i><span style="color: #fff;font-weight: bold">Add to Cart</span></button>
                                    <button type="button" class="btn btn-add-to-wishlist"><i class="fa-regular fa-heart" style="color: #fff"></i></button>
                                </div>
                            </c:if>

                        </div>
                    </main>
                </div>
            </div>
        </section>

        <section class="bg-light border-top py-4">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 mb-4">
                        <div class="border rounded-2 p-3 bg-white">
                            <div class="container mt-3">
                                <div class="product-block">
                                    <div class="row">
                                        <div class="col-md-2 product-title" style="font-size: larger; margin-top: 10px; cursor: pointer;" id="desc-text">
                                            Describe
                                        </div>
                                        <div class="col-md-2 product-title" style="font-size: larger; margin-top: 10px; cursor: pointer;" id="policy-text">
                                            Policy
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="container mt-2 mb-5">
                                <div id="description" class="content-section active">
                                    <p >
                                        ${pd.getProductDescription()}
                                    </p>
                                    <img src="${p.getProductImageUrl()}">
                                    <p >
                                        ${b.getDescription()}
                                    </p>

                                    <p >
                                        Perfume has been present in human culture and history for thousands of years. In ancient cultures, essential oils and aromas were used to make perfumes and were used in religious ceremonies and prayer rites. Kings, emperors and aristocrats often used perfume to show nobility and wealth.

                                        During the Middle Ages, perfume was used as a means to protect health and fight epidemics. Fragrances are said to have antiseptic and antiseptic properties, and are used to mask odors during pandemics.

                                        By the 17th century, perfume became an indispensable part of French life. Perfume is widely used in society and has become a symbol of wealth and nobility. The city of Grasse in southern France is considered the capital of the perfume industry with many famous perfume factories.

                                        During the 19th century, the perfume industry became more developed. Perfume makers have used new methods to extract essential oils from different flowers and plants, thereby creating many new perfumes with unique scents.

                                        Currently, perfume has become a popular product and is widely used around the world. Perfume manufacturers have used modern technology to create new perfumes with complex scents and longer lasting scents. Perfume is also widely used in other fields such as health, spa and beauty.
                                    </p>
                                </div>
                                <div id="policy" class="content-section" style="display: none;">
                                    <p >The information security policy is complied with relevant legal regulations on personal information protection and Decree 52/2013/ND-CP of the government on e-commerce issued on May 16, 2013.</p>

                                    Customers who register personal profile information at the website of Perfume World company agree to the terms and conditions of membership of Perfume World company. As follows:

                                    <p> 1. Purpose: clearly stipulates the website user agreement when registering to purchase or become a member of this website. A member who registers an account in TPS is a person who has registered an account according to the steps prescribed by the World of Perfume company and has been accepted by the company for that registration.

                                        When you register as a member on the website, the information we collect includes:

                                        First and last name
                                        Phone number
                                        Email address
                                        Delivery address</p>
                                    <p>2. Scope of information use: the information we collect as above is only used to provide sales information, delivery, order processing, online payment transactions, promotional programs, company's services to customers. We may share information about your name, address, and phone number with our courier service or partners to deliver your goods.</p>

                                    <p >3. The collection and use of each customer's information is only carried out with that customer's consent, unless otherwise prescribed by law.</p>

                                    <p >4. After registering, members are responsible for self-managing their accounts, passwords and personal information.</p>

                                    <p >5. In case our company confirms that a member violates the following, we may stop or cancel that member's eligibility to use the account, and we are not responsible for such violations. damage arising from the above suspension or cancellation. In case a member damages the interests of our company, or a third person, by violating the provisions stated below, the violating member must be responsible for compensating for those damages.

                                        Registering untrue information when registering as a member.
                                        There are acts that violate these laws and regulations.
                                        Use your account and password for nefarious purposes, or let a third person use it.
                                        Cause harm to our company
                                        Behavior that our company considers inappropriate.</p>
                                    <p >6. Complaint mechanism for Customers: Customers have the right to submit complaints to TGNH sales and promotion website. Upon receiving this feedback, TGNH sales and promotion website will confirm the information. In case the buyer's feedback is correct, depending on the level, TGNH sales and promotion website will take corrective measures. promptly to protect the interests of customers.</p>

                                    <p >7. The company can change the agreement/policy. When there is a change, we will post it on www.thegioinuochoa.com.vn, and after posting, the agreement will be considered effective. In case of changes or updates to information/policies, if the member uses the service, we consider the member to have accepted all such agreements.</p>

                                    <p >8. Customer information is stored on the company's private server and the Company is authorized/authorized to manage and secure customer information.</p>

                                    <p >9. All customer information is collected and stored at Perfume World company.</p>

                                    <p >10. Purchase information and personal/organizational information on the TGNH sales and promotion website are confidential and are not disclosed to third parties. Perfume World Company is committed to protecting customer information according to in accordance with current laws.</p>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="px-0 border rounded-2 shadow-0">
                            <div class="card">
                                <div class="card-body">
                                    <div class="small_product_area mb-68">
                                        <div class=" text-center">
                                            <h2><span class="ani-fire">Similar Products</span></h2>
                                        </div>
                                        <div class="small_product_container sidebar_product_column1 owl-carousel" style="padding-top: 40px">
                                            <c:set var="breakLoop" value="false" />
                                            <c:forEach var= "j" begin="1" end="2" step="1" >
                                                <c:set var="count" value="0" />
                                                <div class="small_product_list">
                                                    <c:if test="${breakLoop == true}">
                                                        <c:set var="count" value="4"/>
                                                    </c:if>
                                                    <c:forEach items="${psimilar}" var="p1" varStatus="status" >
                                                        <c:if test="${(not breakLoop && count < 5) || (breakLoop && 5 < count && count < 10)}">
                                                            <c:if test="${count == status.index}">
                                                                <article class="single_product" data-toggle="modal" data-target="#modal_box">
                                                                    <figure>
                                                                        <div class="product_thumb">
                                                                            <a href="#" class="primary_img">
                                                                                <img src="${p1.productImageUrl}" alt="">
                                                                            </a>
                                                                        </div>
                                                                        <figcaption class="product_content">
                                                                            <h4 class="product_name" style="font-size: 15px">
                                                                                <a href="#">${p1.productName}</a>
                                                                            </h4>
                                                                            <div class="price_box">
                                                                                <span class="current_price"> $${p1.priceMin} - $${p1.priceMax}</span>
                                                                            </div>
                                                                            <div class="product_rating" style="font-size: 18px; padding-bottom: 12px ; padding-right: 10px">

                                                                                <c:forEach begin="1" end="${productAverageStars[p1.productID]}" var="i">
                                                                                    <small style="color: #ffca08;" class="fas fa-star"></small>
                                                                                </c:forEach>
                                                                                <!-- Check for half-star -->
                                                                                <c:if test="${productAverageStars[p1.productID] != productAverageStars[p1.productID]}">
                                                                                    <small style="color: #ffca08;" class="fas fa-star-half-alt"></small>
                                                                                </c:if>
                                                                                <!-- Calculate empty stars -->
                                                                                <c:forEach begin="1" end="${5 - productAverageStars[p1.productID]}" var="i">
                                                                                    <small style="color: #ddd;" class="far fa-star"></small>
                                                                                </c:forEach>

                                                                            </div>
                                                                        </figcaption>
                                                                    </figure>
                                                                </article>
                                                                <c:set var="count" value="${count + 1}" />
                                                            </c:if>
                                                            <c:if test="${count == 5}">
                                                                <c:set var="breakLoop" value="true" />
                                                            </c:if>
                                                        </c:if>

                                                    </c:forEach>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section id="testimonials" class="container my-5">
    <!--heading-->
    <div class="testimonial-heading text-center">
        <h2 class="ani-fire">Feedback</h2>
    </div>
    <c:forEach items="${fb}" var="fb" varStatus="loop"  >  
        <div class="media" style="align-items: flex-start;
             border-bottom: 1px solid rgba(0, 0, 0, .09);
             padding: 1rem 0 1rem 1.25rem;">
            <div class="media-body">                     
                <c:if test="${fb.getFbAccountID() != null}">
                    <div class="d-flex">
                        <h5>${listAccount[loop.index].getFirstName()} ${listAccount[loop.index].getLastName()}</h5>
                        <i class="fa-solid fa-heart" style="color: rgb(255, 68, 59)"></i>
                    </div>
                </c:if>

                <div class="star-rating">
                    <c:forEach var="i" begin="1" end="${fb.getFbStar()}">
                        <label style="color: #ffca08;" class="fas fa-star"></label>
                    </c:forEach>
                    <c:forEach var="i" begin="${fb.getFbStar()+1}" end="5">
                        <label style="color: #ddd;" class="far fa-star empty"></label>
                    </c:forEach>
                </div>
                <div style="font-size: 15px;">${fb.getFbDate()}</div>
                <div style="font-size: 27px;
                     line-height: 20px;
                     color: rgba(0, 0, 0, 0.87);
                     margin-top: 0.75rem;
                     white-space: pre-wrap;">${fb.getFbContent()}</div>
                <div style="margin-top: 0.95rem;">
                    <c:if test="${fb.getFbImage() != null}" >
                        <img src="images/Feedback/${fb.getFbImage()}" style="width: 100px; height: 100px" />
                    </c:if>
                </div>

            </div>
        </div>
        </br>
    </c:forEach>
</section>
<footer class="footer">        
    <jsp:include page="footer.jsp"/>
</footer>
<script>
    function showImage(imagePath) {
        document.getElementById("product-image").src = imagePath;
    }
    function changeQuantity(change) {
        const quantityInput = document.getElementById('quantity');
        let currentQuantity = parseInt(quantityInput.value);
        const maxQuantity = parseInt(quantityInput.max);
        // Ensure the current quantity is a number and apply the change
        if (!isNaN(currentQuantity)) {
            currentQuantity += change;
            // Ensure the quantity is within the allowed range
            if (currentQuantity < quantityInput.min) {
                currentQuantity = parseInt(quantityInput.min);
            } else if (currentQuantity > maxQuantity) {
                currentQuantity = maxQuantity;
            }

            quantityInput.value = currentQuantity;
        }
    }


    document.addEventListener("DOMContentLoaded", function () {
        var descText = document.getElementById('desc-text');
        var policyText = document.getElementById('policy-text');
        var descContent = document.getElementById('description');
        var policyContent = document.getElementById('policy');
        descText.addEventListener('click', function () {
            policyContent.style.display = 'none';
            descContent.style.display = 'block';
        });
        policyText.addEventListener('click', function () {
            descContent.style.display = 'none';
            policyContent.style.display = 'block';
        });
    });
    var priceAndSizeData = [
    <c:forEach items="${priceandsize}" var="size" varStatus="status">
    {
    productfulldetailid: "${size.productFullDetailID}",
            status: "${size.productStatus}",
            size: "${size.productSize}",
            price: "${size.productPrice}",
            quantity: "${size.productAvaiable}"
    }<c:if test="${!status.last}">,</c:if>
    </c:forEach>
    ];
    document.getElementById("perfume-type").addEventListener("change", function () {
        // Lấy giá trị size được chọn
        var selectedSize = this.value;
        // Lặp qua danh sách các size để tìm size tương ứng và cập nhật giá
        for (var i = 0; i < priceAndSizeData.length; i++) {
            if (priceAndSizeData[i].size === selectedSize) {
                // Hiển thị giá của size được chọn
                document.getElementById("price").innerText = priceAndSizeData[i].price + " $";
                document.getElementById("quantitie").innerText = priceAndSizeData[i].quantity;
                document.getElementById("productductFullDetailID").setAttribute("value", priceAndSizeData[i].productfulldetailid);
                console.log(document.getElementById("productductFullDetailID"));
                var statusText = (priceAndSizeData[i].quantity === 0 || priceAndSizeData[i].status === 0) ? 'Out Of Stock' : 'In Stock';
                document.getElementById("status").innerText = statusText;
                // Cập nhật trạng thái của nút "Add to Cart"
                var addToCartBtn = document.getElementById("addToCartBtn");
                if (priceAndSizeData[i].quantity === 0) {
                    addToCartBtn.setAttribute("disabled", "true");
                    addToCartBtn.removeAttribute("onclick");
                } else {
                    addToCartBtn.removeAttribute("disabled");
    <c:if test="${sessionScope.account != null}">
                    addToCartBtn.setAttribute("onclick", "addToCart(" + priceAndSizeData[i].productfulldetailid + ")");
    </c:if>

    <c:if test="${sessionScope.account == null}">
                    addToCartBtn.setAttribute("onclick", "addToCartCookie(" + priceAndSizeData[i].productfulldetailid + ")");
    </c:if>
                }


                break; // Kết thúc vòng lặp khi tìm được size tương ứng
            }
        }
    });
    function addToCart(productductFullDetailID) {
        var productname = document.getElementById('productname');
        var quantity = document.getElementById('quantity');
        if (productname !== null && productname.value !== '' && quantity !== null && quantity.value !== '') {
            window.location.href = "/SWP391-G2/cartcontroller?quantity=" + quantity.value + "&&productname=" + productname.value + "&&productfulldetailid=" + productductFullDetailID;
        }
    }



    function addToCartCookie(productductFullDetailID) {
        var productname = document.getElementById('productname');
        var quantity = document.getElementById('quantity');
        if (productname !== null && productname.value !== '' && quantity !== null && quantity.value !== '') {
            window.location.href = "/SWP391-G2/cartcookie?quantity=" + quantity.value + "&&productname=" + productname.value + "&&productfulldetailid=" + productductFullDetailID;
        }
    }


</script>
<script src="js/main.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.5.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
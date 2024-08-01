<%-- 
    Document   : blog
    Created on : Jun 10, 2024, 9:08:32 AM
    Author     : TNO
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="megakit,business,company,agency,multipurpose,modern,bootstrap4">

        <meta name="author" content="themefisher.com">

        <title>Megakit| Html5 Agency template</title>

        <!-- bootstrap.min css -->
        <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
        <!-- Icon Font Css -->
        <link rel="stylesheet" href="plugins/themify/css/themify-icons.css">
        <link rel="stylesheet" href="plugins/fontawesome/css/all.css">
        <link rel="stylesheet" href="plugins/magnific-popup/dist/magnific-popup.css">
        <!-- Owl Carousel CSS -->
        <link rel="stylesheet" href="plugins/slick-carousel/slick/slick.css">
        <link rel="stylesheet" href="plugins/slick-carousel/slick/slick-theme.css">

        <!-- Main Stylesheet -->
        <link rel="stylesheet" href="css/styleBlog.css">
    </head>

    <body>

        <!-- Header Start -->

        <!-- Header Close -->

        <div class="main-wrapper ">

            <section class="section blog-wrap bg-gray">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="row">
                                <c:forEach items="${blogList}" var="blogList" >
                                    <div class="col-lg-6 col-md-6 mb-5">
                                        <div class="blog-item">
                                            <img src="${blogList.thumbnail}" alt="" class="img-fluid rounded">

                                            <div class="blog-item-content bg-white p-4">
                                                <div class="blog-item-meta  py-1 px-2">
                                                    <span class="text-muted text-capitalize mr-3"><i
                                                            class="ti-pencil-alt mr-2"></i>${blogList.firstName} ${blogList.lastName}</span>
                                                </div>

                                                <h3 class="mt-3 mb-3"><a href="blogDetails?id=${blogList.id}">${blogList.title}</a></h3>
                                                <p class="mb-4">${blogList.brief}</p>

                                                <a href="blogDetails?id=${blogList.id}" class="btn btn-small btn-main btn-round-full">Learn
                                                    More</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>                               
                                <div class="col-lg-6 col-md-6 mb-5">

                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="sidebar-wrap">
                                <div class="sidebar-widget search card p-4 mb-3 border-0">
                                    <input type="text" class="form-control" placeholder="search">
                                    <a href="#" class="btn btn-mian btn-small d-block mt-2">search</a>
                                </div>

                                <div class="sidebar-widget card border-0 mb-3">
                                    <img src="images/blog/blog-author.jpg" alt="" class="img-fluid">
                                    <div class="card-body p-4 text-center">
                                        <h5 class="mb-0 mt-4">Arther Conal</h5>
                                        <p>Digital Marketer</p>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Incidunt, dolore.</p>

                                        <ul class="list-inline author-socials">
                                            <li class="list-inline-item mr-3">
                                                <a href="#"><i class="fab fa-facebook-f text-muted"></i></a>
                                            </li>
                                            <li class="list-inline-item mr-3">
                                                <a href="#"><i class="fab fa-twitter text-muted"></i></a>
                                            </li>
                                            <li class="list-inline-item mr-3">
                                                <a href="#"><i class="fab fa-linkedin-in text-muted"></i></a>
                                            </li>
                                            <li class="list-inline-item mr-3">
                                                <a href="#"><i class="fab fa-pinterest text-muted"></i></a>
                                            </li>
                                            <li class="list-inline-item mr-3">
                                                <a href="#"><i class="fab fa-behance text-muted"></i></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="sidebar-widget latest-post card border-0 p-4 mb-3">
                                    <h5>Latest Posts</h5>

                                    <div class="media border-bottom py-3">
                                        <a href="#"><img class="mr-4" src="images/blog/bt-3.jpg" alt=""></a>
                                        <div class="media-body">
                                            <h6 class="my-2"><a href="#">Thoughtful living in los Angeles</a></h6>
                                            <span class="text-sm text-muted">03 Mar 2018</span>
                                        </div>
                                    </div>

                                    <div class="media border-bottom py-3">
                                        <a href="#"><img class="mr-4" src="images/blog/bt-2.jpg" alt=""></a>
                                        <div class="media-body">
                                            <h6 class="my-2"><a href="#">Vivamus molestie gravida turpis.</a></h6>
                                            <span class="text-sm text-muted">03 Mar 2018</span>
                                        </div>
                                    </div>

                                    <div class="media py-3">
                                        <a href="#"><img class="mr-4" src="images/blog/bt-1.jpg" alt=""></a>
                                        <div class="media-body">
                                            <h6 class="my-2"><a href="#">Fusce lobortis lorem at ipsum semper sagittis</a>
                                            </h6>
                                            <span class="text-sm text-muted">03 Mar 2018</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="sidebar-widget bg-white rounded tags p-4 mb-3">
                                    <h5 class="mb-4">Tags</h5>

                                    <a href="#">Web</a>
                                    <a href="#">agency</a>
                                    <a href="#">company</a>
                                    <a href="#">creative</a>
                                    <a href="#">html</a>
                                    <a href="#">Marketing</a>
                                    <a href="#">Social Media</a>
                                    <a href="#">Branding</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-5">
                        <%@include file="../partials/pagination.jsp"%>
                    </div>
                </div>
            </section>

            <!-- footer Start -->


        </div>

        <!-- 
    Essential Scripts
    =====================================-->


        <!-- Main jQuery -->
        <script src="plugins/jquery/jquery.js"></script>
        <script src="js/contact.js"></script>
        <!-- Bootstrap 4.3.1 -->
        <script src="plugins/bootstrap/js/popper.js"></script>
        <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
        <!--  Magnific Popup-->
        <script src="plugins/magnific-popup/dist/jquery.magnific-popup.min.js"></script>
        <!-- Slick Slider -->
        <script src="plugins/slick-carousel/slick/slick.min.js"></script>
        <!-- Counterup -->
        <script src="plugins/counterup/jquery.waypoints.min.js"></script>
        <script src="plugins/counterup/jquery.counterup.min.js"></script>

        <!-- Google Map -->
        <script src="plugins/google-map/map.js"></script>
        <script
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkeLMlsiwzp6b3Gnaxd86lvakimwGA6UA&callback=initMap"></script>

        <script src="js/script.js"></script>

    </body>

</html>

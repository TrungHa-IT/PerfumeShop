<%-- 
    Document   : marketing-manage-sliders
    Created on : 25 thg 6, 2024, 09:13:40
    Author     : pna29
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Marketing Dashboard</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/homestyle.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!------ Include the above in your HEAD tag ------>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.carousel.min.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/bootstrap.min.css">
        <!-- Material Design Bootstrap -->
        <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/mdb-pro.min.css">
        <!-- Material Design Bootstrap Ecommerce -->
        <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/mdb.ecommerce.min.css">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!------ Include the above in your HEAD tag ------>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/> 
        <style>
            td img {
                width: 200px;
                height: 120px;
            }
            body {
                margin: 0;
                padding: 0;
            }

            .alert.alert-success {
                margin: 20px 10px;
            }
        </style>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"><link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&amp;display=swap"><link rel="stylesheet" type="text/css" href="https://mdbootstrap.com/wp-content/themes/mdbootstrap4/css/mdb5/3.8.1/compiled.min.css"><link rel="stylesheet" type="text/css" href="https://mdbootstrap.com/wp-content/themes/mdbootstrap4/css/mdb-plugins-gathered.min.css"><style>body {
                background-color: #fbfbfb;
            }
            @media (min-width: 991.98px) {
                main {
                    padding-left: 240px;
                }
            }

            /* Sidebar */
            .sidebar {
                position: fixed;
                top: 0;
                bottom: 0;
                left: 0;
                padding: 58px 0 0; /* Height of navbar */
                box-shadow: 0 2px 5px 0 rgb(0 0 0 / 5%), 0 2px 10px 0 rgb(0 0 0 / 5%);
                width: 240px;
                z-index: 600;
            }

            @media (max-width: 991.98px) {
                .sidebar {
                    width: 100%;
                }
            }
            .sidebar .active {
                border-radius: 5px;
                box-shadow: 0 2px 5px 0 rgb(0 0 0 / 16%), 0 2px 10px 0 rgb(0 0 0 / 12%);
            }
            .text_page_head{
                font-size: 18px;
                font-weight: 600;
            }
            .text_page {
                font-size: 14px;
                font-weight: 600;
            }
            .buttonadd{
                position: absolute;
                right: 100px;
                top: 30px;
            }
            .sidebar-sticky {
                position: relative;
                top: 0;
                height: calc(100vh - 48px);
                padding-top: 0.5rem;
                overflow-x: hidden;
                overflow-y: auto; /* Scrollable contents if viewport is shorter than content. */
            }
            select {
                width: 32.3%;
                margin: 0;
                font-size: 100%;
                padding: 5px 10px 5px 10px;
                font-family: Segoe UI, Helvetica, sans-serif;
                border: 1px solid #D0D0D0;
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
                border-radius: 20px;
                outline: none;
            }
        </style>
    </head>
    <body>
        <header>
            <nav id="sidebarMenu" class="collapse d-lg-block sidebar collapse bg-black" style="padding: 0px; width: 270px; background-color: black">
                <div class="position-sticky" >
                    <div class="list-group list-group-flush mx-3 mt-4" style="margin: 0">
                        <div class="footer_logo" style="text-align: center; margin-bottom: 0">
                            <a href="home"><img src="images/logo/logo0.png" alt="Logo" style="height: 53px"></a>
                        </div>
                        <a href="manageSlider" class="list-group-item list-group-item-action" aria-current="true" style="margin-top: 10px;">
                            <i style="margin-right: 10px; font-size: 18px" class="fa-solid fa-sliders"></i>
                            <span style="font-size: 16px; font-weight: 600">Manage Slider</span>
                        </a> 
                        <a href="statisticRevenue" class="list-group-item list-group-item-action" aria-current="true" style="margin-top: 10px;">
                            <i style="margin-right: 10px; font-size: 18px" class="fa-solid fa-sliders"></i>
                            <span style="font-size: 16px; font-weight: 600">Statistic Revenue</span>
                        </a> 
                        <a href="login" class="list-group-item list-group-item-action" style="margin-top: 10px">
                            <i style="margin-right: 10px; font-size: 18px" <i class="fa-solid fa-right-from-bracket"></i>
                            <span style="font-size: 16px; font-weight: 600">Log Out</span>
                        </a>
                    </div>
                </div>
            </nav>
        </header>

        <main>
            <div class="container pt-4">
                <!--Section: Quan Ly tai Khoan-->
                <section class="mb-4">
                    <div class="card">
                        <div class="row">
                            <div class="col-sm-4" style="text-align: center; margin-top: 20px; padding-top: 20px">
                                <h3 class="mb-0" id="">
                                    <strong class="ani-fire" style="font-size: 30px">Manage Sliders</strong>
                                </h3>
                            </div>
                            <div class="col-lg-4" style="text-align: center; margin-top: 20px; margin-bottom: 20px;padding-top: 20px">
                                <form action="" style="display: flex; justify-content: center">
                                    <input value="${requestScope.searchValue != null ? requestScope.searchValue : ""}" id="searchTitle" type="text" oninput="searchByTitle()" placeholder="Search..." style="width: 60%; padding: 4px 10px; border-radius: 15px">
                                    <button style="border-radius: 50%; width: 40px; font-size: 18px; margin-left: 10px"><i class="fa fa-search"></i></button>
                                </form>
                            </div>
                            <div class="col-lg-2" style="text-align: center; margin-top: 20px; margin-bottom: 20px;padding-top: 20px">
                                <form action="manageSlider" method="post" >
                                    <select name="status" style="width: 150px;border-radius: 15px; border: 2px solid #000;" onchange="this.form.submit()">
                                        <option value="-1" ${status==null ? 'selected' : '' }>All Status</option>
                                        <option value="1" ${status==1 ? 'selected' : '' }>Unblock</option>
                                        <option value="0" ${status==0 ? 'selected' : '' }>Block</option>
                                    </select>
                                </form>
                            </div>

                            <div class="col-lg-2">
                                <a href="#addEmployeeModal" style="height: 40px" class="buttonadd btn btn-success" data-toggle="modal"><i class="fa-solid fa-plus"></i></a>

                            </div>

                        </div>

                        <% String message = (String) request.getAttribute("message"); %>
                        <% if (message != null && !message.isEmpty()) { %>
                        <div class="alert alert-info justify-content-center">
                            <%= message %>
                        </div>
                        <% } %>

                        <div class="card-body">
                            <div class="table-responsive" id="contentt">
                                    <table  class="table table-hover text-nowrap">
                                        <thead>
                                            <tr>
                                                <th class="text_page_head" scope="col">No</th>
                                                <th class="text_page_head" style="text-align: center" scope="col">Image</th>
                                                <th class="text_page_head" scope="col">Slider Title</th>
                                                <th class="text_page_head" scope="col">Update At</th>
                                                <th class="text_page_head" scope="col">Account ID</th>
                                                <th class="text_page_head" scope="col">Status</th>
                                                <th class="text_page_head" scope="col">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody >

                                            <c:set var="stt" value="0"/>
                                            <c:forEach items="${listByPage}" var="slider">
                                                <c:set var="stt" value="${stt+1}"/>
                                                <tr class="product_items">
                                                    <td class="text_page">${stt}</td>
                                                    <td style="text-align: center">
                                                        <img style="width: 170px; height:180px" src="${slider.sliderImage}" alt="img"">
                                                    </td>
                                                    <td style="max-width: 280px;
                                                        padding: 10px;
                                                        white-space: nowrap;
                                                        overflow: hidden;
                                                        text-overflow: ellipsis;
                                                        word-wrap: break-word;" class="text_page">${slider.sliderTitle}</td>                                               
                                                    <td class="text_page">${slider.updateAt}</td>
                                                    <td class="text_page">${slider.accountId}</td>
                                                    <td class="text_page">
                                                        <c:choose>
                                                            <c:when test="${slider.sliderStatus == 1}">
                                                                <a href="updateStatusSlider?status=0&sliderId=${slider.sliderID}" onclick="return confirmAction('block');">
                                                                    <button type="button" class="btn btn-danger">
                                                                        Block
                                                                    </button>
                                                                </a>
                                                            </c:when>
                                                            <c:when test="${slider.sliderStatus == 0}">
                                                                <a href="updateStatusSlider?status=1&sliderId=${slider.sliderID}" onclick="return confirmAction('unblock');">
                                                                    <button type="button" class="btn btn-success">
                                                                        Unblock
                                                                    </button>
                                                                </a>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>

                                                    <td class="text_page">
                                                        <a href="./sliderDetails?sliderId=${slider.sliderID}"><button type="button" class="btn btn-warning"><i class="fa-solid fa-pen"></i></button></a>                                                  
                                                    </td>
                                                </tr>
                                            </c:forEach>

                                        </tbody>
                                    </table>

                                <div class="clearfix" style="text-align: center">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${page != 1}">
                                            <a class="page-item" href="manageSlider?page=${page-1}">Previous</a>
                                        </c:if> 	
                                        <c:forEach begin="1" end="${numberpage}" var="i">
                                            <a class="${page==i?"page-item activee":""}" style="${page==i?"background-color:black; color: white; font-size: 22px; float: left; padding: 8px 16px; text-decoration: none;":""}" 
                                               href="manageSlider?page=${i}" class="page-link">${i}</a>  
                                        </c:forEach>
                                        <c:if test="${page < numberpage}">
                                            <a class="page-item" href="manageSlider?page=${page+1 }" class="page-link">Next</a>
                                        </c:if> 
                                    </ul>
                                </div>

                            </div>

                        </div>
                    </div>
                </section>
                <!--Section: Quan Ly tai Khoan-->
            </div>


        </main>
        <div class="modal fade" id="modal_box" role="dialog"></div>
        <!-- Edit Modal HTML -->
        <div id="addEmployeeModal" class="modal fade">
            <div class="modal-dialog " style="margin: 28px 500px">
                <div class="modal-content " style="width: 1000px; max-height: 900px">
                    <form action="addSlider" method="post" enctype="multipart/form-data">
                        <div class="modal-header">						
                            <h4 class="modal-title">Add New Slider</h4>
                        </div>
                        <div class="modal-body">					
                            <div class="form-group">
                                <label>Slider Title</label>
                                <input name="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="status">Status:</label>
                                <select class="form-control" id="status" name="status">
                                    <option value="1" ${slider.sliderStatus==1 ? 'selected' : '' }>View</option>
                                    <option value="0" ${slider.sliderStatus==0 ? 'selected' : '' }>Hide</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="image">Image:</label>
                                <div class="image-preview-container">
                                    <img id="previewImage" class="image-preview" src="${slider.sliderImage}" alt="Preview Image"/>
                                    <div class="file-input">
                                        <input type="file" name="image" id="image" onchange="updatePreview(event)">
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">  
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>

            function updateStatus(slider) {

                window.location.href = './updateStatusSlider?status=' + slider.value + '&sliderId=' + slider.dataset.id;

            }

            function updatePreview(event) {
                var input = event.target;
                var reader = new FileReader();

                reader.onload = function () {
                    var imgElement = document.getElementById('previewImage');
                    imgElement.src = reader.result;
                }

                reader.readAsDataURL(input.files[0]);
            }
            function confirmAction(action) {
                let message = action === 'block' ? 'Are you sure you want to block this slider?' : 'Are you sure you want to unblock this slider?';
                return confirm(message);
            }
            function addOption(selectElement, value, text) {
                var option = document.createElement("option");
                option.value = value;
                option.text = text;
                selectElement.add(option);
            }

            var defaultReleaseDate = document.getElementById("stringdateolb").value;
            var defaultDateArray = defaultReleaseDate.split('-');
            var defaultDay = parseInt(defaultDateArray[2]);
            var defaultMonth = parseInt(defaultDateArray[1]);
            var defaultYear = parseInt(defaultDateArray[0]);

            var daysSelect = document.getElementById('dobDay');
            var monthsSelect = document.getElementById('dobMonth');
            var yearsSelect = document.getElementById('dobYear');

            for (var day = 1; day <= 31; day++) {
                addOption(daysSelect, day, day);
            }

            for (var month = 1; month <= 12; month++) {
                addOption(monthsSelect, month, month);
            }

            var currentYear = new Date().getFullYear();
            for (var year = currentYear; year >= 1900; year--) {
                addOption(yearsSelect, year, year);
            }

            daysSelect.value = defaultDay;
            monthsSelect.value = defaultMonth;
            yearsSelect.value = defaultYear;
            function submitForm() {
                var here = document.querySelector('#here');
                var form = document.getElementById('form');
                var dobDay = document.getElementById('dobDay').value;
                var dobMonthText = document.getElementById('dobMonth').value;
                var dobMonth = monthNameToNumber(dobMonthText);
                var dobYear = document.getElementById('dobYear').value;
                if (dobMonth < 10 && dobDay < 10) {
                    dobFull = dobYear + '-0' + dobMonth + '-0' + dobDay;
                } else if (dobMonth < 10 && !(dobDay < 10)) {
                    dobFull = dobYear + '-0' + dobMonth + '-' + dobDay;
                } else if (dobDay < 10 && !(dobMonth < 10)) {
                    dobFull = dobYear + '-' + dobMonth + '-0' + dobDay;
                } else {
                    dobFull = dobYear + '-' + dobMonth + '-' + dobDay;
                }

                here.value = dobFull;
                form.submit();
            }
            function searchByTitle() {
                var text = document.querySelector("#searchTitle").value;
                $.ajax({
                    url: "/SWP391-G2/searchSlider",
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
        <script src="js/admin_manager.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
                integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
                integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
                integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>   
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/owl.carousel.min.js"></script>
        <script src="js/countdown.js"></script>
        <script src="js/clickevents.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
        <script src="js/main.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://mdbootstrap.com/previews/ecommerce-demo/js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/popper.min.js"></script>
        <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/bootstrap.js"></script>
        <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.min.js"></script>
        <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.ecommerce.min.js"></script>
        <script type="text/javascript" src="https://mdbootstrap.com/wp-content/themes/mdbootstrap4/js/plugins/mdb-plugins-gathered.min.js"></script>

        <script src="js/calender.js"></script>

    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product | The Perfume Shop</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <!-- Include Bootstrap CSS via CDN link -->
        <!-- ======= Styles ====== -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin_manager.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <style>
            .image-preview-container {
                display: flex;
                align-items: center;
            }
            .error {
                color: red;
            }
            .image-preview {
                width: 60%; /* Đặt kích thước hiển thị ảnh */
                height: auto; /* Đảm bảo tỷ lệ khung hình bảo toàn */
                border: 1px solid #ccc; /* Đường viền để phân biệt vùng ảnh */
            }
            .scroll{
                width: 100%;
                height: 550px;
                overflow-y: scroll;
            }

            .btnaa {
                display: inline-block;
                padding: 10px 20px;
                font-size: 16px;
                color: #ccc;
                background-color: #007bff; /* Màu nền */
                text-align: center;
                text-decoration: none;
                border-radius: 5px; /* Đường viền bo tròn */
                border: 1px solid transparent; /* Đường viền */
                transition: background-color 0.3s, border-color 0.3s; /* Hiệu ứng chuyển tiếp */
            }

        </style>

    </head>

    <body>
        <div class="container-fluid">
            <!-- Navigation -->
            <jsp:include page="../partials/navigation.jsp"></jsp:include>
            <input type="hidden" id="success" value="${requestScope.success}" >
            <input type="hidden" id="error" value="${requestScope.error}" >
            <div class="main">
                <div class="topbar mb-2">
                    <li style="list-style-type: none" class="breadcrumb-item"><a class="link-offset-2 fs-6 link-dark" href="./saleorder"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8"/>
                            </svg>Previous page</a></li>
                </div>
                <div class="container-fluid pt-5">
                    <div class="row px-xl-5">
                        <div class="col-lg-7">
                            <div class="card border-secondary mb-5">
                                <div class="card-header bg-secondary border-0">
                                    <h4 class="font-weight-semi-bold m-0">Order Total (${orderDetail.size()} products)</h4>
                                </div>
                                <h5 class="font-weight-medium mb-3">Products</h5>
                                <div class="card-body ">
                                    <div class="row scroll ">
                                        <table class="table border-0">
                                            <c:forEach items="${requestScope.orderDetail}" var="_order" varStatus="loop">
                                                <tr style="height: 30px">
                                                    <td><img src="${_order.getImage()}" alt="" style="width: 60px; height: 60px"></td>
                                                    <td>${_order.getName()}</td>
                                                    <td>${_order.getSize()}</td>
                                                    <td>${_order.getQuantity()}</td>
                                                    <td>${_order.getPrice()}$</td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </div>
                                </div>
                                <div class="card-footer border-secondary bg-transparent">
                                    <div class="d-flex justify-content-between mt-2 mb-4">
                                        <h5 class="font-weight-bold">Total</h5>
                                        <h5 class="font-weight-bold">${info.orderTotalPrice}$</h5>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-5">
                            <div class="mb-4">
                                <div class="row mb-5">
                                    <div class=" col-md-6 border-secondary bg-transparent">
                                        <div class="dropdown w-100">
                                            <c:if test="${info.getOrderSoID() < 3}" >
                                                <button id="statusButton" class="btn dropdown-toggle w-100"  value="${info.getOrderSoID()}" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <c:forEach  items="${listStatus}" var="status" >
                                                        <c:if test="${status.SOID == info.getOrderSoID()}">
                                                            ${status.SOName}
                                                        </c:if>
                                                    </c:forEach>
                                                </button>
                                            </c:if>
                                            <c:if test="${info.getOrderSoID() >= 3}" >
                                                <button id="statusButton" class="btn dropdown-toggle w-100"  value="${info.getOrderSoID()}" type="button" >
                                                    <c:forEach  items="${listStatus}" var="status" >
                                                        <c:if test="${status.SOID == info.getOrderSoID()}">
                                                            ${status.SOName}
                                                        </c:if>
                                                    </c:forEach>
                                                </button>
                                            </c:if>
                                            <ul class="dropdown-menu w-100">
                                                <c:forEach  items="${listStatus}" var="status" >
                                                    <c:if test="${status.SOID > info.getOrderSoID()}">
                                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/sale-order-detail?orderId=${info.getOrderID()}&&status=${status.SOID}">${status.SOName}</a></li>
                                                        </c:if>
                                                    </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" name="date" class="form-control" value=" Order at ${info.orderDate}" disabled="" />
                                    </div>
                                </div>


                                <h4 class="font-weight-semi-bold mb-4">Billing Address</h4>
                                <div class="row">
                                    <div class="col-md-12 form-group">
                                        <label>Full Name</label>
                                        <input class="form-control" value="${info.getOrderTotalPrice()}" type="text" disabled="" name="fullname" />
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label>Email</label>
                                        <input class="form-control" value="${info.getEmail()}" type="text" disabled="" name="email">
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label>Mobile No</label>
                                        <input class="form-control" value="${info.getOrderPhone()}" type="text" disabled="" name="phone">
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label>Address</label>
                                        <input class="form-control" value="${info.getOrderAddress()}" type="text" disabled="" name="address">
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label>Note</label>
                                        <textarea class="form-control" disabled="" rows="5" cols="10">${info.getOrderNote()}</textarea>
                                    </div>
                                </div>
                                <div class="card border-secondary mb-5">
                                    <div class="card-header bg-secondary border-0">
                                        <h4 class="font-weight-semi-bold m-0">Payment Method</h4>
                                    </div>
                                    <div class="card-body w-100">
                                        <div class="form-group">
                                            <div class="custom-control">
                                                <input value="${info.getPaymentMethod()}" class="btn btn-dark w-100" disabled="">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </body>


    <!-- =========== Scripts =========  -->
    <script src="js/admin_manager.js"></script>
    <script src="https://www.gstatic.com/firebasejs/6.0.2/firebase.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
    crossorigin="anonymous"></script>
    <!-- ====== ionicons ======= -->
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

    <script>
        // Function to set the button color based on its value
        function setButtonColor() {
            var button = document.getElementById('statusButton');
            var value = parseInt(button.value);

            switch (value) {
                case 1:
                    button.classList.add('btn-warning');
                    break;
                case 2:
                    button.classList.add('btn-info');
                    break;
                case 3:
                    button.classList.add('btn-success');
                    break;
                case 4:
                    button.classList.add('btn-danger');
                    break;
                default:
                    button.classList.add('btn-dark');
            }
        }
        window.onload = setButtonColor;
        const successElement = document.getElementById('success');
        const errorElement = document.getElementById('error');

        if (successElement && successElement.value) {
            successfully('success');
        }

        if (errorElement && errorElement.value) {
            errors(errorElement.value);
        }
        // Call the function on page load


        function successfully(text) {
            let timerInterval;
            Swal.fire({
                title: text,
                icon: "success",
                showConfirmButton: false,
                timer: 1500,
                timerProgressBar: true,
                didOpen: () => {
                    const timer = Swal.getPopup().querySelector("b");
                    timerInterval = setInterval(() => {

                    }, 100);
                },
                willClose: () => {
                    clearInterval(timerInterval);
                }
            }).then((result) => {
            });
        }

        function errors(text) {
            let timerInterval;
            Swal.fire({
                title: text,
                icon: "error",
                showConfirmButton: false,
                timer: 2000,
                timerProgressBar: true,
                didOpen: () => {
                    const timer = Swal.getPopup().querySelector("b");
                    timerInterval = setInterval(() => {

                    }, 100);
                },
                willClose: () => {
                    clearInterval(timerInterval);
                }
            }).then((result) => {
            }
            );
        }
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>

</html>
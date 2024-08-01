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
        <link rel="icon" type="image/x-icon" href="img/logo.png">
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            .image-preview-container {
                display: flex;
                align-items: center;
            }

            .image-preview {
                width: 60%; /* Đặt kích thước hiển thị ảnh */
                height: auto; /* Đảm bảo tỷ lệ khung hình bảo toàn */
                border: 1px solid #ccc; /* Đường viền để phân biệt vùng ảnh */
            }
            .error-message {
                color: red;
                display: none;
            }
        </style>

    </head>

    <body>
        <div class="container-fluid">
            <!-- Navigation -->
            <jsp:include page="../partials/navigation.jsp"></jsp:include>

                <!-- Main Content -->
                <div class="main" style="margin-left: 50px; margin-right: 50px;">
                    <div class="topbar">
                    </div>
                    <!--profile of product-->
                    <div class="row mb-5" style="margin-right: 70px;  padding: 10px; border: 1.5px solid #000;">
                        <div class="col-12" style="margin-bottom: 40px;">
                            <h1>Voucher #${voucher.getVoucherID()}</h1>
                    </div>
                    <c:if test="${voucher.getVoucherID() != null && requestScope.id == null}">
                        <form action="updatevoucher" id="productForm" method="POST" >
                            <input name="voucherId" hidden="" type="text" value="${voucher.getVoucherID()}" >       
                        </c:if>
                        <c:if test="${requestScope.id != null}">
                            <form action="updatevoucher" id="productForm" method="POST" >
                                <input name="voucherId" hidden="" type="text" value="${requestScope.id}">       
                            </c:if>
                            <c:if test="${voucher.getVoucherID() == null && requestScope.id == null}">
                                <form action="voucher" id="productForm" method="POST">                           
                                </c:if>
                                <!-- Product Name -->
                                <div class="form-group row">
                                    <div class="col-10">  
                                        <label for="detail">Code:</label>
                                        <c:if test="${voucher.getVoucherID() != null}">
                                            <input name="voucherName" id="voucher" value="${voucher.getCode()}" required="" class="col-4 form-control" aria-label="With textarea"/>
                                        </c:if>
                                        <c:if test="${voucher.getVoucherID() == null || requestScope.id != null}">
                                            <input name="voucherName" id="voucher" value="${requestScope.code}" required="" class="col-4 form-control" aria-label="With textarea"/>
                                        </c:if>
                                        <div class="error">
                                            <p style="color: red">${requestScope.codeErr}</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- Other fields (Category, Brands, Status) -->
                                <div class="form-group row d-flex col-10 justify-content-between ">
                                    <div class="col-3 d-flex  align-items-center">
                                        Discount:
                                        <c:if test="${voucher.getVoucherID() != null}">
                                            <input type="text" name="discount" id="discount" required="" value="${voucher.getDiscount()}" class="col-4 form-control">  
                                        </c:if>
                                        <c:if test="${voucher.getVoucherID() == null || requestScope.id != null}">
                                            <input type="text" name="discount" id="discount" required="" value="${requestScope.discounts}" class="col-4 form-control">    
                                        </c:if>
                                    </div> 
                                    <div class="col-3 d-flex  align-items-center">
                                        Quantity:     
                                        <c:if test="${voucher.getVoucherID() != null}">
                                            <input type="text" name="quantity" id="quantity" value="${voucher.getQuantity()}"  class="col-4 form-control">
                                        </c:if>
                                        <c:if test="${voucher.getVoucherID() == null || requestScope.id != null}">
                                            <input type="text" name="quantity" id="quantity" required="" value="${requestScope.quantity}"  class="col-4 form-control">
                                        </c:if>
                                    </div>
                                    <div class="col-3 d-flex justify-content-around align-items-center">

                                        Status: 
                                        <c:if test="${voucher.getVoucherID() != null}">
                                            <select class="form-control"  name="statusnew">
                                                <option value="1" ${requestScope.voucher.getStatus()==1 ? 'selected' : '' }>Active</option>
                                                <option value="0" ${requestScope.voucher.getStatus()==0 ? 'selected' : '' }>In-Active</option>
                                            </select>
                                        </c:if>
                                        <c:if test="${voucher.getVoucherID() == null || requestScope.id != null}">
                                            <select class="form-control"  name="statusnew">
                                                <option value="1" ${requestScope.statusnew == 1 ? 'selected' : '' }>Active</option>
                                                <option value="0" ${requestScope.statusnew ==0 ? 'selected' : '' }>In-Active</option>
                                            </select>
                                        </c:if>
                                    </div>

                                    <div class="col-3 d-flex justify-content-around align-items-center">
                                        Create Date:
                                        <c:if test="${voucher.getVoucherID() != null}">
                                            <input type="date" name="createDate" readonly="" value="${voucher.getCreateAt()}"/>
                                        </c:if>
                                        <c:if test="${voucher.getVoucherID() == null || requestScope.id != null}">
                                            <input type="date" name="createDate" readonly="" value="${requestScope.create}"/>
                                        </c:if>
                                    </div>      

                                </div>

                                <div class= "form-group row d-flex col-10 justify-content-between">                       

                                    <div class="col-3 d-flex align-items-start flex-column">

                                        <div>
                                            Start Date:
                                            <c:if test="${voucher.getVoucherID() != null}">
                                                <input type="date" name="startDate"  id="startDate" required="" value="${voucher.getStartDate()}"/>
                                            </c:if>
                                            <c:if test="${voucher.getVoucherID() == null || requestScope.id != null}">
                                                <input type="date" name="startDate" id="startDate" readonly="" value="${requestScope.startdate}"/>
                                            </c:if>
                                        </div>
                                    </div>   
                                    <div class="col-3 d-flex align-items-start flex-column">
                                        <div>
                                            End Date:
                                            <c:if test="${voucher.getVoucherID() != null}">
                                                <input type="date" name="endDate" required="" value="${voucher.getExpiryDate()}"/>
                                            </c:if>
                                            <c:if test="${voucher.getVoucherID() == null || requestScope.id != null}">
                                                <input type="date" name="endDate" required="" value="${requestScope.enddate}"/>
                                            </c:if>
                                        </div>
                                        <c:if test="${not empty requestScope.dateErr}">
                                            <p style="color: red">${requestScope.dateErr}</p>
                                        </c:if>     
                                    </div>  

                                </div>
                                <!-- Submit and Cancel buttons -->
                                <div class="d-flex justify-content-end">
                                    <a class="btn btn-danger ps-2 mx-2" href="../SWP391-G2/voucher">Cancel</a>
                                    <c:if test="${voucher.getVoucherID() == null && requestScope.id == null}">
                                        <button type="submit" class="btn btn-primary ps-2" id="updateButton">ADD</button>
                                    </c:if>
                                    <c:if test="${voucher.getVoucherID() != null && requestScope.id == null}">
                                        <button type="submit" class="btn btn-primary ps-2" id="updateButton">Update</button>
                                    </c:if>
                                    <c:if test="${requestScope.id != null}">
                                        <button type="submit" class="btn btn-primary ps-2" id="updateButton">Update</button>
                                    </c:if>
                                </div>
                            </form>
                            </div>
                            </div>
                            </div>
                            </body>


                            <!-- =========== Scripts =========  -->
                            <script src="js/admin_manager.js"></script>
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

                                document.addEventListener("DOMContentLoaded", function () {
                                    const discountInput = document.getElementById("discount");

                                    // Không hiển thị giá trị mặc định là 0
                                    if (parseFloat(discountInput.defaultValue) === 0) {
                                        discountInput.defaultValue = '';
                                    }

                                    discountInput.addEventListener("input", function () {
                                        let value = discountInput.value;

                                        // Chỉ giữ lại các ký tự số và dấu chấm thập phân
                                        value = value.replace(/[^0-9.]/g, '');

                                        // Đảm bảo chỉ có một dấu chấm thập phân
                                        const parts = value.split('.');
                                        if (parts.length > 2) {
                                            value = parts[0] + '.' + parts.slice(1).join('');
                                        }

                                        // Giới hạn số chữ số thập phân (ở đây giới hạn 2 chữ số thập phân)
                                        if (parts.length > 1 && parts[1].length > 2) {
                                            value = parts[0] + '.' + parts[1].substring(0, 2);
                                        }

                                        // Chuyển đổi giá trị thành số thực (float) để kiểm tra phạm vi
                                        const numericValue = parseFloat(value);

                                        // Loại bỏ các số ngoài khoảng 1 đến 99
                                        if (!isNaN(numericValue) && (numericValue < 1 || numericValue > 99)) {
                                            value = discountInput.defaultValue.toString();
                                        }

                                        discountInput.value = value;
                                    });

                                    // Loại bỏ giá trị mặc định là 0 khi tải trang
                                    if (discountInput.value === '0') {
                                        discountInput.value = '';
                                    }


                                    const quantityInput = document.getElementById("quantity");
                                    quantityInput.addEventListener("input", function () {
                                        let value = quantityInput.value;
                                        // Chỉ giữ lại các ký tự số
                                        value = value.replace(/[^0-9]/g, '');
                                        // Loại bỏ các số ngoài khoảng 1 đến 99
                                        if (value !== '' && (parseInt(value) < 1 || parseInt(value) > 99)) {
                                            value = quantityInput.defaultValue;
                                        }
                                        quantityInput.value = value;
                                    });
                                });


                            </script>
                            <script>
                                // Function to set the default date to today
                                window.onload = function () {
                                    // Lấy ngày hôm nay
                                    var today = new Date();
                                    var day = String(today.getDate()).padStart(2, '0');
                                    var month = String(today.getMonth() + 1).padStart(2, '0'); // Tháng bắt đầu từ 0
                                    var year = today.getFullYear();

                                    // Định dạng yyyy-mm-dd
                                    var todayDate = year + '-' + month + '-' + day;

                                    // Thiết lập giá trị mặc định và giá trị min cho input type="date"
                                    var endDateInput = document.querySelector('input[name="startDate"]');
                                    endDateInput.value = todayDate;
                                    endDateInput.min = todayDate;
                                };
                            </script>


                            </html>
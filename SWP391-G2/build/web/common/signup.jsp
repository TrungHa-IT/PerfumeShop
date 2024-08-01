

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="./images/logo/image.png" type="image/x-icon" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <title>The perfume shop</title>
        <style>
            .line::before{
                content: 'Or';
                position: absolute;
                top: -2500%;
                right: -10%;
                transform: translate(-50%,-50%);
                background-color: #ffff;
                color: #232836;
                padding: 0 15px;
            }
            .loading-spinner {
                position: fixed;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
                border: 16px solid #f3f3f3;
                border-top: 16px solid #3498db;
                border-radius: 50%;
                width: 120px;
                height: 120px;
                animation: spin 2s linear infinite;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }
        </style>
    </head>
    <body style="background-color: pink">
        <div class="row vh-100 g-0"  >
            <!--left side  -->
            <input type="hidden" id="success" value="${requestScope.success}" >
            <input type="hidden" id="error" value="${requestScope.error}" >
            
            <!--/ left side  -->

            <!-- right side  -->
            <div class="d-flex justify-content-center">

                <div class=" col col-sm-9 col-lg-9 col-xl-6  row align-items-center justify-content-center h-100 g-0 px-4 px-sm">
                    <div class=" border rounded-5 p-5 shadow" style="background-color: #ffffff" >
                        <div class="text-center mb-5">
                            <h1 class="fw-bold pb-3 pt-5">SIGN UP</h1>
                            <form action="./signup" id="form" method="post" >
                                <div class="input-group mb-3" >
                                    <span class="input-group-text">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope-at-fill" viewBox="0 0 16 16">
                                        <path d="M2 2A2 2 0 0 0 .05 3.555L8 8.414l7.95-4.859A2 2 0 0 0 14 2zm-2 9.8V4.698l5.803 3.546zm6.761-2.97-6.57 4.026A2 2 0 0 0 2 14h6.256A4.5 4.5 0 0 1 8 12.5a4.49 4.49 0 0 1 1.606-3.446l-.367-.225L8 9.586zM16 9.671V4.697l-5.803 3.546.338.208A4.5 4.5 0 0 1 12.5 8c1.414 0 2.675.652 3.5 1.671"/>
                                        <path d="M15.834 12.244c0 1.168-.577 2.025-1.587 2.025-.503 0-1.002-.228-1.12-.648h-.043c-.118.416-.543.643-1.015.643-.77 0-1.259-.542-1.259-1.434v-.529c0-.844.481-1.4 1.26-1.4.585 0 .87.333.953.63h.03v-.568h.905v2.19c0 .272.18.42.411.42.315 0 .639-.415.639-1.39v-.118c0-1.277-.95-2.326-2.484-2.326h-.04c-1.582 0-2.64 1.067-2.64 2.724v.157c0 1.867 1.237 2.654 2.57 2.654h.045c.507 0 .935-.07 1.18-.18v.731c-.219.1-.643.175-1.237.175h-.044C10.438 16 9 14.82 9 12.646v-.214C9 10.36 10.421 9 12.485 9h.035c2.12 0 3.314 1.43 3.314 3.034zm-4.04.21v.227c0 .586.227.8.581.8.31 0 .564-.17.564-.743v-.367c0-.516-.275-.708-.572-.708-.346 0-.573.245-.573.791"/>
                                        </svg>
                                    </span>
                                    <div class="form-floating">
                                        <input type="email" name="email" id="email" value="${param.email}" maxlength="50" class="form-control form-control-lg fs-6" required placeholder="Email">
                                        <label for="floatingInputGroup1">Email</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="input-group mb-3 col" >
                                        <span class="input-group-text">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-vcard" viewBox="0 0 16 16">
                                            <path d="M5 8a2 2 0 1 0 0-4 2 2 0 0 0 0 4m4-2.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5M9 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4A.5.5 0 0 1 9 8m1 2.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1-.5-.5"/>
                                            <path d="M2 2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2zM1 4a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H8.96q.04-.245.04-.5C9 10.567 7.21 9 5 9c-2.086 0-3.8 1.398-3.984 3.181A1 1 0 0 1 1 12z"/>
                                            </svg>
                                        </span>
                                        <div class="form-floating">
                                            <input type="text" name="firstname" required="" maxlength="50" value="${param.firstname}" class="form-control form-control-lg fs-6" placeholder="First Name">
                                            <label for="floatingInputGroup1">First name</label>
                                        </div>
                                    </div>
                                    <div class="input-group mb-3 col" >
                                        <span class="input-group-text">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-vcard" viewBox="0 0 16 16">
                                            <path d="M5 8a2 2 0 1 0 0-4 2 2 0 0 0 0 4m4-2.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5M9 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4A.5.5 0 0 1 9 8m1 2.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1-.5-.5"/>
                                            <path d="M2 2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2zM1 4a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H8.96q.04-.245.04-.5C9 10.567 7.21 9 5 9c-2.086 0-3.8 1.398-3.984 3.181A1 1 0 0 1 1 12z"/>
                                            </svg>
                                        </span>
                                        <div class="form-floating">
                                            <input type="text" name="lastname" required="" maxlength="50" value="${param.lastname}" class="form-control form-control-lg fs-6" placeholder="Last Name">
                                            <label for="floatingInputGroup1">Last name</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="input-group mb-3 col" >
                                        <span class="input-group-text">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar-event" viewBox="0 0 16 16">
                                            <path d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5z"/>
                                            <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5M1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4z"/>
                                            </svg>
                                        </span>
                                        <div class="form-floating">
                                            <input type="date" name="brithday" required=""  value="${param.brithday}" id="dateinput" max="" class="form-control form-control-lg fs-6" mix="1900-01-01">
                                            <label for="floatingInputGroup1">Birthday</label>
                                        </div>
                                    </div>
                                    <div class="input-group mb-3 col" >
                                        <div class="form-floating">
                                            <select class="form-select" name="gender" id="gender" aria-label="Default select example">
                                                <option value="0">Prefer not to say</option>
                                                <option value="1">Male</option>
                                                <option value="2">Female</option>
                                            </select>
                                            <label for="floatingSelect">Gender</label>
                                        </div>

                                    </div>
                                </div>


                                <div class="row mb-3" >
                                    <div class="input-group col-10" >
                                        <span class="input-group-text">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
                                            <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2m3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2"/>
                                            </svg>
                                        </span>
                                        <div class="form-floating">
                                            <input type="password" name="password" maxlength="512"  required="" class="form-control form-control-lg fs-6" placeholder="Password">
                                            <label for="floatingInputGroup1">Password</label>
                                        </div>
                                    </div>
                                </div>




                                <div class="input-group mb-3">
                                    <span class="input-group-text">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
                                        <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2m3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2"/>
                                        </svg>
                                    </span>
                                    <div class="form-floating">
                                        <input type="password" name="confirmpassword" maxlength="512"  required="" class="form-control form-control-lg fs-6" placeholder="Confirm password">
                                        <label for="floatingInputGroup1">Confirm password</label>
                                    </div>
                                </div>

                                <div class="input-group mb-3 d-flex justify-content-between">
                                    <div>
                                        <small><a href="#" class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Forgot Password?</a></small>
                                    </div>
                                    <div id="showButton" class="col-1 p-0 m-0 d-flex justify-content-end float-right"> 
                                        <svg xmlns="http://www.w3.org/2000/svg" width="100" height="20" fill="currentColor" class="mx-2 bi bi-exclamation-circle-fill btn-link btn-light border-0" viewBox="0 0 16 16">
                                        Show Password Requirements
                                        <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4m.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2"/>
                                        </svg>
                                    </div>
                                </div>
                                <div id="more" style="margin-left: 110%;">
                                    <ul id="dropdown-menu" class="dropdown-menu shadow-sm">
                                        <li class="dropdown-item">Password must contain:</li>
                                        <li class="dropdown-item">At least 8 characters in length</li>
                                        <li class="dropdown-item">At least 1 number (0-9)</li>
                                        <li class="dropdown-item">At least 1 lowercase letter (a-z)</li>
                                        <li class="dropdown-item">At least 1 special symbol (!-$)</li>
                                        <li class="dropdown-item">At least 1 uppercase letter (A-Z)</li>
                                    </ul>
                                </div>
                                <button type="submit" class="btn btn-dark btn-lg w-100 mb-3">Sign up</button>
                            </form>
                            <div>
                                <hr/>
                                  <div>
                                        <small><a href="${pageContext.request.contextPath}/login" class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">back to login</a></small>
                                    </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--/ right side  -->

        </div>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        const today = new Date();
        // Lấy các thành phần của ngày
        const year = today.getFullYear() - 16;
        const month = String(today.getMonth() + 1).padStart(2, '0'); // Tháng bắt đầu từ 0
        const day = String(today.getDate()).padStart(2, '0'); // Ngày của tháng

        // Định dạng ngày theo 'yyyy-dd-MM'
        const formattedDate = (year) + '-' + month + '-' + day;
        // Đặt thuộc tính 'max' của phần tử input
        document.getElementById('dateinput').setAttribute('max', formattedDate);
        document.addEventListener('DOMContentLoaded', function () {
            var button = document.getElementById("showButton");
            button.addEventListener("click", function () {
                var dropdownMenu = document.getElementById("dropdown-menu");
                if (dropdownMenu.style.display === "none" || dropdownMenu.style.display === "") {
                    dropdownMenu.style.display = "block";
                } else {
                    dropdownMenu.style.display = "none";
                }
            });
        });
        document.getElementById('form').addEventListener('submit', function () {
            // Hiển thị chỉ báo tải
            loading();
        });
        function loading() {
            let timerInterval;
            Swal.fire({
                title: "Loading...",
                didOpen: () => {
                    Swal.showLoading();

                },
                willClose: () => {

                }
            }).then((result) => {

            });
        }
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

</html>

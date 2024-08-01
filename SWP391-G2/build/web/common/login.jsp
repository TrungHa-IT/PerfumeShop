<%-- 
    Document   : login
    Created on : May 20, 2024, 10:17:40 PM
    Author     : nguye
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <style>
            .line::before{
                content: 'Or';
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%,-50%);
                background-color: #ffff;
                color: #232836;
                padding: 0 15px;
            }
        </style>
        <title>The perfume shop</title>
        <link rel="icon" href="./images/logo/image.png" type="image/x-icon" />

    </head>
    <input type="hidden" id="success" value="${requestScope.success}" >
    <input type="hidden" id="error" value="${requestScope.error}" >
    <body style="background-color: pink">
        <div class="row vh-100 g-0" style="background-color: pink">
            <c:if test="${requestScope.err != null}">
                <div class="p-0 m-0 fixed-top text-center">

                    <div class="alert alert-warning text-center" role="alert">
                        ${requestScope.err}
                    </div>
                </div>
            </c:if>
            <!--/ left side  -->

            <!-- right side  -->
            <div class="d-flex justify-content-center">
                <div class=" col col-sm-9 col-lg-7 col-xl-5  row align-items-center justify-content-center h-100 g-0 px-4 px-sm">
                    <div class=" border rounded-5 p-5 shadow" style="background-color: #ffffff">
                        <div class="text-center mb-5">
                            <h1 class="fw-bold pb-5">Login</h1>
                            <div class="mt-3 mb-3">

                                <a class="btn btn-lg btn-light w-100 border"  href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/SWP391-G2/LoginGoogleHandler&response_type=code&client_id=64210906671-gn1cclen03hhngkbb5ultf010ppcss6p.apps.googleusercontent.com&approval_prompt=force"><svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="30" height="30" viewBox="0 0 48 48">
                                    <path fill="#FFC107" d="M43.611,20.083H42V20H24v8h11.303c-1.649,4.657-6.08,8-11.303,8c-6.627,0-12-5.373-12-12c0-6.627,5.373-12,12-12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C12.955,4,4,12.955,4,24c0,11.045,8.955,20,20,20c11.045,0,20-8.955,20-20C44,22.659,43.862,21.35,43.611,20.083z"></path><path fill="#FF3D00" d="M6.306,14.691l6.571,4.819C14.655,15.108,18.961,12,24,12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C16.318,4,9.656,8.337,6.306,14.691z"></path><path fill="#4CAF50" d="M24,44c5.166,0,9.86-1.977,13.409-5.192l-6.19-5.238C29.211,35.091,26.715,36,24,36c-5.202,0-9.619-3.317-11.283-7.946l-6.522,5.025C9.505,39.556,16.227,44,24,44z"></path><path fill="#1976D2" d="M43.611,20.083H42V20H24v8h11.303c-0.792,2.237-2.231,4.166-4.087,5.571c0.001-0.001,0.002-0.001,0.003-0.002l6.19,5.238C36.971,39.205,44,34,44,24C44,22.659,43.862,21.35,43.611,20.083z"></path>
                                    </svg>  Login With Google</a>
                            </div>
                            <div class="position-relative bg-secondary-subtle mb-3 line" style="width: 100%; height: 1px;"></div>
                            <form action="${pageContext.request.contextPath}/login" method="post" >
                                <div class="input-group mb-3" >
                                    <span class="input-group-text">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope-at-fill" viewBox="0 0 16 16">
                                        <path d="M2 2A2 2 0 0 0 .05 3.555L8 8.414l7.95-4.859A2 2 0 0 0 14 2zm-2 9.8V4.698l5.803 3.546zm6.761-2.97-6.57 4.026A2 2 0 0 0 2 14h6.256A4.5 4.5 0 0 1 8 12.5a4.49 4.49 0 0 1 1.606-3.446l-.367-.225L8 9.586zM16 9.671V4.697l-5.803 3.546.338.208A4.5 4.5 0 0 1 12.5 8c1.414 0 2.675.652 3.5 1.671"/>
                                        <path d="M15.834 12.244c0 1.168-.577 2.025-1.587 2.025-.503 0-1.002-.228-1.12-.648h-.043c-.118.416-.543.643-1.015.643-.77 0-1.259-.542-1.259-1.434v-.529c0-.844.481-1.4 1.26-1.4.585 0 .87.333.953.63h.03v-.568h.905v2.19c0 .272.18.42.411.42.315 0 .639-.415.639-1.39v-.118c0-1.277-.95-2.326-2.484-2.326h-.04c-1.582 0-2.64 1.067-2.64 2.724v.157c0 1.867 1.237 2.654 2.57 2.654h.045c.507 0 .935-.07 1.18-.18v.731c-.219.1-.643.175-1.237.175h-.044C10.438 16 9 14.82 9 12.646v-.214C9 10.36 10.421 9 12.485 9h.035c2.12 0 3.314 1.43 3.314 3.034zm-4.04.21v.227c0 .586.227.8.581.8.31 0 .564-.17.564-.743v-.367c0-.516-.275-.708-.572-.708-.346 0-.573.245-.573.791"/>
                                        </svg>
                                    </span>
                                    <div class="form-floating">
                                        <input type="email" required="" name="email" maxlength="50" value="${requestScope.email}" class="form-control form-control-lg fs-6" placeholder="Email">
                                        <label for="floatingInputGroup1">Email</label>
                                    </div>
                                </div>
                                <div class="input-group mb-3" >
                                    <span class="input-group-text">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
                                        <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2m3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2"/>
                                        </svg>
                                    </span>
                                    <div class="form-floating">
                                        <input type="password" required="" maxlength="512" name="password" value="${requestScope.password}" class="form-control form-control-lg fs-6" placeholder="Password">
                                        <label for="floatingInputGroup1">Password</label>
                                    </div>
                                </div>
                                <div class="input-group mb-3 d-flex justify-content-between">
                                    <div class="form-check">
                                        <input type="checkbox" name="remember" class="form-check-input" id="formCheck">
                                        <label for="formCheck" class="form-check-label text-secondary"><small>Remember Me</small></label>
                                    </div>
                                    <div>
                                        <small><a href="#" class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Forgot Password?</a></small>
                                    </div>
                                </div>
                                <button class="btn btn-dark btn-lg  w-100 mb-3" onclick="loading()" name="login"> Login</button>

                            </form>
                            <div class="text-center">
                                <small>Don't have an accout? <a href="${pageContext.request.contextPath}/signup" class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Sign Up</a></small>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!--/ right side  -->
        </div>
    </body>
    <script>
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
        function successfully(text) {
            const Toast = Swal.mixin({
                toast: true,
                position: "top-end",
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true,
                didOpen: (toast) => {
                    toast.onmouseenter = Swal.stopTimer;
                    toast.onmouseleave = Swal.resumeTimer;
                }
            });
            Toast.fire({
                icon: "success",
                title: "Signed up successfully"
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
    </script>
</html>
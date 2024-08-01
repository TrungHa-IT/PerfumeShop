<%-- 
    Document   : email
    Created on : May 29, 2024, 10:48:05 AM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="./images/logo/image.png" type="image/x-icon" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <title>The perfume shop</title>
    </head>
    <body >
        <div class="row vh-100 g-0">
            <c:if test="${requestScope.err != null}">
                <div class="p-0 m-0 fixed-top text-center">

                    <div class="alert alert-warning text-center" role="alert">
                        ${requestScope.err}
                    </div>
                </div>
            </c:if>
            <div class="d-flex justify-content-center">
                <div class=" col col-sm-9 col-lg-7 col-xl-5  row align-items-center justify-content-center h-100 g-0 px-4 px-sm">
                    <div style="background-color: pink" class=" text-center p-5 ps-5 border rounded-5 shadow justify-content-center row container d-flex align-items-center justify-content-center">


                        <form method="get" action="./ForgotPasswordOTP" class="row g-3 justify-content-center">
                            <h1 class="pb-5">VERIFY EMAIL</h1>
                            <div class="col-auto">
                                <label for="inputPassword2" class="visually-hidden"></label>
                                <input type="number" name="OTP" maxlength="6" class="form-control" required="" id="inputPassword2" placeholder="XXXXXX">
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-dark mb-3">Confirm identity</button>
                            </div>
                        </form>
                    </div>
                </div>

            </div>

        </div>
    </body>
    
</html>

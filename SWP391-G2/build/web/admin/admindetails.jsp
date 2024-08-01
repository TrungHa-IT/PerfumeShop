<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Admin | The Perfume Shop</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/logo.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!-- Include Bootstrap CSS via CDN link -->
        <!-- ======= Styles ====== -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin_manager.css">
    </head>

    <body>
        <div class="container-fluid">
            <!-- Navigation -->
            <jsp:include page="admin-navigation.jsp"></jsp:include>

                <!-- Main Content -->
                <div class="main" style="margin-left: 50px; margin-right: 50px;">
                    <div class="row" style="margin-right: 70px;  padding: 10px; border: 1.5px solid #000;">
                        <input type="hidden" id="pageNo" name="pageNo" value="${currentPage}">
                    <div class="col-12" style="margin-bottom: 40px;">
                        <h1>Account details</h1>
                    </div>
                    <form action="admindetails" method="post" enctype="multipart/form-data"  onsubmit="showUpdateAlert()">
                        <input type="text" value="${data.getAccountID()}" name="id" hidden>
                        <input type="text" value="${requestScope.roleId}" name="roleId" id="roleId" hidden>
                        <input type="text" value="${requestScope.status}" name="status" id="status" hidden> 
                        <input type="text" value="${requestScope.currentPage}" name="pageNo" id="pageNo" hidden>
                        <input type="text" value="${requestScope.search}" name="search" id="search" hidden>
                        <div class="form-group row">
                            <c:if test="${data.getImage() != null}">
                                <div class="input-group"> <input type="file" name="img" class="form-control d-none" id="inputGroupFile04" onchange="chooseFile(this)" accept="image/gif,image/jpeg,image/png" aria-describedby="inputGroupFileAddon04" aria-label="Upload"> <label for="inputGroupFile04">
                                        <img src="images/Account/${data.getImage()}" id="image" class="img-thumbnail rounded-5" width="250" height="300" alt="${data.getImage()}"></label> 
                                </div>
                            </c:if>
                            <c:if test="${data.getImage() == null}">
                                <div class="input-group"> <input type="file" name="img" class="form-control d-none" id="inputGroupFile04" onchange="chooseFile(this)" accept="image/gif,image/jpeg,image/png" aria-describedby="inputGroupFileAddon04" aria-label="Upload"> <label for="inputGroupFile04">
                                        <img src="images/Account/default.png" id="image" class="img-thumbnail rounded-5" width="100%" alt="${data.getImage()}"></label> 
                                </div>
                            </c:if>
                            <div class="col-4">
                                <label for="firstName">First Name:</label>
                                <input type="text" class="form-control" id="firstName" name="firstName"
                                       value="${data.getFirstName()}" readonly>
                            </div>
                            <div class="col-4">
                                <label for="lastName">Last Name:</label>
                                <input type="text" class="form-control" id="lastName" name="lastName"
                                       value="${data.getLastName()}" readonly>
                            </div>
                            
                        </div>

                        <div class="form-group row">
                            <div class="col-4">
                                <label for="email">Date Of Birth:</label>
                                <input type="date" class="form-control" id="dob" name="dob"
                                       value="<fmt:formatDate value='${data.getBirthDay()}' pattern='yyyy-MM-dd'/>" readonly>
                            </div>
                            <div class="col-4">
                                <label for="email">Email:</label>
                                <input type="email" class="form-control" id="email" name="email"
                                       value="${data.getEmail()}" readonly>
                            </div>

                        </div>
                        <div class="form-group row">
                            <div class="col-2">
                                <label for="roleId">Role:</label>
                                <select class="form-control" id="roleIDnew" name="roleIDnew">
                                    <c:forEach items="${requestScope.listRole}" var="role">
                                        <option value="${role.getRoleID()}" ${role.getRoleID()==data.getRoleID() ? 'selected'
                                                         : '' }>
                                                    ${role.getRoleName()}
                                                </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-2">
                                    <label for="roleId">Status:</label>
                                    <select class="form-control" id="status" name="statusnew">
                                        <option value="1" ${data.getStatus()==1 ? 'selected' : '' }>Active</option>
                                        <option value="0" ${data.getStatus()==0 ? 'selected' : '' }>In-Active</option>
                                    </select>
                                </div>
                            </div>

                            <a class="btn btn-primary" onclick="cancel()">Cancel</a>
                            <button type="submit" class="btn btn-primary">Update</button>
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
                                function showUpdateAlert() {
                                    alert("Account details updated successfully!");
                                }
                                function chooseFile(fileInput) {
                                    if (fileInput.files && fileInput.files[0]) {
                                        var reader = new FileReader();

                                        reader.onload = function (e) {
                                            $('#image').attr('src', e.target.result);
                                        }
                                        reader.readAsDataURL(fileInput.files[0]);
                                    }
                                }
                                function cancel() {
                                    const confirmation = confirm("Do you want to cancel?");
                                    if (confirmation) {
                                        const search = document.querySelector('#search').value;
                                        const roleId = document.querySelector('#roleId').value;
                                        const status = document.querySelector('#status').value;
                                        const pageNo = document.querySelector('#pageNo').value;
                                        window.location.href = 'admincontrolaccount?search=' + search + '&roleId=' + roleId +
                                                '&status=' + status + '&pageNo=' + pageNo;
                                    }
                                }
        </script>

    </html>
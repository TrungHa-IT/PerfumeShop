<%-- 
    Document   : admin
    Created on : Jun 4, 2024, 11:25:56 PM
    Author     : hatru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title> Manage Admin | The Perfume Shop</title>
        <link rel="icon" type="image/x-icon" href="img/logo.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <!-- Include Bootstrap CSS via CDN link -->
        <!-- ======= Styles ====== -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin_manager.css"/>
    </head>

    <body>
        <c:if test="${requestScope.error !=null}">
            <div class="row fixed-top text-center">

                <div class=" alert alert-warning" role="alert">
                    ${requestScope.error}

                </div>
            </div>

        </c:if>
        <c:if test="${requestScope.success !=null}">
            <div class="row fixed-top text-center">

                <div class=" alert alert-success" role="alert">
                    ${requestScope.success}
                </div>
            </div>
        </c:if>

        <div class="container-fluid">
            <!-- Navigation -->
            <jsp:include page="../partials/navigation.jsp"></jsp:include>

                <!-- Main Content -->
                <div class="main" style="margin-left: 50px; margin-right: 50px;">
                    <div class="topbar">
                        <!-- <div class="toggle">
            <ion-icon name="menu-outline"></ion-icon>
        </div>
        <div class="user">
            <img src="assets/imgs/customer01.jpg" alt="">
        </div> -->
                    </div>

                    <div class="row" style="margin-right: 70px;  padding: 10px; border: 1.5px solid #000;">
                        <input type="hidden" id="pageNo" name="pageNo" value="${currentPage}">
                    <div class="col-12" style="margin-bottom: 40px;">
                        <h1>Admin & Manager</h1>

                    </div>
                    <div class="col-3">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search" value="${search}"
                                   id="search">
                            <div class="input-group-append">
                                <button class="btn btn-secondary" type="button" id="btnSearch">
                                    <ion-icon name="search-outline"></ion-icon>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-3">
                        <select class="form-control" id="roleId" name="roleId">
                            <option value="-1" ${roleId==null ? 'selected' : '' }>All role</option>
                            <c:forEach items="${listRole}" var="role">
                                <option value="${role.roleID}" ${role.roleID==roleId ? 'selected' : '' }>
                                    ${role.roleName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-3">
                        <!-- <select class="form-control" id="status">
                            <option value="1" selected>Status: Active</option>
                            <option value="0">Status: In-Active</option>
                        </select> -->
                        <select class="form-control" id="status" name="status">
                            <option value="-1" ${status==null ? 'selected' : '' }>All status</option>
                            <option value="1" ${status==1 ? 'selected' : '' }>Active</option>
                            <option value="0" ${status==0 ? 'selected' : '' }>In-Active</option>
                        </select>
                    </div>

                    <div class="col-3">

                        <div class="text-right">
                            <button type="button" class="btn btn-success" onclick="redirectToAddAccount()">
                                <ion-icon style="margin-top: 2px;" name="add-outline"></ion-icon> Add New
                            </button>
                        </div>

                    </div>
                    <div class="col-12" style="margin-top: 10px;">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Full Name</th>
                                        <th scope="col">Gender</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">BirthDate</th>
                                        <th scope="col">Role</th>
                                        <th scope="col">Details</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listUser}" var="user" varStatus="loop">
                                        <tr>
                                            <td>${(requestScope.currentPage-1)*10+loop.index+1}</td>
                                            <td><a href="admindetails?id=${user.getAccountID()}&roleID=${user.getRoleID()}">${user.getFirstName()} ${user.getLastName()}</a></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.getGender() == 1}">Male</c:when>
                                                    <c:when test="${user.getGender() == 2}">Female</c:when>
                                                    <c:when test="${user.getGender() == 3}">None</c:when>
                                                    <c:otherwise>User</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${user.getEmail()}</td>
                                            <td><fmt:formatDate value='${user.getBirthDay()}' pattern='yyyy-MM-dd'/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.getRoleID() == 1}">Admin</c:when>
                                                    <c:when test="${user.getRoleID() == 3}">Marketing</c:when>
                                                    <c:when test="${user.getRoleID() == 2}">Saler</c:when>
                                                    <c:otherwise>Customer</c:otherwise>
                                                </c:choose>
                                            </td>

                                            <!-- create button Block if status is 1 and Unblock if status is 0 and have tag a href is updateStatusAdmin?status?id-->
                                            <td>

                                                <c:choose>
                                                    <c:when test="${user.getStatus() == 1 && user.getRoleID() !=1}">
                                                        <a  onclick="showAlert(' Blocked account successfully!',${user.getAccountID()}, 0)">
                                                            <button type="button" class="btn btn-danger">
                                                                Block
                                                            </button>
                                                        </a>
                                                    </c:when>
                                                    <c:when test="${user.getStatus() == 0 && user.getRoleID() !=1}">
                                                        <a  onclick="showAlert('Unblocked account successfully!',${user.getAccountID()}, 1);">
                                                            <button type="button" class="btn btn-success">
                                                                UnBlock
                                                            </button>
                                                        </a>
                                                    </c:when>
                                                    <c:when test="${user.getRoleID() ==1}">
                                                        
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <!-- Pagination -->
                        <nav aria-label="...">
                            <ul class="pagination justify-content-end">
                                <c:if test="${currentPage == 1}">
                                    <li class="page-item disabled">
                                        <button class="page-link" onclick="changePage(${currentPage - 1})">
                                            Previous
                                        </button>
                                    </li>
                                </c:if>
                                <c:if test="${currentPage != 1}">
                                    <li class="page-item">
                                        <button class="page-link" onclick="changePage(${currentPage - 1})">
                                            Previous
                                        </button>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPage}" var="i">
                                    <c:if test="${currentPage == i}">
                                        <li class="page-item active" aria-current="page">
                                            <button class="page-link" onclick="changePage(${i})">
                                                ${i}
                                                <span class="sr-only">(current)</span>
                                            </button>
                                        </li>
                                    </c:if>
                                    <c:if test="${currentPage != i}">
                                        <li class="page-item">
                                            <button class="page-link" onclick="changePage(${i})">${i}</button>
                                        </li>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${currentPage == totalPage}">
                                    <li class="page-item disabled">
                                        <button class="page-link"
                                                onclick="changePage(${currentPage + 1})">Next</button>
                                    </li>
                                </c:if>
                                <c:if test="${currentPage != totalPage}">
                                    <li class="page-item">
                                        <button class="page-link"
                                                onclick="changePage(${currentPage + 1})">Next</button>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>


                    </div>
                </div>

                <!-- Modal Add new-->
                <div class="modal fade" id="addnewModal" tabindex="-1" role="dialog"
                     aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLongTitle">Add new Users</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form action="admincontrolaccount" method="post">

                                <div class="modal-body">
                                    <input type="hidden" name="service" value="addNewAdmin">
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <label for="firstName">FirstName: </label>
                                            <input type="text" class="form-control" id="firstname"
                                                   name="firstname" required>
                                        </div>
                                        <div class="col-12">
                                            <label for="lastName">LastName: </label>
                                            <input type="text" class="form-control" id="lastname"
                                                   name="lastname" required>
                                        </div>
                                        <div class="col-12">
                                            <label for="lastName">Password: </label>
                                            <input type="text" class="form-control" id="lastname"
                                                   name="lastname" required>
                                        </div>
                                        <div class="col-12">
                                            <label for="lastName">Gender </label>
                                            <select name="gender" id="cars">
                                                <option value="1">Male</option>
                                                <option value="2">Female</option>
                                                <option value="3">None</option>

                                            </select>
                                        </div>
                                        <div class="col-12">
                                            <label for="lastName">BirthDate: </label>
                                            <input type="date" class="form-control" id="lastname"
                                                   name="lastname" required>
                                        </div>
                                        <div class="col-12">
                                            <label for="lastName">Gmail: </label>
                                            <input type="text" class="form-control" id="lastname"
                                                   name="lastname" required>
                                        </div>
                                        <div class="col-12">
                                            <label for="lastName">Role: </label>
                                            <input type="text" class="form-control" id="lastname"
                                                   name="lastname" required>
                                        </div>

                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary"
                                            data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary" onclick="showAddNewSuccessAlert()">Add new</button>
                                </div>

                            </form>
                        </div>
                    </div>
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
                                        function showAlert(message, accountID, status1) {


                                            if (confirm(message)) {
                                                const search = document.querySelector('#search').value;
                                                const roleId = document.querySelector('#roleId').value;
                                                const status = document.querySelector('#status').value;
                                                const pageNo = document.querySelector('#pageNo').value;
                                                window.location.href = 'admincontrolaccount?search=' + search + '&roleId=' + roleId +
                                                        '&status=' + status + '&pageNo=' + pageNo + "&accountID=" + accountID + "&statusnew=" + status1;
                                            }
                                        }
                                        function showDetail(accountID, accountRole) {
                                            const search = document.querySelector('#search').value;
                                            const roleId = document.querySelector('#roleId').value;
                                            const status = document.querySelector('#status').value;
                                            const pageNo = document.querySelector('#pageNo').value;
                                            window.location.href = 'admindetails?search=' + search + '&roleId=' + roleId +
                                                    '&status=' + status + '&pageNo=' + pageNo + '&id=' + accountID + '&roleID=' + accountRole;
                                        }
    </script>
    <script>
        const searchInput = document.querySelector('#search');
        searchInput.addEventListener('keydown', (event) => {
            if (event.key === 'Enter') {
                performSearch();
            }
        });
        const btnSearch = document.querySelector('#btnSearch');
        btnSearch.addEventListener('click', () => {
            performSearch(); // call function
        });


        function performSearch() {
            const search = document.querySelector('#search').value;
            const roleId = document.querySelector('#roleId').value;
            const status = document.querySelector('#status').value;
            const pageNo = document.querySelector('#pageNo').value;
            window.location.href = 'admincontrolaccount?search=' + search + '&roleId=' + roleId +
                    '&status=' + status + '&pageNo=1';
        }
        ;

        // handle filter role
        const roleId = document.querySelector('#roleId');
        roleId.addEventListener('change', () => {
            const search = document.querySelector('#search').value;
            const roleId = document.querySelector('#roleId').value;
            const status = document.querySelector('#status').value;
            const pageNo = document.querySelector('#pageNo').value;
            window.location.href = 'admincontrolaccount?search=' + search + '&roleId=' + roleId +
                    '&status=' + status + '&pageNo=1';
        });

        // handle filter status
        const status = document.querySelector('#status');
        status.addEventListener('change', () => {
            const search = document.querySelector('#search').value;
            const roleId = document.querySelector('#roleId').value;
            const status = document.querySelector('#status').value;
            const pageNo = document.querySelector('#pageNo').value;
            window.location.href = 'admincontrolaccount?search=' + search + '&roleId=' + roleId +
                    '&status=' + status + '&pageNo=1';
        });

        // handle pagination
        function changePage(pageNo) {
            const search = document.querySelector('#search').value;
            const roleId = document.querySelector('#roleId').value;
            const status = document.querySelector('#status').value;
            window.location.href = 'admincontrolaccount?search=' + search + '&roleId=' + roleId +
                    '&status=' + status + '&pageNo=' + pageNo;
        }

    </script>

    <script>
        function redirectToAddAccount() {
            window.location.href = 'adminaddaccount';
        }

    </script>

</html>
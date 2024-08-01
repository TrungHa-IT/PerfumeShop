<%-- 
    Document   : manageBlog
    Created on : Jun 18, 2024, 9:22:49 AM
    Author     : TNO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Blog | iLocal Shop</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/logo.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin_manager.css">
        <style>
            /* Custom CSS for the table */
            .blog-table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                font-size: 18px;
                text-align: left;
            }
            .blog-table th, .blog-table td {
                padding: 12px;
                border: 1px solid #ddd;
            }
            .blog-table th {
                background-color: #f2f2f2;
            }
            .blog-table tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            .blog-table tr:hover {
                background-color: #f1f1f1;
            }
            .blog-table img {
                max-width: 100px;
                height: auto;
            }
            .table-title {
                margin-bottom: 20px;
            }
            .add-blog-btn {
                margin-bottom: 20px;
            }
            @media screen and (max-width: 768px) {
                .blog-table thead {
                    display: none;
                }
                .blog-table, .blog-table tbody, .blog-table tr, .blog-table td {
                    display: block;
                    width: 100%;
                }
                .blog-table tr {
                    margin-bottom: 15px;
                }
                .blog-table td {
                    text-align: right;
                    padding-left: 50%;
                    position: relative;
                }
                .blog-table td::before {
                    content: attr(data-label);
                    position: absolute;
                    left: 10px;
                    width: 50%;
                    padding-left: 15px;
                    font-weight: bold;
                    text-align: left;
                }
            }
        </style>
    </head>

    <body>
        <div class="container-fluid">
            <!-- Navigation -->
            <%@include file="../admin/admin-navigation.jsp"%>
                <!-- Main Content -->
                <div class="main" style="margin-left: 50px; margin-right: 50px;">
                    <div class="row" style="margin-right: 70px; padding: 10px; border: 1.5px solid #000;">
                        <div class="col-12">
                            <h2 class="table-title">Manage Blogs</h2>
                            <a  href="addBlog"class="btn btn-primary add-blog-btn">Add New Blog</a>
                            <table class="blog-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Image</th>
                                        <th>Title</th>
                                        <th>Author</th>
                                        <th>Date</th>
                                        <th>Last Update</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="blogList" items="${blogList}">
                                    <tr>
                                        <td data-label="ID">${blogList.id}</td>
                                        <td data-label="Image">
                                            <img src="${blogList.thumbnail}" alt="Blog Image">
                                        </td>
                                        <td data-label="Title">${blogList.title}</td>
                                        <td data-label="Author">${blogList.firstName} ${blogList.lastName}</td>
                                        <td data-label="Date">${blogList.createdAt}</td>
                                        <td data-label="Date">${blogList.updateAt}</td>

                                        <td data-label="Actions">
                                            <a href="formInforBlog?id=${blogList.id}" class="btn btn-warning">Edit</a>
                                            <a  href="deleteBlog?id=${blogList.id}" class="btn btn-danger" >Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                            <%@include file="../partials/pagination.jsp"%>
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
    </script>

</html>

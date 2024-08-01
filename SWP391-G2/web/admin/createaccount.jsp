<%-- 
    Document   : createaccount
    Created on : May 29, 2024, 9:56:31 PM
    Author     : hatru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create User</title>
        <link rel="stylesheet" href="css/account.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    </head>
    <body>
        <c:if test="${requestScope.error !=null}">
            <div class="row fixed-top text-center">

                <div class=" alert alert-warning" role="alert">
                    ${requestScope.error}
                </div>
            </div>
        </c:if>
        <div class="container">
            <h1>Create User</h1>
            <form action="adminupload" method="post"  class="user-form">
                <label for="firstname">First Name:</label>
                <input type="text" id="firstname" name="firstname" required>

                <label for="lastname">Last Name:</label>
                <input type="text" id="lastname" name="lastname" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <label for="image">Image:</label>
                <input type="file" id="image" name="image">

                <label for="gender">Gender:</label>
                <select id="gender" name="gender">
                    <option value="1">Male</option>
                    <option value="0">Female</options
                </select>

                <label for="birthday">Birthday:</label>
                <input type="date" id="birthday" name="birthday" required>

                <label for="phone">Phone:</label>
                <input type="tel" id="phone" name="phone" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="address">Address:</label>
                <textarea id="address" name="address" required></textarea>

                <label for="roleID">Role:</label>
                <select id="roleID" name="roleID">
                    <option value="1">Sale</option>
                    <option value="2">Marketing</option>
                </select>

                <button type="submit">Create User</button>
            </form>
            <h2 style="color: greenyellow">${requestScope.success}</h2>
        </div>
    </body>
</html>
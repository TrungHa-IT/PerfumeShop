<%-- 
    Document   : form
    Created on : Jul 2, 2024, 11:29:24 PM
    Author     : hatru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Redirecting...</title>
    <script type="text/javascript">
        function submitForm() {
            document.getElementById("hiddenForm").submit();
        }
    </script>
</head>
<body onload="submitForm()">
    <form id="hiddenForm" action="vnpay" method="post">
        <input type="hidden" name="total" value="${requestScope.total}">
    </form>
</body>
</html>
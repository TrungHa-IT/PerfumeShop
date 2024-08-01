<%-- 
    Document   : search_slider_title
    Created on : 4 thg 7, 2024, 11:09:26
    Author     : pna29
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table  class="table table-hover text-nowrap">
            <thead>
                <tr>
                    <th class="text_page_head" scope="col">Slider ID</th>
                    <th class="text_page_head" style="text-align: center" scope="col">Image</th>
                    <th class="text_page_head" scope="col">Slider Title</th>
                    <th class="text_page_head" scope="col">Update At</th>
                    <th class="text_page_head" scope="col">Account ID</th>
                    <th class="text_page_head" scope="col">Status</th>
                    <th class="text_page_head" scope="col">Actions</th>
                </tr>
            </thead>
            <tbody >
            <c:forEach items="${listByPage}" var="slider">
                <tr class="product_items">
                    <td class="text_page">${slider.sliderID}</td>
                    <td style="text-align: center">
                        <img style="width: 170px; height:180px" src="${slider.sliderImage}" alt="img"">
                    </td>
                    <td style="max-width: 280px;
                        padding: 10px;
                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        word-wrap: break-word;" class="text_page">${slider.sliderTitle}</td>                                               
                    <td class="text_page">${slider.updateAt}</td>
                    <td class="text_page">${slider.accountId}</td>
                    <td class="text_page">
                <c:choose>
                    <c:when test="${slider.sliderStatus == 1}">
                        <a href="updateStatusSlider?status=0&sliderId=${slider.sliderID}" onclick="return confirmAction('block');">
                            <button type="button" class="btn btn-danger">
                                Hide
                            </button>
                        </a>
                    </c:when>
                    <c:when test="${slider.sliderStatus == 0}">
                        <a href="updateStatusSlider?status=1&sliderId=${slider.sliderID}" onclick="return confirmAction('unblock');">
                            <button type="button" class="btn btn-success">
                                View
                            </button>
                        </a>
                    </c:when>
                </c:choose>
                </td>

                <td class="text_page">
                    <a href="./sliderDetails?sliderId=${slider.sliderID}"><button type="button" class="btn btn-warning"><i class="fa-solid fa-pen"></i></button></a>                                                  
                </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="clearfix" style="text-align: center">
        <ul class="pagination justify-content-center">
            <c:if test="${page != 1}">
                <a class="page-item" href="manageSlider?page=${page-1}">Previous</a>
            </c:if> 	
            <c:forEach begin="1" end="${numberpage}" var="i">
                <a class="${page==i?"page-item activee":""}" style="${page==i?"background-color:black; color: white; font-size: 22px; float: left; padding: 8px 16px; text-decoration: none;":""}" 
                   href="manageSlider?page=${i}" class="page-link">${i}</a>  
            </c:forEach>
            <c:if test="${page < numberpage}">
                <a class="page-item" href="manageSlider?page=${page+1 }" class="page-link">Next</a>
            </c:if> 
        </ul>
    </div>
</body>
</html>

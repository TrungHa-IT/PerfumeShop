<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<div class="navigation" style="left:0;">
    <ul style="padding: 0;">
        <li>
            <div style="display: flex; margin: 10px;">
                <span class="icon">
    
                </span>
                <span class="title">The Perfume<span class="shop-text">Shop</span></span>
            </div>
        </li>



        <c:if test="${sessionScope.role == 2}">
            <li>
                <a href="../admin/home">
                    <span class="icon">
                        <ion-icon name="bar-chart"></ion-icon>
                    </span>
                    <span class="title">Order Pending</span>
                </a>
            </li>
        </c:if>

        <c:if test="${sessionScope.role == 2}">
            <li>
                <a href="../sale/manageOrder">
                    <span class="icon">
                        <ion-icon name="cart"></ion-icon>
                    </span>
                    <span class="title">Orders</span>
                </a>
            </li>
        </c:if>





        <c:if test="${sessionScope.role == 3}">
            <li>

                <a href="marketing-manager-products">

                    <span class="icon">
                        <ion-icon name="archive"></ion-icon>
                    </span>
                    <span class="title">Products</span>
                </a>
            </li>
        </c:if>

        <c:if test="${sessionScope.role == 3}">
            <li>
                <a href="../admin/FeedbackList">
                    <span class="icon">
                        <ion-icon name="chatbubble"></ion-icon>
                    </span>
                    <span class="title">Feedbacks</span>
                </a>
            </li>
        </c:if>


        <c:if test="${sessionScope.role == 3}">
            <li>
                <a href="manage-slider">
                    <span class="icon">
                        <ion-icon name="tablet-landscape"></ion-icon>
                    </span>
                    <span class="title">Sliders</span>
                </a>
            </li>
        </c:if>


        <c:if test="${sessionScope.role == 1}">

            <li>
                <a href="admincontrolaccount?roleId=3">
                    <span class="icon">
                        <ion-icon name="people"></ion-icon>
                    </span>
                    <span class="title">Marketing</span>
                </a>
            </li>

        </c:if>
        <c:if test="${sessionScope.role == 1}">

            <li>
                <a href="admincontrolaccount?roleId=2">
                    <span class="icon">
                        <ion-icon name="people"></ion-icon>
                    </span>
                    <span class="title">Sale</span>
                </a>
            </li>
        </c:if>

        <c:if test="${sessionScope.role == 1}">
            <li>
                <a href="admincontrolaccount?roleId=4">
                    <span class="icon">
                        <ion-icon name="people"></ion-icon>
                    </span>
                    <span class="title">Customer</span>
                </a>
            </li>
        </c:if>
            <li>
                <a href="adminprofile?roleId=1">
                    <span class="icon">
                        <ion-icon name="person"></ion-icon>
                    </span>
                    <span class="title">My Profile</span>
                </a>
            </li>
            <c:if test="${sessionScope.role == 3}">
            <li>
                <a href="brand?brandID=1">
                    <span class="icon">
                        <ion-icon name="person"></ion-icon>
                    </span>
                    <span class="title">Manage Brand</span>
                </a>
            </li>
        </c:if>
        <li>
            <a href="${pageContext.request.contextPath}/common/login.jsp">
                <span class="icon">
                    <ion-icon name="log-out"></ion-icon>
                </span>
                <span class="title">Sign Out</span>
            </a>
        </li>
    </ul>
</div>
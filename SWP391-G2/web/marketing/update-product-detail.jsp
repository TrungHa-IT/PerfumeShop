<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product | The Perfume Shop</title>
        <link rel="icon" type="image/x-icon" href="img/logo.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <!-- Include Bootstrap CSS via CDN link -->
        <!-- ======= Styles ====== -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin_manager.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            .image-preview-container {
                display: flex;
                align-items: center;
            }
            .error {
                color: red;
            }
            .image-preview {
                width: 60%; /* Đặt kích thước hiển thị ảnh */
                height: auto; /* Đảm bảo tỷ lệ khung hình bảo toàn */
                border: 1px solid #ccc; /* Đường viền để phân biệt vùng ảnh */
            }
        </style>

    </head>

    <body>
        <div class="container-fluid">
            <!-- Navigation -->
            <jsp:include page="../partials/navigation.jsp"></jsp:include>
                <div class="topbar">
                </div>
                <!-- Main Content -->
                <div class="main" style="margin-left: 50px; margin-right: 50px;">
                    <div class="topbar mb-2">
                        <li style="list-style-type: none" class="breadcrumb-item"><a class="link-offset-2 fs-6 link-dark" href="./product-detail?proId=${proId}&cateId=${cateId}"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8"/>
                            </svg>Previous page</a></li>
                </div>
                <!--profile of product-->
                <div class="row mb-5" style="margin-right: 70px;  padding: 10px; border: 1.5px solid #000;">
                    <div class="col-12" style="margin-bottom: 40px;">
                        <h1>Product #${detail.getProductFullDetailID()}</h1>

                        <c:if test="${param.error != null}">
                            <h6 style="color: red;">In-valid information to add new customer!</h6>
                        </c:if>
                    </div>
                    <form action="update-product-detail" id="productForm" method="post" >
                        <input type="text" value="${proId}" name="proId"  hidden="">
                        <input type="text" value="${cateId}" name="cateId" hidden="">
                        <input type="text" value="${detail.getProductFullDetailID()}" name="detailId" hidden="">
                        <!-- Product image -->
                        <div class="form-group row">
                            <label for="productID">Product image:</label>
                            <input id="a" name="ima" hidden="" value="${detail.getImage()}" type="text">
                            <div class="input-group image-preview-container">
                                <div class="input-group">
                                    <input type="file" name="img" value="${detail.getImage()}" class="form-control d-none image-preview" id="img" onchange="chooseFile(this)" accept="image/*" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
                                    <label for="img"><img src="${detail.getImage()}" id="image" class="img-thumbnail rounded-5 image-preview" width="100%" alt="product image"></label>
                                </div>
                                <span class="error" id="imageError"></span>
                            </div>
                        </div>
                        <!-- Product Name -->
                        <div class="form-group row">
                            <div class="col-10">  
                                <label for="detail">Product Detail:</label>
                                <textarea name="detail" id="detail"  class="form-control" aria-label="With textarea">${detail.getProductDescription()}</textarea>
                                <span class="error" id="detailError"></span>
                            </div>
                        </div>
                        <!-- Other fields (Category, Brands, Status) -->
                        <div class="form-group row d-flex col-10 justify-content-between">
                            <div class="col-3">
                                <div class="d-flex justify-content-around align-items-center">
                                    Price:
                                    <input type="text"  name="price" value="${detail.getProductPrice()}" class="ms-2 form-control" id="price">     
                                </div>
                                <span class="error" id="priceError"></span>
                            </div>
                            <div class="col-3">
                                <div class="d-flex justify-content-around align-items-center">
                                    Quantity:
                                    <input type="number" name="quantity" value="${detail.getProductAvaiable()}" class="ms-2 form-control" id="quantity">
                                </div>
                                <span class="error" id="quantityError"></span>
                            </div>

                            <div class="col-3 d-flex justify-content-around align-items-center">
                                Size:
                                <select class="form-control ms-2" id="size" name="size" >
                                    <option value="30ml" >30ml</option>
                                    <option value="50ml" >50ml</option>
                                    <option value="100ml">100ml</option>
                                </select>
                            </div>
                            <div class="col-3 d-flex justify-content-around align-items-center">
                                Status: 
                                <select class="form-control ms-2"  id="status" name="status" >
                                    <option value="1" ${product.proStatus==1 ? 'selected' : '' }>View</option>
                                    <option value="0" ${product.proStatus==0 ? 'selected' : '' }>Hide</option>
                                </select>
                            </div>
                        </div>

                        <!-- Submit and Cancel buttons -->
                        <div class="d-flex justify-content-end">
                            <a class="btn btn-danger ps-2 mx-2" href="../SWP391-G2/product-detail?proId=${proId}&cateId=${cateId}">Cancel</a>
                            <button type="submit" class="btn btn-primary ps-2" onclick="validateForm()">Update</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>


    <!-- =========== Scripts =========  -->
    <script src="js/admin_manager.js"></script>
    <script src="https://www.gstatic.com/firebasejs/6.0.2/firebase.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
    crossorigin="anonymous"></script>
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
                                function validateForm() {
                                    let isValid = true;

                                    // Image validation
                                    const img = document.getElementById('img').files;

                                    // Detail validation
                                    const detail = document.getElementById('detail').value.trim();
                                    const detailError = document.getElementById('detailError');
                                    if (detail.length < 20 || detail.length > 10000 || !/^(?!\s*$).{20,9999}$/.test(detail)) {
                                        detailError.textContent = 'Detail must be between 20 and 10000 characters and cannot be all whitespace';
                                        isValid = false;
                                    } else {
                                        detailError.textContent = '';
                                    }

                                    // Price validation
                                    const price = document.getElementById('price').value;
                                    const priceError = document.getElementById('priceError');
                                    if (price === '' || isNaN(price) || parseFloat(price) <= 0 || parseFloat(price) >= 10000000) {
                                        priceError.textContent = 'Price must be a number greater than 0 and less than 10,000,000';
                                        isValid = false;
                                    } else {
                                        priceError.textContent = '';
                                    }

                                    // Quantity validation
                                    const quantity = document.getElementById('quantity').value;
                                    const quantityError = document.getElementById('quantityError');
                                    if (quantity === '' || isNaN(quantity) || parseInt(quantity) <= 0 || parseInt(quantity) >= 1000 || !Number.isInteger(parseFloat(quantity))) {
                                        quantityError.textContent = 'Quantity must be an integer greater than 0 and less than 1000';
                                        isValid = false;
                                    } else {
                                        quantityError.textContent = '';
                                    }

                                    return isValid;
                                }

                                function chooseFile(input) {
                                    const file = input.files[0];
                                    if (file) {
                                        const reader = new FileReader();
                                        reader.onload = function (e) {
                                            document.getElementById('image').src = e.target.result;
                                            const img = document.getElementById('img').files;
                                            imageError.textContent = '';
                                            uploadImage();
                                        };
                                        uploadImage();
                                        reader.readAsDataURL(file);
                                    }
                                }
                                document.getElementById('productForm').addEventListener('submit', function (event) {
                                    if (!validateForm()) {
                                        event.preventDefault(); // Prevent form submission if validation fails
                                    }
                                    uploadImage();
                                });

                                const firebaseConfig = {
                                    apiKey: "AIzaSyA007R8TopzTXZxWH9Bip3XtGxoSgql7XI",
                                    authDomain: "swp391-g2-72cbb.firebaseapp.com",
                                    projectId: "swp391-g2-72cbb",
                                    storageBucket: "swp391-g2-72cbb.appspot.com",
                                    messagingSenderId: "1066037353813",
                                    appId: "1:1066037353813:web:2deb0838eaeb48add1e3dc",
                                    measurementId: "G-Z6QYLR7ZC8"
                                };

// Initialize Firebase
                                firebase.initializeApp(firebaseConfig);
                                function uploadImage() {


                                    const ref = firebase.storage().ref('image/');
                                    const file = document.querySelector('#img').files[0];
                                    const metadata = {
                                        contentType: file.type
                                    };
                                    const name = file.name;
                                    const uploadIMG = ref.child(name).put(file, metadata);
                                    uploadIMG.snapshot.ref.getDownloadURL().then((url) => {
                                        if (url != null) {
                                            document.getElementById('a').setAttribute('value', url);


                                        }
                                        ;
                                    })
                                }
    </script>

</html>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Product | The Perfume Shop</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <!-- Include Bootstrap CSS via CDN link -->
        <!-- ======= Styles ====== -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin_manager.css">

        <style>
            .image-preview-container {
                display: flex;
                align-items: center;
            }

            .image-preview {
                width: 20%; /* Đặt kích thước hiển thị ảnh */
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
                        <li style="list-style-type: none" class="breadcrumb-item"><a class="link-offset-2 fs-6 link-dark" href="./marketing-manager-products"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8"/>
                                </svg>Previous page</a></li>
                    </div>

                    <div class="row" style="margin-right: 70px;  padding: 10px; border: 1.5px solid #000;">
                        <input type="hidden" id="pageNo" name="pageNo" value="${currentPage}">
                    <div class="col-12" style="margin-bottom: 40px;">
                        <h1>Product #${productId}</h1>
                    </div>
                    <form action="add-new-product" id="yourFormId" method="post" enctype="multipart/form-data">
                        <!-- Product image -->
                        <div class="form-group row">
                            <label for="productID">Product image:</label>
                            <div class="input-group image-preview-container">
                                <div class="input-group">
                                    <input id="a" name="ima" hidden="" type="text">
                                    <input type="file" name="img" class="form-control d-none image-preview" id="photo"
                                           onchange="chooseFile(this)" accept="image/*" aria-describedby="inputGroupFileAddon04"
                                           aria-label="Upload">
                                    <label for="photo"><img src="" id="image"
                                                            class="img-thumbnail rounded-5 image-preview" width="100%" alt="product image"></label>
                                </div>
                                <span id="imgError" class="text-danger"></span>
                            </div>
                        </div>
                        <!-- Product Name -->
                        <div class="form-group row">
                            <div class="col-10">  
                                <label for="productName">Product Name:</label>
                                <input type="text" class="form-control" id="productName"  name="productName">
                            </div>
                            <span id="productNameError" class="text-danger"></span>
                        </div>

                        <!-- Other fields (Category, Brands, Status) -->
                        <div class="form-group row ">
                            <div class="col-3 d-flex justify-content-around align-items-center">
                                Category:
                                <select class="form-control ms-2" id="cateId" name="cateId">
                                    <c:forEach  items="${listCate}" var="cate" >
                                        <option value="${cate.categoryID}" ${cate.categoryID == cateId ? 'selected' : '' }>${cate.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-3 d-flex justify-content-around align-items-center">
                                Brands: 
                                <select class="form-control ms-2" id="brandId" name="brandId">
                                    <c:forEach  items="${listBrands}" var="brand" >
                                        <option value="${brand.getBrandID()}" ${brandId==brand.getBrandID() ? 'selected' : '' } >${brand.getBrandName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-3 d-flex justify-content-around align-items-center">
                                Status: 
                                <select class="form-control ms-2" id="status" name="status" >
                                    <option value="1" ${product.proStatus==1 ? 'selected' : '' }>View</option>
                                    <option value="0" ${product.proStatus==0 ? 'selected' : '' }>Hide</option>
                                </select>
                            </div>
                        </div>

                        <!-- Submit and Cancel buttons -->
                        <div class="d-flex justify-content-end">
                            <a class="btn btn-danger  mx-2 border-secondary" href="../SWP391-G2/marketing-manager-products">Cancel</a>
                            <button type="submit" class="btn btn-primary" onclick="uploadImage()">Add new Product</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>


    <!-- =========== Scripts =========  -->
    <script src="js/admin_manager.js"></script>
    <!-- ====== ionicons ======= -->
    <script src="https://www.gstatic.com/firebasejs/6.0.2/firebase.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
    crossorigin="anonymous"></script>
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
    <script>// Validate Form Function
                                function validateForm() {
                                    var imgInput = document.getElementById('photo');
                                    var productNameInput = document.getElementById('productName');
                                    var productName = productNameInput.value.trim();

                                    var imgError = document.getElementById('imgError');
                                    var productNameError = document.getElementById('productNameError');
                                    var isValid = true;

                                    // Validate Image Input
                                    if (imgInput.files.length === 0) {
                                        imgError.textContent = 'Please choose an image.';
                                        isValid = false;
                                    } else {
                                        imgError.textContent = '';
                                    }

                                    // Validate Product Name
                                    if (productName === '') {
                                        productNameError.textContent = 'Product Name cannot be empty.';
                                        isValid = false;
                                    } else if (!/^(?!.*\d)(?!.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?])(?=.*\S)[A-Za-zÀ-ỹ\s]*$/.test(productName)) {
                                        productNameError.textContent = 'Product Name should not contain numbers, special characters, and cannot be all whitespace.';
                                        isValid = false;
                                    } else {
                                        productNameError.textContent = '';
                                    }

                                    return isValid;
                                }

// Function to handle form submission
                                function submitForm() {
                                    if (validateForm()) {
                                        // Form is valid, submit your form here
//                                        document.getElementById('yourFormId').submit(); // Replace 'yourFormId' with your actual form ID
                                    } else {
                                        // Form is not valid, do not submit
                                        alert('Please fill out the form correctly.');
                                    }
                                }

// Example onchange function for image preview (assuming you have one)
                                function chooseFile(input) {
                                    if (input.files && input.files[0]) {
                                        var reader = new FileReader();

                                        reader.onload = function (e) {
                                            $('#image').attr('src', e.target.result);
                                            imgError.textContent = '';
                                        };
                                        uploadImage();
                                        reader.readAsDataURL(input.files[0]);
                                    }
                                }

// Example: Attach validation to form submission event
                                document.getElementById('yourFormId').addEventListener('submit', function (event) {
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
                                    const file = document.querySelector('#photo').files[0];
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
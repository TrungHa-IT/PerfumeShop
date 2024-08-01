<%-- 
    Document   : feedbackProduct
    Created on : Jun 16, 2024, 1:51:07 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Form Nhập Feedback Khách Hàng</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <style>
        .star-rating {
            font-size: 0;
            display: flex;
            flex-direction: row-reverse; /* Đảo ngược thứ tự từ trái sang phải */
            justify-content: flex-end; /* Canh phải */
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            font-size: 2rem;
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s;
        }
        .star-rating input:checked ~ label,
        .star-rating input:checked ~ label ~ label {
            color: #ffca08;
        }
        .star-rating input:not(:checked) ~ label:hover,
        .star-rating input:checked ~ label:hover,
        .star-rating input:checked ~ label:hover ~ label {
            color: #ffca08;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Form Feedback </h2>
        <form id="feedbackForm" action="feedbackproduct" method="post" class="mt-4" enctype="multipart/form-data">
            <div class="form-group">
                <label for="feedback">Content feedback:</label>
                <textarea class="form-control" id="feedback" name="content" rows="4" required></textarea>
                <div id="descriptionError" class="error-message"></div>
            </div>
            <div class="form-group">
                <label for="rating">Number of stars:</label>
                <div class="star-rating">
                    <input type="radio" id="star5" name="rating" value="5"><label for="star5" class="fas fa-star"></label>
                    <input type="radio" id="star4" name="rating" value="4"><label for="star4" class="fas fa-star"></label>
                    <input type="radio" id="star3" name="rating" value="3"><label for="star3" class="fas fa-star"></label>
                    <input type="radio" id="star2" name="rating" value="2"><label for="star2" class="fas fa-star"></label>
                    <input type="radio" id="star1" name="rating" value="1"><label for="star1" class="fas fa-star"></label>
                </div>
            </div>
            <div class="form-group">
                <label for="image">Picture:</label>
                <input type="file" id="image" name="photo" accept="image/*">
            </div>
            <button type="submit" class="btn btn-primary">Send Feedback</button>
        </form>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script>
        function checkProfanity(text) {
            // Danh sách các từ tục tĩu cần kiểm tra
            const profaneWords = ['badword1', 'badword2', 'badword3']; // Thay thế bằng danh sách thực tế

            // Chuyển đổi đoạn văn bản thành chữ thường để so sánh không phân biệt hoa thường
            const lowerCaseText = text.toLowerCase();

            // Kiểm tra từng từ trong danh sách từ tục tĩu
            for (let word of profaneWords) {
                if (lowerCaseText.includes(word)) {
                    return true; // Nếu tìm thấy từ tục tĩu, trả về true
                }
            }

            return false; // Nếu không tìm thấy từ tục tĩu, trả về false
        }

        // Xử lý sự kiện submit form
        document.getElementById('feedbackForm').addEventListener('submit', function(event) {
            // Ngăn chặn hành động mặc định của form (gửi đi và tải lại trang)
            event.preventDefault();

            // Lấy giá trị của ô nhập feedback
            const feedbackText = document.getElementById('feedback').value;

            // Kiểm tra xem có từ tục tĩu không
            if (checkProfanity(feedbackText)) {
                // Nếu có từ tục tĩu, thông báo và không gửi form
                alert('Nội dung feedback chứa từ tục tĩu. Vui lòng sửa lại.');
            } else {
                // Nếu không có từ tục tĩu, gửi form (có thể thêm xử lý AJAX ở đây)
                this.submit();
            }
        });
    </script>
</body>
</html>

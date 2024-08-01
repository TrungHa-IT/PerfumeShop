<%-- 
    Document   : marketing-manage-sliderDetail
    Created on : 25 thg 6, 2024, 10:10:07
    Author     : pna29
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/admin.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <style>
            img{
                width: 200px;
                height: 120px;
            }

            select {
                width: 32.3%;
                margin: 0;
                font-size: 100%;
                padding: 5px 10px 5px 10px;
                font-family: Segoe UI, Helvetica, sans-serif;
                border: 1px solid #D0D0D0;
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
                border-radius: 20px;
                outline: none;
            }

        </style>
    </head>
    <body>
        <div class="container justify-content-center" style="width: 500px">      
            <div id="editEmployeeModal">
                <div class="modal-dialog" style="width: 100%">
                    <div class="modal-content">
                        <form id="form" class="table-responsive" action="./sliderDetails" method="post" enctype="multipart/form-data">
                            <div class="modal-header">						
                                <h4 class="modal-title">Edit Product</h4>
                                <a href="manageSlider">
                                    <button style="position: absolute; right: 20px; top: 20px; color: black" type="button" class="close" data-dismiss="modal" 
                                            aria-hidden="true">&times;
                                    </button> 
                                </a>
                            </div>
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label>ID</label> 
                                    <input value="${slider.getSliderID()}" name="id" type="text" class="form-control" readonly required>
                                </div> 
                                <div class="form-group">
                                    <label>Slider Title</label>
                                    <textarea name="title" class="form-control" required rows="3" cols="50">${slider.sliderTitle}</textarea>
                                </div>
                                <div class="form-group">
                                    <label for="status">Status:</label>
                                    <select class="form-control" id="status" name="status">
                                        <option value="1" ${slider.sliderStatus == 1 ? 'selected' : ''}>Unblock</option>
                                        <option value="0" ${slider.sliderStatus == 0 ? 'selected' : ''}>Block</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="image">Picture Product:</label>
                                    <div class="image-preview-container">
                                        <img id="previewImage" class="image-preview" src="${slider.sliderImage}" alt="Preview Image"/>
                                        <div class="file-input">
                                            <input type="file" name="image" id="image" onchange="updatePreview(event)">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="hidden" id="stringdateolb" value="${slider.updateAt}">
                                    <label style="margin-bottom: 10px; width: 100%">Update At:</label>
                                    <input type="hidden" name="date" value="" id="here"/>
                                    <select class="bear-dates" id="dobDay"></select>
                                    <select class="bear-months" id="dobMonth"></select>
                                    <select class="bear-years" id="dobYear"></select>
                                </div>                                                                                                             
                            </div>
                            <div class="modal-footer">
                                <a href="manageSlider"><button type="button" class="btn btn-secondary" >Close</button></a>
                                <input type="submit" class="btn btn-success" value="Edit">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

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
        <script src="js/main.js"></script>
        <script src="js/clickevents.js"></script>
        <script src="js/calender.js"></script>
        <script  type="text/javascript">
                                                function addOption(selectElement, value, text) {
                                                    var option = document.createElement("option");
                                                    option.value = value;
                                                    option.text = text;
                                                    selectElement.add(option);
                                                }

                                                var defaultReleaseDate = document.getElementById("stringdateolb").value;
                                                var defaultDateArray = defaultReleaseDate.split('-');
                                                var defaultDay = parseInt(defaultDateArray[2]);
                                                var defaultMonth = parseInt(defaultDateArray[1]);
                                                var defaultYear = parseInt(defaultDateArray[0]);

                                                var daysSelect = document.getElementById('dobDay');
                                                var monthsSelect = document.getElementById('dobMonth');
                                                var yearsSelect = document.getElementById('dobYear');

                                                for (var day = 1; day <= 31; day++) {
                                                    addOption(daysSelect, day, day);
                                                }

                                                for (var month = 1; month <= 12; month++) {
                                                    addOption(monthsSelect, month, month);
                                                }

                                                var currentYear = new Date().getFullYear();
                                                for (var year = currentYear; year >= 1900; year--) {
                                                    addOption(yearsSelect, year, year);
                                                }

                                                daysSelect.value = defaultDay;
                                                monthsSelect.value = defaultMonth;
                                                yearsSelect.value = defaultYear;
                                                function submitForm() {
                                                    var here = document.querySelector('#here');
                                                    var form = document.getElementById('form');
                                                    var dobDay = document.getElementById('dobDay').value;
                                                    var dobMonthText = document.getElementById('dobMonth').value;
                                                    var dobMonth = monthNameToNumber(dobMonthText);
                                                    var dobYear = document.getElementById('dobYear').value;
                                                    if (dobMonth < 10 && dobDay < 10) {
                                                        dobFull = dobYear + '-0' + dobMonth + '-0' + dobDay;
                                                    } else if (dobMonth < 10 && !(dobDay < 10)) {
                                                        dobFull = dobYear + '-0' + dobMonth + '-' + dobDay;
                                                    } else if (dobDay < 10 && !(dobMonth < 10)) {
                                                        dobFull = dobYear + '-' + dobMonth + '-0' + dobDay;
                                                    } else {
                                                        dobFull = dobYear + '-' + dobMonth + '-' + dobDay;
                                                    }

                                                    here.value = dobFull;
                                                    form.submit();
                                                }
        </script>
        <script>
            function updatePreview(event) {
                var input = event.target;
                var reader = new FileReader();

                reader.onload = function () {
                    var imgElement = document.getElementById('previewImage');
                    imgElement.src = reader.result;
                }

                reader.readAsDataURL(input.files[0]);
            }

        </script>
    </body>
</html>

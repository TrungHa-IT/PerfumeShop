<%-- 
    Document   : addressdetail
    Created on : Jun 22, 2024, 7:50:48 PM
    Author     : ROG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <style type="text/css">
        .css_select_div{
            text-align: center;
        }
        .css_select{
            display: inline-table;
            width: 25%;
            padding: 5px;
            margin: 5px 2%;
            border: solid 1px #686868;
            border-radius: 5px;
        }
    </style>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Your Address</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center mb-4">Create Your Address</h2>
            <form method="POST" action="./AddressDetail">
                <div class="form-group">
                    <label for="soDienThoai">Phone Number</label>
                    <input type="text" class="form-control" id="Phone" name="phone" value="" required>
                    <a>${mess}</a>
                </div>
                <div>
                    <input type="text" id="c" name="city" hidden="">
                    <select class="form-select form-select-sm mb-3" id="city"  aria-label=".form-select-sm">
                        <option value="" selected>Select City(Province)</option>           
                    </select>
                    <input type="text" id="d" name="district" hidden="">
                    <select class="form-select form-select-sm mb-3" id="district" aria-label=".form-select-sm">
                        <option value="" selected>Select District</option>
                    </select>
                    <input type="text" id="w" name="ward" hidden="">
                    <select class="form-select form-select-sm" id="ward" name="ward" aria-label=".form-select-sm">
                        <option value="" selected>Select Wards</option>
                    </select>
                </div> 
                <div class="form-group">
                    <label for="diaChi">Home Address</label>
                    <input type="text" class="form-control" id="diaChinha" name="homeaddress" required>
                </div>
                <div class="form-group form-check">
                    <div>
                        <input type="checkbox" id="status" name="status">
                        <label for="status">Set as default address</label><br>
                    </div>
                </div>


                <button type="submit" name="save" class="btn btn-primary">Add Address</button>
                <div class="mt-5 text-center"> <a class="nav-link" href="./AddressMain">Back To Manager Address</a></div>
            </form>
        </div>
    </body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
    <script>
        var citis = document.getElementById("city");
        var districts = document.getElementById("district");
        var wards = document.getElementById("ward");
        var addressInput = document.getElementById("diaChi");

        var Parameter = {
            url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
            method: "GET",
            responseType: "application/json",
        };

        var promise = axios(Parameter);
        promise.then(function (result) {
            renderCity(result.data);
        });

        function renderCity(data) {
            for (const x of data) {
                citis.options[citis.options.length] = new Option(x.Name, x.Id);
            }

            citis.onchange = function () {
                districts.length = 1;
                wards.length = 1;
                if (this.value != "") {
                    const result = data.filter(n => n.Id === this.value);
                    for (const k of result[0].Districts) {
                        districts.options[districts.options.length] = new Option(k.Name, k.Id);
                    }
                }
                const city = citis.options[citis.selectedIndex].text;
                document.getElementById('c').setAttribute('value', city);

            };

            districts.onchange = function () {
                wards.length = 1;
                const dataCity = data.filter((n) => n.Id === citis.value);
                if (this.value != "") {
                    const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;
                    for (const w of dataWards) {
                        wards.options[wards.options.length] = new Option(w.Name, w.Id);
                    }
                }
                const district = districts.options[districts.selectedIndex]?.text || "";
                document.getElementById('d').setAttribute('value', district);

            };

            wards.onchange = function () {
                const ward = wards.options[wards.selectedIndex]?.text || "";
                document.getElementById('w').setAttribute('value', ward);
                updateAddress();
            };
        }


    </script>
</html>
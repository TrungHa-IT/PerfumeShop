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
        <title>Edit Your Address</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center mb-4">Edit Your Address</h2>
            <form method="POST" action="./EditAddress">
                <input name="address_id" value="${address_id}" hidden="">
                <div class="form-group">
                    <label for="soDienThoai">Phone Number </label>
                    <input type="tel" class="form-control" id="Phone" name="phone" value="${address.phone}"required>
                    <a>${mess}</a>
                </div>
                <div>
                    <input type="text" id="c" name="city" value="${defaultCity}" hidden="">
                    <select class="form-select form-select-sm mb-3" id="city"  aria-label=".form-select-sm">
                        <option value="" selected>Select City(Province)</option>         
                    </select>
                    <input type="text" id="d" name="district" value="${defaultDistrict}" hidden="">
                    <select class="form-select form-select-sm mb-3" id="district" aria-label=".form-select-sm">
                        <option value="" selected>Select District</option>
                    </select>
                    <input type="text" id="w" name="wards" value="${defaultWard}" hidden="">
                    <select class="form-select form-select-sm" id="ward" aria-label=".form-select-sm" >
                        <option value="" selected>Select wards</option>
                    </select>
                </div> 
                <div class="form-group">
                    <label for="diaChi">Address Line </label>
                    <input type="text" class="form-control" id="diaChinha" name="homeaddress" value="${address.addressLine}" required>
                </div>
                <div class="form-group form-check">
                    <div>
                        <input type="checkbox" id="status" name="status" ${address.status==1?"checked":""} value="${address.status==1?"1":"0"}">
                        <label for="status">Set as default address</label><br>
                    </div>
                </div>


                <button type="submit" name="save" class="btn btn-primary">Edit</button>
                <div class="mt-5 text-center"> <a class="nav-link" href="./AddressMain">Back To Manager Address</a></div>
            </form>
        </div>

<!--        <h1><%= request.getAttribute("defaultCity") %></h1>
        <h1><%= request.getAttribute("defaultDistrict") %></h1>-->
    </body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
    <script>
        // Gán giá trị từ JSP vào JavaScript
        var defaultCity = "<%= request.getAttribute("defaultCity") %>";
        var defaultDistrict = "<%= request.getAttribute("defaultDistrict") %>";
        var defaultWard = "<%= request.getAttribute("defaultWard") %>";

        var citis = document.getElementById("city");
        var districts = document.getElementById("district");
        var wards = document.getElementById("ward");

        // Fetch city, district, and ward data
        fetchAddressData();

        function fetchAddressData() {
            var Parameter = {
                url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                method: "GET",
                responseType: "application/json",
            };

            axios(Parameter).then(function (result) {
                renderCity(result.data);
                setDefaultSelections(result.data);  // Set default selections after data is fetched
            });
        }

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
                renderDistricts(data);
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
                renderWards(data);
            };
            wards.onchange = function () {
                const ward = wards.options[wards.selectedIndex]?.text || "";
                document.getElementById('w').setAttribute('value', ward);
                updateAddress();
            };
        }

        function renderDistricts(data) {
            districts.length = 1;  // Clear existing options except for the first one
            wards.length = 1;  // Clear existing options except for the first one

            if (citis.value != "") {
                const result = data.filter(n => n.Id === citis.value);

                for (const k of result[0].Districts) {
                    districts.options[districts.options.length] = new Option(k.Name, k.Id);
                }

                renderWards(data);
            }
        }

        function renderWards(data) {
            wards.length = 1;  // Clear existing options except for the first one

            if (districts.value != "") {
                const dataCity = data.filter((n) => n.Id === citis.value);
                const dataWards = dataCity[0].Districts.filter(n => n.Id === districts.value)[0].Wards;
                
                for (const w of dataWards) {
                    wards.options[wards.options.length] = new Option(w.Name, w.Id);
                }
            }
        }

        function setDefaultSelections(data) {
            // Set default city
            citis.value = data.find(city => city.Name === defaultCity)?.Id || "";
            renderDistricts(data);

            // Set default district
            const selectedCity = data.find(city => city.Name === defaultCity);
            if (selectedCity) {
                districts.value = selectedCity.Districts.find(district => district.Name === defaultDistrict)?.Id || "";
                renderWards(data);

                // Set default ward
                const selectedDistrict = selectedCity.Districts.find(district => district.Name === defaultDistrict);
                if (selectedDistrict) {
                    wards.value = selectedDistrict.Wards.find(ward => ward.Name === defaultWard)?.Id || "";
                }
            }
        }
    </script>
</html>
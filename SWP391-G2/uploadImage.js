
/*
thêm cái này vào trong jsp 

<script src="https://www.gstatic.com/firebasejs/6.0.2/firebase.js"></script>
<script src="./uploadImage.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
    integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
    crossorigin="anonymous"></script>
  
    cái này là đề mô save ảnh
    <button type="button" onclick="uploadImage('photo')">save</button>
*/


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

function chooseFile(fileInput) {
  if (fileInput.files && fileInput.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#image').attr('src', e.target.result);
    }
    reader.readAsDataURL(fileInput.files[0]);
  }
}

function uploadImage(folder) {
  const filename = '1.png';
  const ref = firebase.storage().ref(folder + '/');
  const file = document.querySelector('#photo').files[0];
  const metadata = {
    contentType: file.type
  };
  const name = file.name;
  const uploadIMG = ref.child(filename).put(file, metadata);
  uploadIMG.snapshot.ref.getDownloadURL().then((url) => {
    if (url != null) {
      document.getElementById('photo').setAttribute('value', url);
    };
  })
}
// đây là phần coppy không để khải để gọi 

// đây là cái để loading
function loading() {
    let timerInterval;
    Swal.fire({
      title: "Loading...",
      didOpen: () => {
        Swal.showLoading();
       
      },
      willClose: () => {
      
      }
    }).then((result) => {
     
    });
}
// nhét cái loading này vào trước cái submit hay cái chuyển sang servlet gì đấy

//hàm này để confirm changestatus
function không_gọi_hàm_này() {
    Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, change it!"
    }).then((result) => {
        if (result.isConfirmed) {
            //điền phần confirm đúng sẽ làm vào đây
        }
    });
}


//từ đây đi thì gọi hàm được
function successfully(text) {
    let timerInterval;
    Swal.fire({
        title: text,
        icon: "success",
        showConfirmButton: false,
        timer: 1500,
        timerProgressBar: true,
        didOpen: () => {
            const timer = Swal.getPopup().querySelector("b");
            timerInterval = setInterval(() => {
              
            }, 100);
        },
        willClose: () => {
            clearInterval(timerInterval);
        }
    }).then((result) => {
    });
}

function errors(text) {
    let timerInterval;
    Swal.fire({
        title: text,
        icon: "error",
        showConfirmButton: false,
        timer: 2000,
        timerProgressBar: true,
        didOpen: () => {
            const timer = Swal.getPopup().querySelector("b");
            timerInterval = setInterval(() => {
               
            }, 100);
        },
        willClose: () => {
            clearInterval(timerInterval);
        }
    }).then((result) => {
    });
}


function confirmLogout(modalID) {
let modalElement = document.getElementById(modalID);
        let modal = `
<div class="modal-dialog modal-dialog-centered" role="document" style="text-align:center">
    <div class="modal-content" style="width:500px; margin: 0 auto">
      <div class="modal-header ani-fire" style="font-size:28px;padding: 30px 0; font-weight: 600; margin: 0 auto"><div>Logout</div></div>
      <div class="modal-body" style="font-size: 16px; font-weight: 600; color: red" >Are you sure you want to LOGOUT of your account ?</div>
        <div class="modal-footer" style="justify-content: center;">
            <div style="width:40%; background-color: white"><a style="background-color: #f44336!important; color: while; border-color: black; font-weight : bold; padding-top: 6px" class="btn btn-primary btn-block" href="logout">Logout</a></div>
            <div style="width:40%"><button onclick="closeModal('${modalID}')" style="font-weight : bold" class="btn btn-primary btn-block">Cancel</button></div>
        </div>
    </div>
</div>`;
        modalElement.innerHTML = modal;
        modalElement.style.display = 'block';
        }

function closeModal(modalID) {
let modalElement = document.getElementById(modalID);
        modalElement.style.display = 'none';
        }

// Close the modal if the user clicks anywhere outside of it
window.onclick = function(event) {
const modal = document.getElementById('logoutModal');
        if (event.target == modal) {
modal.style.display = 'none';
        }
}

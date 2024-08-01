<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header text-center">
                            <h3>Change Password</h3>
                        </div>
                        <div class="card-body">
                            <form method="Post" action="ForgotPassword">
                                <div class="form-group">
                                   
                                </div>
                                <div class="form-group">
                                    <label for="new-password">New Password</label>
                                    <input required="" name="newpass" type="password" class="form-control" id="new-password" placeholder="Enter your new password">
                                    <a style="color: red>${mess1}"></a>
                                </div>
                                <div class="form-group">
                                    <label for="confirm-password">Confirm New Password</label>
                                    <input required="" name="confirmpass" type="password" class="form-control" id="confirm-password" placeholder="Confirm your new password">
                                    <a style="color: red>${mess2}"></a>
                                </div>
                                <button name="save" type="submit"  class="btn btn-dark btn-block">Change Password</button>
                            </form>
                                 <ul type="none" class="text-start pe-3 requiement-list">
                                    <p>Password must contains</p>
                                    <li>
                                        At least 8 characters length
                                    </li>
                                    <li>At least 1 number (0..9)</li>
                                    <li>At least 1 lowercase letter (a..z)</li>
                                    <li>At least 1 special symbol (!..$)</li>
                                    <li>At least 1 uppercase letter (A..Z)</li>
                                </ul>
                        </div>
                        <div class="card-footer text-muted text-center">
                            <a href="./Profile">Back to Profile</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>

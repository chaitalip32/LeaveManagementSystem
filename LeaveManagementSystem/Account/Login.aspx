<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LeaveManagementSystem.Account.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Leave Management System</title>

    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content="Employee Leave Management System Login Page"/>
    <meta name="author" content="Chaitali Pednekar"/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="container">
        <div class="row justify-content-center align-items-center vh-100">
            <div class="col-12 col-sm-8 col-md-6 col-lg-4"> 
                
                <div class="card shadow p-4">
                    <h3 class="text-center mb-4">Login</h3>

                    <!--Error Message label-->
                    <asp:Label ID="lblMessage" 
                        runat="server" 
                        CssClass="alert alert-danger text-center" 
                        Visible="false">
                    </asp:Label>

                    <!-- Email -->
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <asp:TextBox ID="txtEmail" 
                            runat="server" 
                            CssClass="form-control">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator 
                            ID="rfvEmail"
                            runat="server"
                            ErrorMessage="Email Required"
                            ControlToValidate="txtEmail"
                            CssClass="text-danger">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator 
                            ID="revEmail" 
                            runat="server"
                            ControlToValidate="txtEmail" 
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            ErrorMessage="Invalid Email Format"
                            CssClass="text-danger">
                        </asp:RegularExpressionValidator>
                    </div>

                    <!-- Password -->
                    <div class="mb-3 position-relative">
                        <label class="form-label">Password</label>
                            <asp:TextBox ID="txtPassword" 
                                runat="server" 
                                TextMode="Password"
                                ClientIdMode="Static"
                                CssClass="form-control">
                            </asp:TextBox>

                            <!-- Eye Icon -->
                            <i id="toggleIcon"
                               class="bi bi-eye position-absolute"
                               style="top: 38px; right: 15px; cursor: pointer; font-size: 18px;"
                               onclick="togglePassword()">
                            </i>

                            <div class="text-end mb-3">
                                <a href="ForgotPassword.aspx">Forgot Password</a>
                            </div>
                        <asp:RequiredFieldValidator 
                            ID="rfvPassword"
                            runat="server"
                            ErrorMessage="Password Required"
                            ControlToValidate="txtPassword"
                            CssClass="text-danger">
                        </asp:RequiredFieldValidator>
                    </div>

                    

                    <!-- Button -->
                    <div class="d-grid">
                        <asp:Button ID="btnLogin" 
                            runat="server" 
                            Text="Login"           
                            OnClick="btnLogin_Click"
                            CssClass="btn btn-success">
                        </asp:Button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <script>
        function togglePassword() {
            var passwordBox = document.getElementById("txtPassword");
            var icon = document.getElementById("toggleIcon");

            if (passwordBox.type === "password") {
                passwordBox.type = "text";
                icon.classList.remove("bi-eye");
                icon.classList.add("bi-eye-slash");
            } else {
                passwordBox.type = "password";
                icon.classList.remove("bi-eye-slash");
                icon.classList.add("bi-eye");
            }
        }
    </script>
</body> 
    
</html>

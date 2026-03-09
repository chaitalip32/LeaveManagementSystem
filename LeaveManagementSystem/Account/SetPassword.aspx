<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetPassword.aspx.cs" Inherits="LeaveManagementSystem.Account.SetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reset Password</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content="Employee Leave Management System Passoword Reset Page"/>
    <meta name="author" content="Chaitali Pednekar"/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="container">
        <div class="row justify-content-center align-items-center vh-100">
            <div class="col-12 col-md-6 col-sm-8 col-lg-4">

                <div class="card shadow p-4">

                    <h2 class="text-center mb-4">Change Password</h2>

                    <asp:Label ID="lblMessage" 
                    runat="server" 
                    CssClass="alert alert-danger text-center mb-3"
                    Visible="false"></asp:Label>

                    <div class="mb-3 position-relative">
                        <label class="form-label">Enter Password</label>
                        <asp:TextBox ID="txtPassword" 
                            runat="server"
                            Textmode="Password"
                            CssClass="form-control"></asp:TextBox>

                        <asp:RequiredFieldValidator 
                            ID="rfvPassword" 
                            runat="server" 
                            ErrorMessage="Password is required"
                            ControlToValidate="txtPassword"
                            CssClass="text-danger">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-3 position-relative">
                        <label class="form-label">Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" 
                               runat="server"
                               Textmode="Password"
                               CssClass="form-control"></asp:TextBox>   

                        <asp:RequiredFieldValidator 
                            ID="rfvConfirmPassword" 
                            runat="server" 
                            ControlToValidate="txtConfirmPassword"
                            ErrorMessage="Confirm Password is required"
                            CssClass="text-danger"></asp:RequiredFieldValidator> 

                        <asp:CompareValidator
                             ID="cvPassword" 
                            runat="server" 
                            ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtPassword"
                            ErrorMessage="Passowrd do not match"
                            CssClass="text-danger"></asp:CompareValidator>   
                            
                        <!-- Eye Icon -->
                        <i id="toggleIcon" class="bi bi-eye position-absolute"
                            style="top: 38px; right: 15px; cursor: pointer; font-size: 18px;"
                            onclick="togglePassword()">
                        </i>
                                
                    </div>

                    <div class="d-grid">
                        <asp:Button ID="btnResetPassword" 
                            runat="server" 
                            Text="Submit" 
                            CssClass="btn btn-success" OnClick="btnResetPassword_Click"
                            />
                    </div>

                </div>
            </div>

        </div>
    
    </div>
    </form>
</body>
    <script>
        function togglePassword() {
            var passwordBox = document.getElementById("<%= txtConfirmPassword.ClientID %>");
            var icon=document.getElementById("toggleIcon");

            if(passwordBox.type=="password")
            {
                passwordBox.type = "text";
                icon.classList.remove("bi-eye");
                icon.classList.add("bi-eye-slash");
            }
            else
            {
                passwordBox.type = "password";
                icon.classList.remove("bi-eye-slash");
                icon.classList.add("bi-eye");
            }
        }
    </script>
</html>

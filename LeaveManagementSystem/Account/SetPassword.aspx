<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetPassword.aspx.cs" Inherits="LeaveManagementSystem.Account.SetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Set New Password</title>

    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous" />
<style>

    body{
        background:#f5f6fa;
        height:100vh;
    }

    .reset-card{
        border-radius:15px;
        padding:40px;
    }

    .form-control{
        border:none;
        border-bottom:1px solid #ccc;
    }

    .form-control:focus{
        box-shadow:none;
        border-bottom:2px solid #0d6efd;
    }

    .title{
        font-weight:600;
        margin-bottom:30px;
    }

</style>

</head>

<body>

<form id="form1" runat="server">

    <div class="container d-flex align-items-center justify-content-center vh-100">

        <div class="card shadow-lg reset-card w-100" style="max-width:500px;">

            <h3 class="text-center title">Set New Password</h3>

            <!-- Validation Summary -->

            <asp:ValidationSummary
            ID="ValidationSummary1"
            runat="server"
            CssClass="alert alert-danger"
            HeaderText="Please fix the following errors:"
            DisplayMode="List" />

            <!-- Server Message -->

            <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="alert alert-danger text-center"
            Visible="false">
            </asp:Label>

            <!-- Password -->

            <div class="mb-4 position-relative">

            <i class="fa fa-lock position-absolute top-50 start-0 translate-middle-y text-muted"></i>

            <asp:TextBox
            ID="txtPassword"
            runat="server"
            TextMode="Password"
            ClientIDMode="Static"
            CssClass="form-control ps-4"
            placeholder="New Password">
            </asp:TextBox>

            <asp:RequiredFieldValidator
            ID="rfvPassword"
            runat="server"
            ControlToValidate="txtPassword"
            ErrorMessage="Password is required"
            Display="None">
            </asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator
            ID="revPassword"
            runat="server"
            ControlToValidate="txtPassword"
            ValidationExpression="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$"
            ErrorMessage="Password must be 8 characters with uppercase, lowercase and number"
            Display="None">
            </asp:RegularExpressionValidator>

            <i class="bi bi-eye position-absolute"
            style="top:38px; right:15px; cursor:pointer;"
            onclick="togglePassword('txtPassword', this)">
            </i>

            </div>

            <!-- Confirm Password -->

            <div class="mb-4 position-relative">

            <i class="fa fa-lock position-absolute top-50 start-0 translate-middle-y text-muted"></i>

            <asp:TextBox
            ID="txtConfirmPassword"
            runat="server"
            TextMode="Password"
            ClientIDMode="Static"
            CssClass="form-control ps-4"
            placeholder="Confirm Password">
            </asp:TextBox>

            <asp:RequiredFieldValidator
            ID="rfvConfirmPassword"
            runat="server"
            ControlToValidate="txtConfirmPassword"
            ErrorMessage="Confirm Password is required"
            Display="None">
            </asp:RequiredFieldValidator>

            <asp:CompareValidator
            ID="cvPassword"
            runat="server"
            ControlToValidate="txtConfirmPassword"
            ControlToCompare="txtPassword"
            ErrorMessage="Passwords do not match"
            Display="None">
            </asp:CompareValidator>

            <i class="bi bi-eye position-absolute"
            style="top:38px; right:15px; cursor:pointer;"
            onclick="togglePassword('txtConfirmPassword', this)">
            </i>

            </div>

            <!-- Button -->

            <div class="d-grid">

                <asp:Button
                ID="btnResetPassword"
                runat="server"
                Text="Update Password"
                CssClass="btn btn-primary btn-lg"
                OnClick="btnResetPassword_Click" />

            </div>

            <!-- Login Redirect -->

            <div class="text-center mt-3">

                <span>Remember your password?</span>

                <asp:HyperLink 
                    ID="hlLogin" 
                    runat="server"
                    NavigateUrl="~/Account/Login.aspx"
                    CssClass="text-decoration-none fw-bold text-primary">
                    Login Here
                </asp:HyperLink>

            </div>

    </div>

    </div>

</form>

<script>

    function togglePassword(fieldId, icon){

    var input = document.getElementById(fieldId);

    if(input.type === "password")
    {
        input.type = "text";
        icon.classList.remove("bi-eye");
        icon.classList.add("bi-eye-slash");
    }
    else
    {
        input.type = "password";
        icon.classList.remove("bi-eye-slash");
        icon.classList.add("bi-eye");
    }

    }

</script>

</body>
</html>
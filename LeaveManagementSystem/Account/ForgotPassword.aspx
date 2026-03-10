<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="LeaveManagementSystem.Account.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <style>

        body{
            background:#f5f6fa;
        }

        .card{
            border-radius:12px;
        }

        .form-control{
            border:none;
            border-bottom:1px solid #ccc;
            border-radius:0;
        }

        .form-control:focus{
            box-shadow:none;
            border-bottom:2px solid #0d6efd;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container d-flex align-items-center justify-content-center vh-100">

    <div class="col-md-4">

        <div class="card shadow-lg p-4">

            <h4 class="text-center mb-2">Forgot Password</h4>

            <p class="text-center text-muted small mb-4">
                Enter your email and we will send you a password reset link.
            </p>

            <!-- Message -->
            <asp:Label 
                ID="lblMessage" 
                runat="server" 
                Visible="false"
                CssClass="alert text-center mb-3">
            </asp:Label>

            <!-- Email Field -->
            <div class="mb-4 position-relative">

                <i class="fa fa-envelope position-absolute top-50 start-0 translate-middle-y text-muted"></i>

                <asp:TextBox 
                    ID="txtEmail" 
                    runat="server"
                    CssClass="form-control ps-4"
                    placeholder="Enter your email">
                </asp:TextBox>

            </div>

            <!-- Button -->
            <div class="d-grid mb-3">

                <asp:Button 
                    ID="btnSendLink" 
                    runat="server" 
                    Text="Send Reset Link"
                    CssClass="btn btn-primary btn-lg"
                    OnClick="btnSendLink_Click" />

            </div>

            <!-- Back to Login -->
            <div class="text-center">

                <a href="WebForm1.aspx" class="small text-decoration-none">
                    <i class="fa fa-arrow-left"></i> Back to Login
                </a>

            </div>

        </div>

    </div>

</div>

</form>

</body>
</html>
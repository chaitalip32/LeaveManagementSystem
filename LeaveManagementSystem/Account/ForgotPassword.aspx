<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="LeaveManagementSystem.Account.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
    body {
        background:white !important;
    }

    .card {
        border-radius: 12px;
    }

    .form-control {
        border: none;
        border-bottom: 1px solid #ccc;
        border-radius: 0;
    }

    .form-control:focus {
        box-shadow: none;
        border-bottom: 2px solid #4F46E5; 
    }

    .btn-custom {
        background-color: #5B35CD !important;
        border-color: #6366F1 !important;
        color: white !important;
        font-weight: 500;
        padding: 10px 20px;
        border-radius: 8px; 
        transition: all 0.2s ease-in-out;
    }

    .btn-custom:hover {
        background-color: #4F46E5 !important;
        border-color: #4F46E5 !important;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        transform: translateY(-1px); 
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
                    CssClass="btn btn-custom btn-lg"
                    OnClick="btnSendLink_Click" />

            </div>

            <!-- Back to Login -->
            <div class="text-center">

                <a href="Login.aspx" class="small text-decoration-none">
                    <i class="fa fa-arrow-left"></i> Back to Login
                </a>

            </div>

        </div>

    </div>

</div>

</form>

</body>
</html>
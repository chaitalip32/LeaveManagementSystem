<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LeaveManagementSystem.Account.Login" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous" />
    <style>

        body{
            background-color:#f5f6fa;
            height:100vh;
        }
        .login-card{
            border-radius:15px;
            padding:40px;
        }
        .login-image{
            max-width:100%;
        }
        .login-title{
            font-weight:600;
            margin-bottom: 30px;
        }
        .form-control{
            border:none;
            border-bottom: 1px solid #ccc;
        }
        .form-control:focus{
            box-shadow:none;
            border-bottom: 2px solid #0d6efd;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container d-flex align-items-center justify-content-center vh-100">
        
        <div class="card shadow-lg login-card w-100" style="max-width:900px;">

            <asp:ValidationSummary 
                ID="ValidationSummary1"
                runat="server"
                CssClass="alert alert-danger"
                HeaderText="Please fix the following errors:"
                DisplayMode="List" />

            <div class="row g-5 align-items-center">
                
                <!--Left image part-->
                <div class="col-md-6 text-center">
                    <img src="/Images/login.jpg" class="login-image"/>
                </div>

                <!--Right form part-->
                <div class="col-md-6">
                    <h3 class="login-title text-center">Log In</h3>

                     <!--Error Message label-->
                    <asp:Label ID="lblMessage" 
                        runat="server" 
                        CssClass="alert alert-danger text-center" 
                        Visible="false">
                    </asp:Label>

                    <!--Email-->
                    <div class="mb-4 position-relative">

                        <i class="fa fa-user position-absolute top-50 start-0 translate-middle-y text-muted"></i>
                        <asp:TextBox ID="txtEmail" 
                            runat="server" 
                            CssClass="form-control ps-4"
                            placeholder="Your Email">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator 
                            ID="rfvEmail"
                            runat="server"
                            ErrorMessage="Email Required"
                            Display="None"
                            ControlToValidate="txtEmail"
                            CssClass="text-danger">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator 
                            ID="revEmail" 
                            runat="server"
                            ControlToValidate="txtEmail" 
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            Display="None"
                            ErrorMessage="Invalid Email Format"
                            CssClass="text-danger">
                        </asp:RegularExpressionValidator>
                    </div>

                    <div class="mb-4 position-relative">

                        <i class="fa fa-lock position-absolute top-50 start-0 translate-middle-y text-muted"></i>
                        <asp:TextBox ID="txtPassword" 
                                runat="server" 
                                TextMode="Password"
                                ClientIdMode="Static"
                                CssClass="form-control ps-4"
                                placeholder="password">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator 
                            ID="rfvPassword"
                            runat="server"
                            ErrorMessage="Password Required"
                            Display="None"
                            ControlToValidate="txtPassword"
                            CssClass="text-danger">
                        </asp:RequiredFieldValidator>

                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="form-check">
                            <asp:CheckBox ID="chkRemember" 
                                runat="server"
                                CssClass="form-check-input" />

                            <label class="form-check-label">Remember me</label>
                        </div>

                        <div>
                            <asp:HyperLink ID="lnkForgotPassword" 
                                runat="server"
                                NavigateUrl="~/Account/ForgotPassword.aspx">
                                Forgot Password?
                            </asp:HyperLink>
                        </div>
                    </div>
                    

                    <div class="d-grid mb-4">
                        <asp:Button ID="btnLogin" 
                        runat="server" 
                        Text="Log In"
                        CssClass="btn btn-primary btn-lg" OnClick="btnLogin_Click" />
                    </div>

                </div>

                
            </div>
        </div>
    </div>
    </form>
</body>
</html>
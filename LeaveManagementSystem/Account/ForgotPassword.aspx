<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="LeaveManagementSystem.Account.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
    <form id="form1" runat="server">
    <div class="container">
        <div class="row justify-content-center align-items-center vh-100">
            <div class="col-md-4">
                <div class="card p-4 shadow">
                    <h4 class="text-center mb-3">Forgot password</h4>

                    <asp:Label ID="lblMessage" 
                        runat="server" 
                        Visible="false"
                        CssClass="alert text-center">
                    </asp:Label>

                    <div class="mb-3">

                        <label>Email</label>

                        <asp:TextBox 
                            ID="txtEmail" 
                            runat="server"
                            CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="d-grid">
                        <asp:Button ID="btnSendLink" 
                            runat="server" 
                            Text="Send Reset Link"
                            CssClass="btn btn-success" OnClick="btnSendLink_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>

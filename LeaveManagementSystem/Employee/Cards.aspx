<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cards.aspx.cs" Inherits="LeaveManagementSystem.Employee.Cards" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class="row g-4">

        <div class="col-md-4">
            <div class="card shadow">
                <div class="card-body">
                    <h5>Casual Leave</h5>
                    <h3 class="text-primary">5 / 15</h3>
                    <div class="progress">
                        <div class="progress-bar" style="width:50%"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow">
                <div class="card-body">
                    <h5>Sick Leave</h5>
                    <h3 class="text-success">3 / 8</h3>
                    <div class="progress">
                        <div class="progress-bar bg-success" style="width:40%"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow">
                <div class="card-body">
                    <h5>Earned Leave</h5>
                    <h3 class="text-danger">8 / 15</h3>
                    <div class="progress">
                        <div class="progress-bar bg-danger" style="width:60%"></div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    </div>
    </form>
</body>
</html>

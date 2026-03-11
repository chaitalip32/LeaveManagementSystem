<%@ Page Language="C#" MasterPageFile="~/Employee/EmployeeMaster.master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LeaveManagementSystem.Employee.Dashboard" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h3 class="mb-4">Welcome, Employee</h3>
    
    <!-- Leave Balance Cards -->
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

    <!-- Recent Leaves Table -->
    <div class="card mt-5 shadow">
        <div class="card-header bg-primary text-white">
            Recent Leave Requests
        </div>
        <div class="card-body">

            <asp:GridView ID="gvLeaves" runat="server" CssClass="table table-bordered table-striped" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="LeaveType" HeaderText="Leave Type" />
                    <asp:BoundField DataField="FromDate" HeaderText="From" />
                    <asp:BoundField DataField="ToDate" HeaderText="To" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                </Columns>
            </asp:GridView>

        </div>
    </div>

</asp:Content>
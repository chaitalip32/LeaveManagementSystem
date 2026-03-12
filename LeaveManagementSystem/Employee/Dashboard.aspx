<%@ Page Language="C#" MasterPageFile="~/Employee/EmployeeMaster.master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LeaveManagementSystem.Employee.Dashboard" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h3 class="mb-4">Welcome, Employee</h3>
    
    <!-- Leave Balance Cards -->
    
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
<%@ Page Title="" Language="C#" MasterPageFile="~/Employee/EmployeeMaster.Master" AutoEventWireup="true" CodeBehind="EmployeeLeaveHistory.aspx.cs" Inherits="LeaveManagementSystem.Employee.EmployeeLeaveHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .table th{
             background:#343a40;
             color:white;
             text-align:center;
        }

        .table td{
            vertical-align: middle;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="gvLeaveHistory" runat="server" AutoGenerateColumns="false"
        CssClass="table table-bordered table-hover">
        <Columns>
            
            <asp:BoundField DataField="LeaveTypeName" HeaderText="Leave Type"/>

            <asp:BoundField DataField="FromDate" HeaderText="From Date" DataFormatString="{0:dd-MM-yyyy}"/>
        
            <asp:BoundField DataField="ToDate" HeaderText="To Date" DataFormatString="{0:dd-MM-yyyy}"/>

            <asp:BoundField DataField="TotalDays" HeaderText="Days"/>

            <asp:BoundField DataField="Status" HeaderText="Status" />

            <asp:BoundField DataField="ManagerRemarks" HeaderText="manager Comment"/>

            <asp:BoundField DataField="HRRemarks" HeaderText="HR Comment"/>
        </Columns>
    </asp:GridView>
</asp:Content>

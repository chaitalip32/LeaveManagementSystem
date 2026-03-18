<%@ Page Title="" Language="C#" MasterPageFile="~/Employee/Site1.Master" AutoEventWireup="true" CodeBehind="EmployeeLeaveHistory.aspx.cs" Inherits="LeaveManagementSystem.Employee.EmployeeLeaveHistory" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <style>
       
        .page-content{
            padding:20px;
        }

        .table-container{
            background:#ffffff;
            padding:20px;
            border-radius:10px;
            box-shadow:0 4px 12px rgba(0,0,0,0.05);
        }

        .table{
            margin:0;
        }

        .table th{
             background:#343a40;
             color:white;
             text-align:center;
             padding:12px;
        }

        .table td{
            padding:12px;
            vertical-align: middle;
        }

        .table tbody tr{
            border-bottom:1px solid #e5e7eb;
        }

        .table tbody tr:hover{
            background:#f9fafb;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-content mt-3">

         <h4 class="mb-4 fw-semibold text-center">Leave History</h4>
    <div class="table-responsive">
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
    </div>
        </div>
</asp:Content>

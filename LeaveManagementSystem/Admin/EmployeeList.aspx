<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="EmployeeList.aspx.cs" Inherits="LeaveManagementSystem.Admin.EmployeeList" %>

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

         <h4 class="mb-4 fw-semibold text-center">Employee Details</h4>
    <div class="table-responsive">
        <asp:GridView ID="gvEmployeeList" runat="server" AutoGenerateColumns="false"
        CssClass="table table-bordered table-hover">
        <Columns>
            
            <asp:BoundField DataField="EmployeeId" HeaderText="Employee ID"/>

            <asp:BoundField DataField="EmployeeCode" HeaderText="Employee Code"/>
        
            <asp:BoundField DataField="FullName" HeaderText="Full Name"/>

            <asp:BoundField DataField="DepartmentName" HeaderText="Department"/>

            <asp:BoundField DataField="ManagerName" HeaderText="ManagerName"/>

            <asp:BoundField DataField="Email" HeaderText="Email" />

            <asp:BoundField DataField="PhoneNumber" HeaderText="Phone"/>

            <asp:BoundField DataField="City" HeaderText="City"/>

            <asp:BoundField DataField="DateOfJoining" HeaderText="Date Of Joining" DataFormatString="{0:dd-MM-yyyy}"/>

            <asp:BoundField DataField="Status" HeaderText="Status"/>

        </Columns>
    </asp:GridView>
    </div>
        </div>
</asp:Content>

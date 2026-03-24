<%@ Page Title="Manage Departments" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Manage_Departments.aspx.cs" Inherits="LeaveManagementSystem.Admin.Manage_Departments" %>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    
    <style>
        .action-col {
            width: 120px;
            text-align: center;
        }
        
        .custom-table {
            width: 100% !important;
            border-collapse: collapse;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 6px 10px;
            border-radius: 4px;
            transition: 0.2s;
            text-decoration: none !important;                       
            font-size: 14px;
        }

        /* Hover effect for Edit */
        .btn-edit-style { color: #0d6efd; background-color: rgba(13, 110, 253, 0.1); }
        .btn-edit-style:hover { background-color: #0d6efd; color: #fff !important; }

        /* Hover effect for Delete */
        .btn-delete-style { color: #dc3545; background-color: rgba(220, 53, 69, 0.1); }
        .btn-delete-style:hover { background-color: #dc3545; color: #fff !important; }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        <h4 class="mb-4 fw-semibold">Manage Departments</h4>

        <asp:LinkButton ID="btnAddNew" runat="server" PostBackUrl="~/Admin/Add_Department.aspx" CssClass="btn btn-theme mb-3">
            <i class="fas fa-plus me-1"></i> Add New Department
        </asp:LinkButton>

        <div class="table-responsive bg-white p-3 shadow-sm rounded-3">

            <asp:GridView ID="gvDepartments" runat="server"
                CssClass="table custom-table"
                AutoGenerateColumns="False"
                DataKeyNames="DepartmentId"
                GridLines="None"
                OnRowCommand="gvDepartments_RowCommand"
                OnRowDeleting="gvDepartments_RowDeleting">

                <Columns>
                    <asp:BoundField DataField="DepartmentId" HeaderText="ID" ItemStyle-Width="50px" />
                    <asp:BoundField DataField="DepartmentName" HeaderText="Name" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
        
                    <asp:TemplateField HeaderText="Action">

                        <ItemStyle CssClass="action-col" />

                        <ItemTemplate>
                            <div class="d-flex gap-2 justify-content-center">
                                <asp:LinkButton ID="btnEdit" runat="server"
                                    CommandName="EditDept"
                                    CommandArgument='<%# Eval("DepartmentId") %>'
                                    CssClass="action-btn btn-edit-style" ToolTip="Edit">
                                    <i class="fas fa-edit"></i>
                                </asp:LinkButton>
                                
                                <asp:LinkButton ID="btnDelete" runat="server"
                                    CommandName="Delete"
                                    CssClass="action-btn btn-delete-style" 
                                    OnClientClick="return confirm('Are you sure you want to delete this department?');" ToolTip="Delete">
                                    <i class="fas fa-trash-alt"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>

                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
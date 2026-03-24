<%@ Page Title="Manage Leave Types" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="ManageLeaves.aspx.cs" Inherits="LeaveManagementSystem.Admin.ManageLeaves" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
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

        .btn-edit-style { 
            color: #0d6efd; 
            background-color: rgba(13, 110, 253, 0.1); 
        }

        .btn-edit-style:hover { 
            background-color: #0d6efd; 
            color: #fff !important; 
        }
        
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        <h4 class="mb-4 fw-semibold">Manage Leave Types</h4>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <asp:LinkButton ID="btnAddNew" runat="server" PostBackUrl="~/Admin/Add_LeaveType.aspx" CssClass="btn btn-theme">
                <i class="fas fa-plus me-1"></i> Add New Leave Type
            </asp:LinkButton>
            
            <div class="d-flex gap-2">
                <asp:TextBox ID="txtSearchLeaveType" runat="server" CssClass="form-control" placeholder="Search..."></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-purple" OnClick="btnSearch_Click" />
            </div>
        </div>

        <div class="table-responsive bg-white p-3 shadow-sm rounded-3">

            <asp:GridView ID="gvLeaveTypes" runat="server" CssClass="table custom-table"
                AutoGenerateColumns="false" DataKeyNames="LeaveTypeId" GridLines="None"
                OnRowCommand="gvLeaveTypes_RowCommand">

                <Columns>
                    <asp:BoundField DataField="LeaveTypeId" HeaderText="ID" ItemStyle-Width="50px" />
                    <asp:BoundField DataField="LeaveTypeName" HeaderText="Leave Type" />
                    <asp:BoundField DataField="DefaultDays" HeaderText="Days" />

                    <asp:TemplateField HeaderText="Status">

                        <ItemTemplate>
                            <span class='badge <%# Convert.ToBoolean(Eval("IsActive")) ? "bg-success" : "bg-secondary" %>'>
                                <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Deactive" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action">

                        <ItemStyle CssClass="action-col" />

                        <ItemTemplate>
                            <div class="d-flex gap-2 justify-content-center">
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditLeave" CommandArgument='<%# Eval("LeaveTypeId") %>' CssClass="action-btn btn-edit-style">
                                    <i class="fas fa-edit"></i>
                                </asp:LinkButton>
                                
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
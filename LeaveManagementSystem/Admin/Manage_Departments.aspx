<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="Manage_Departments.aspx.cs" Inherits="LeaveManagementSystem.Admin.Manage_Departments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">

        <h3 class="mb-4">Manage Departments</h3>

        <!-- Add Department Card-->
        <div class="card shadow-sm mb-4">
            <div class="card-header card-header-theme">
                Add New department
            </div>

            <div class="card-body">

                <div class="row g-3">
                    <div class="col-md-6">
                        <asp:TextBox ID="txtDepartmentName" runat="server"
                            CssClass="form-control">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator ID="rfvDepartment" 
                            ControlToValidate="txtDepartmentName"
                            CssClass="text-danger"
                            runat="server" 
                            ErrorMessage="Department name is required">
                        </asp:RequiredFieldValidator>

                    </div>

                    <div class="col-md-6">
                        <asp:TextBox ID="txtDescription" runat="server"
                            CssClass="form-control">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator ID="rfvDescription" 
                            ControlToValidate="txtDescription"
                            CssClass="text-danger"
                            runat="server" 
                            ErrorMessage="Description is required">
                        </asp:RequiredFieldValidator>

                    </div>

                    <div class="col-md-3">
                        <asp:Button ID="btnAddepartment" runat="server" Text="Add Department"
                            CssClass="btn btn-theme w-100" OnClick="btnAddepartment_Click" />
                    </div>
                </div>

                <asp:Label ID="lblMessage" runat="server"
                    CssClass="text-success mt-2 d-block"></asp:Label>

            </div>
        </div>

        <!-- Department Grid -->
        <div class="card shadow-sm">
            <div class="card-header card-header-theme">
                Department List
            </div>

            <div class="card-body">

                <asp:GridView ID="gvDepartments" runat="server"
                    CssClass="table table-bordered table-hover"
                    AutoGenerateColumns="False"
                    DataKeyNames="DepartmentId"
                    OnRowEditing="gvDepartments_RowEditing"
                    OnRowCancelingEdit="gvDepartments_RowCancelingEdit"
                    OnRowUpdating="gvDepartments_RowUpdating"
                    OnRowDeleting="gvDepartments_RowDeleting" OnSelectedIndexChanged="gvDepartments_SelectedIndexChanged"
                    >

                    <Columns>

                        <asp:BoundField DataField="DepartmentId"
                            HeaderText="ID"
                            ReadOnly="True"/>

                        <asp:TemplateField HeaderText="Department Name">
                            <ItemTemplate>
                                <%# Eval("DepartmentName") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditName" runat="server"
                                    CssClass="form-control"
                                    Text='<%# Bind("DepartmentName") %>'>
                                </asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <%# Eval("Description") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditDescription" runat="server"
                                    CssClass="form-control"
                                    Text='<%# Bind("Description") %>'>

                                </asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                             <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server"
                                    CommandName="Edit"
                                    CssClass="btn btn-purple btn-sm me-2"
                                    CausesValidation="false">
                                    Edit
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnDelete" runat="server"
                                    CommandName="Delete"
                                    CssClass="btn btn-danger btn-sm"
                                    CausesValidation="false"
                                    OnClientClick="return confirm('Are you sure you want to delete?');">
                                    Delete
                                </asp:LinkButton>
                            </ItemTemplate> 
                            
                            <EditItemTemplate>
                                <asp:LinkButton ID="btnUpdate" runat="server"
                                    CommandName="Update"
                                    CausesValidation="false"
                                    CssClass="btn btn-theme btn-sm me-2">
                                    Update
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnCancel" runat="server"
                                    CommandName="Cancel"
                                    CssClass="btn btn-secondary btn-sm me-2"
                                    CausesValidation="false">
                                    Cancel
                                </asp:LinkButton>
                            </EditItemTemplate>         
                        </asp:TemplateField>
                    </Columns>

                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

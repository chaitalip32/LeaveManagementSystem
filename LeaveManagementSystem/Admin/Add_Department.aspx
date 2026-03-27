<%@ Page Title="Department Form" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Add_Department.aspx.cs" Inherits="LeaveManagementSystem.Admin.Add_Department" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4">

        <div class="row justify-content-center">

            <div class="col-lg-7">

                <h4 class="mb-4 fw-semibold text-center">
                    <asp:Literal ID="litTitle" runat="server" Text="Add Department"></asp:Literal>
                </h4>

                <div class="card shadow-sm border-0">
                    <div class="card-header card-header-theme text-white p-3" style="background-color: #773CA2;">
                        Department Details
                    </div>

                    <div class="card-body p-4 bg-white">

                        <asp:HiddenField ID="hfDepartmentId" runat="server" />

                        <div class="mb-4">
                            <label class="form-label fw-bold">Department Name <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtDeptName" runat="server" CssClass="form-control" placeholder="e.g. Human Resources"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtDeptName"
                                CssClass="text-danger small" Display="None" ErrorMessage="Department name is required" />
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Description</label>
                            <asp:TextBox ID="txtDeptDesc" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter department details..."></asp:TextBox>
                        </div>

                        <div class="text-end pt-3">

                            <asp:ValidationSummary 
                                ID="addDepartmentForm" 
                                runat="server" 
                                ShowSummary="false" 
                                ShowMessageBox="true" 
                                HeaderText="Please correct the following errors:" 
                                CssClass="text-danger" />

                            <asp:Button ID="btnCancel" runat="server" Text="Back to List" CssClass="btn btn-secondary px-4 me-2" 
                                CausesValidation="false" PostBackUrl="~/Admin/Manage_Departments.aspx" />
                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-theme px-4" OnClick="btnSave_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
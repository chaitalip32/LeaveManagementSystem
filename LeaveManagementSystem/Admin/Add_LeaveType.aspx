<%@ Page Title="Leave Type Form" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Add_LeaveType.aspx.cs" Inherits="LeaveManagementSystem.Admin.Add_LeaveType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-lg-7">
                <h4 class="mb-4 fw-semibold text-center">
                    <asp:Literal ID="litTitle" runat="server" Text="Add Leave Type"></asp:Literal>
                </h4>

                <div class="card shadow-sm border-0">
                    <div class="card-header card-header-theme text-white p-3" style="background-color: #773CA2;">
                        Leave Type Details
                    </div>
                    <div class="card-body p-4 bg-white">
                        <asp:HiddenField ID="hfLeaveTypeId" runat="server" />

                        <div class="row g-3">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Leave Name <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtLeaveType" runat="server" CssClass="form-control" placeholder="e.g. Sick Leave"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLeaveType" CssClass="text-danger small" ErrorMessage="Required" ValidationGroup="vgLeave" />
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Default Days <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtDefaultDays" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDefaultDays" CssClass="text-danger small" ErrorMessage="Required" ValidationGroup="vgLeave" />
                            </div>

                            <div class="col-md-12 mb-3">
                                <label class="form-label fw-bold">Description</label>
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Status</label>
                                <asp:RadioButtonList ID="rblStatus" runat="server" 
                                    RepeatDirection="Horizontal" 
                                    RepeatLayout="Flow" 
                                    CssClass="custom-rbl">
                                    <asp:ListItem Text="Active" Value="1" Selected="True" class="me-3"></asp:ListItem>
                                    <asp:ListItem Text="Deactive" Value="0"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>

                        <div class="text-end pt-3 border-top mt-3">
                            <asp:Button ID="btnCancel" runat="server" Text="Back to List" CssClass="btn btn-secondary px-4 me-2" 
                                CausesValidation="false" PostBackUrl="~/Admin/ManageLeaves.aspx" />
                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-theme px-4" 
                                OnClick="btnSave_Click" ValidationGroup="vgLeave" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
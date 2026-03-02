<%@ Page Language="C#" 
    MasterPageFile="~/Employee/EmployeeMaster.master" 
    AutoEventWireup="true" 
    CodeBehind="ApplyLeave.aspx.cs"
    Inherits="LeaveManagementSystem.Employee.LeaveApplicationForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid">

    <asp:ValidationSummary 
        ID="ValidationSummary1"
        runat="server"
        CssClass="alert alert-danger"
        HeaderText="Please fix the following errors:"
        ValidationGroup="LeaveForm" />

    <h4 class="mb-4 fw-semibold text-center">Apply for Leave</h4>

    <div class="card shadow-sm">
        <div class="card-header card-header-theme">
            Leave Details
        </div>

        <div class="card-body">
            <div class="row g-3">

                <!-- Leave Type -->
                <div class="col-md-6">
                    <label class="form-label required">Leave Type</label>
                    <asp:DropDownList ID="ddlLeaveType" 
                        runat="server" 
                        CssClass="form-select">
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        ID="rfvLeaveType"
                        runat="server"
                        ControlToValidate="ddlLeaveType"
                        InitialValue=""
                        CssClass="text-danger"
                        ErrorMessage="Please select leave type"
                        ValidationGroup="LeaveForm" />
                </div>

                <!-- From Date -->
                <div class="col-md-6">
                    <label class="form-label required">From Date</label>
                    <asp:TextBox ID="txtFromDate"
                        runat="server"
                        TextMode="Date"
                        CssClass="form-control">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvFromDate"
                        runat="server"
                        ControlToValidate="txtFromDate"
                        CssClass="text-danger"
                        ErrorMessage="From Date is required"
                        ValidationGroup="LeaveForm" />
                </div>

                <!-- To Date -->
                <div class="col-md-6">
                    <label class="form-label required">To Date</label>
                    <asp:TextBox ID="txtToDate"
                        runat="server"
                        TextMode="Date"
                        CssClass="form-control">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvToDate"
                        runat="server"
                        ControlToValidate="txtToDate"
                        CssClass="text-danger"
                        ErrorMessage="To Date is required"
                        ValidationGroup="LeaveForm" />
                </div>

                <!-- Date Compare Validator -->
                <div class="col-md-6">
                    <asp:CompareValidator
                        ID="cvDates"
                        runat="server"
                        ControlToValidate="txtToDate"
                        ControlToCompare="txtFromDate"
                        Operator="GreaterThanEqual"
                        Type="Date"
                        CssClass="text-danger"
                        ErrorMessage="To Date must be greater than or equal to From Date"
                        ValidationGroup="LeaveForm" />
                </div>

                <!-- Reason -->
                <div class="col-md-12">
                    <label class="form-label required">Reason</label>
                    <asp:TextBox ID="txtReason"
                        runat="server"
                        TextMode="MultiLine"
                        Rows="3"
                        CssClass="form-control">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvReason"
                        runat="server"
                        ControlToValidate="txtReason"
                        CssClass="text-danger"
                        ErrorMessage="Reason is required"
                        ValidationGroup="LeaveForm" />
                </div>

            </div>
        </div>
    </div>

    <!-- Buttons -->
    <div class="text-end mt-4">
        <asp:Button ID="btnApply"
            runat="server"
            Text="Submit Leave Request"
            CssClass="btn btn-theme px-4 me-2"
            ValidationGroup="LeaveForm" />

        <asp:Button ID="btnCancel"
            runat="server"
            Text="Cancel"
            CssClass="btn btn-secondary px-4"
            CausesValidation="false" />
    </div>

</div>

</asp:Content>
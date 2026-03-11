<%@ Page Title="" Language="C#" MasterPageFile="~/Employee/EmployeeMaster.Master" AutoEventWireup="true" CodeBehind="ApplyLeave.aspx.cs" Inherits="LeaveManagementSystem.Employee.ApplyLeave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid">

        <asp:ValidationSummary 
                ID="ValidationSummary1" 
                runat="server" 
                CssClass="alert alert-danger"
                HeaderText="Please fix the following errors:"
                ValidationGroup="LeaveForm"/>

        <h4 class="mb-4 fw-semibold text-center">Apply for Leave</h4>
        <div class="card shadow-sm mb-4">

            <div class="card-header card-header-theme">
                Leave Details
            </div>

            <div class="card-body">
                <div class="row g-3">

                    <!--Leave type-->
                    <div class="col-md-6">
                        <label class="form-label required">Subject</label>
                        <asp:TextBox ID="txtSubject" 
                            runat="server"
                            CssClass="form-control"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="rfvSubject" 
                            runat="server" 
                            InitialValue=""
                            CssClass="text-danger"
                            ErrorMessage="Subject is required"
                            ControlToValidate="txtSubject"></asp:RequiredFieldValidator>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label required" runat="server">CC Email</label>
                        <asp:DropDownList 
                            ID="ddlCCEmail" 
                            runat="server"
                            CssClass="form-select">
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator 
                            Id="rfvCCEmail"
                            runat="server"
                            ControlToValidate="ddlCCEmail"
                            InitialValue=""
                            CssClass="text-danger"
                            ErrorMessage="Please select a manager"
                            ValidationGroup="LeaveForm"/>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label required" runat="server">Leave Type</label>
                        <asp:DropDownList 
                            ID="ddlLeaveType" 
                            runat="server"
                            CssClass="form-select">
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator 
                            Id="rfvddlLeaveType"
                            runat="server"
                            ControlToValidate="ddlLeaveType"
                            InitialValue=""
                            CssClass="text-danger"
                            ErrorMessage="Please select a leave type"
                            ValidationGroup="LeaveForm"/>
                    </div>

                    <div class="col-md-6">

                        <asp:RadioButtonList ID="rblLeaveDay" 
                            RepeatDirection="Horizontal"
                            runat="server">
                            <asp:ListItem Value="Half Day" Selected="True" class="me-4">&nbsp;&nbsp;Hald Day</asp:ListItem>
                            <asp:ListItem Value="Full Day" Selected="False">&nbsp;&nbsp;Full Day</asp:ListItem>
                        </asp:RadioButtonList>

                    </div>

                    <!--Form Date-->
                    <div class="col-md-6">
                        <label class="form-label required" runat="server">From Date</label>
                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator 
                            Id="rfvFromDate"
                            runat="server"
                            ControlToValidate="txtFromDate"
                            CssClass="text-danger"
                            ErrorMessage="From Date is required"
                            ValidationGroup="LeaveForm"/>
                    </div>

                    <!-- To Date-->
                    <div class="col-md-6">
                        <label class="form-label required" runat="server">To Date</label>
                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator 
                            Id="rfvToDate"
                            runat="server"
                            ControlToValidate="txtToDate"
                            CssClass="text-danger"
                            ErrorMessage="To Date is required"
                            ValidationGroup="LeaveForm"/>
                    </div>

                    <div class="col-md-6">
                        <!--Date Compare Validator-->
                        <asp:CompareValidator 
                            ID="cvDates" 
                            runat="server" 
                            ControlToValidate="txtToDate"
                            ControlToCompare="txtFromDate"
                            Operator="GreaterThanEqual"
                            Type="Date"
                            CssClass="text-danger"
                            ErrorMessage="To date must be greater than or equal to From Date"
                            ValidationGroup="LeaveForm"/>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">No of days leave taken</label>

                        <asp:TextBox ID="txtNoOfDays" 
                            CssClass="form-control"
                            runat="server"></asp:TextBox>
                    </div>

                    <!--Reason-->
                    <div class="col-md-12">
                        <label class="form-label required" runat="server">Reason</label>
                        <asp:TextBox ID="txtReason" 
                            runat="server" 
                            TextMode="MultiLine" 
                            Rows="3"
                            CssClass="form-control"></asp:TextBox>

                        <asp:RequiredFieldValidator 
                            Id="rfvReason"
                            runat="server"
                            ControlToValidate="txtReason"
                            CssClass="text-danger"
                            ErrorMessage="Reason is required"
                            ValidationGroup="LeaveForm"/>
                    </div>

                </div>
            </div>
        </div>

        <!-- Buttons -->
        <div class="text-end mt-4">
            <asp:Button 
                ID="btnApply" 
                runat="server" 
                Text="Submit Leave Request"
                CssClass="btn btn-theme px-4 me-2"
                ValidationGroup="LeaveForm" />

            <asp:Button ID="btnCancel" 
                runat="server" 
                Text="Cancel" 
                CssClass="btn btn-secondary px-4"
                CausesValidation="false"/>
        </div>

    </div>
</asp:Content>

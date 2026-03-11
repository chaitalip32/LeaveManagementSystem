<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewLeaveForm.aspx.cs" Inherits="LeaveManagementSystem.Employee.NewLeaveForm" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee - Leave Management System</title>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <style>
        body{
            font-family: 'Inter', sans-serif;
        }

        .dropdown-menu{
            border-radius:8px;
        }   
             
        .form-control{
            border-radius: 0;
        }

        .dropdown-menu{
            border-radius:0;
        }

        .form-select{
            border-radius: 0;
        }

        .form-check input {
            margin-right: 8px;
        }
        .required{
            color: red;
        }
        
        .text-danger{
            font-size: 13px;
            display: block;
            margin-top:3px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container mt-5">

            <div class="row justify-content-center">

                <div class="col-lg-10 col-md-11 col-sm-12">
                    <asp:ValidationSummary 
                        ID="ValidationSummary1" 
                        runat="server" 
                        CssClass="alert alert-danger"
                        HeaderText="Please fill the following fields:"
                        ValidationGroup="LeaveForm"/>

                    <h4 class="mb-4 fw-semibold text-center">Send Leave Email</h4>

                    <div class="form-card shadow p-5">

                    <div class="card-body">
                        <div class="row g-4">

                            <!--Leave type-->
                            <div class="col-md-6">
                                <label class="form-label">Subject <span class="required">*</span></label>
                                <asp:TextBox ID="txtSubject" 
                                    runat="server"
                                    CssClass="form-control"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="rfvSubject" 
                                    runat="server" 
                                    InitialValue=""
                                    CssClass="text-danger"
                                    ErrorMessage="Subject is required"
                                    ValidationGroup="LeaveForm"
                                    ControlToValidate="txtSubject"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label" runat="server">CC Email</label>
                                
                                <div class="dropdown w-100">

                                    <button class="form-select text-start" type="button"
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                        Select Managers
                                    </button>

                                    <div class="dropdown-menu p-3 w-100" style="max-height:200px; overflow-y:auto;">
                                        
                                        <asp:CheckBoxList 
                                            ID="cblCCEmail"
                                            CssClass="form-check"
                                            RepeatLayout="Flow"
                                            RepeatDirection="Vertical" 
                                            runat="server">
                                        </asp:CheckBoxList>

                                    </div>

                                </div>
                                
                            </div>

                            <div class="col-md-6">
                                <label class="form-label" runat="server">Leave Type <span class="required">*</span></label>
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

                                <label class="form-label">Leave Duration</label>
                                <asp:RadioButtonList 
                                    ID="rblLeaveDay" 
                                    RepeatLayout="Flow"
                                    RepeatDirection="Horizontal"
                                    runat="server"
                                    CssClass="d-flex align-items-center">
                                    <asp:ListItem Value="Half Day" Selected="True" class="me-4">&nbsp;Half Day</asp:ListItem>
                                    <asp:ListItem Value="Full Day">&nbsp;Full Day</asp:ListItem>
                                </asp:RadioButtonList>

                            </div>

                            <!--Form Date-->
                            <div class="col-md-6">
                                <label class="form-label" runat="server">From Date <span class="required">*</span></label>
                                <asp:TextBox ID="txtFromDate" runat="server" 
                                    CssClass="form-control"></asp:TextBox>

                                <ajaxToolkit:CalendarExtender 
                                    ID="calFromDate"
                                    runat="server"
                                    TargetControlId="txtFromDate"
                                    Format="yyyy-mm-dd"/>
                        
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
                                <label class="form-label" runat="server">To Date <span class="required">*</span></label>
                                <asp:TextBox ID="txtToDate" runat="server" 
                                    CssClass="form-control"></asp:TextBox>
                            
                                <ajaxToolkit:CalendarExtender
                                    runat="server"
                                    ID="calToDate"
                                    TargetControlId="txtToDate" />
                                
                                <asp:RequiredFieldValidator 
                                    Id="rfvToDate"
                                    runat="server"
                                    ControlToValidate="txtToDate"
                                    CssClass="text-danger"
                                    ErrorMessage="To Date is required"
                                    ValidationGroup="LeaveForm"/>

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
                                <label class="form-label" runat="server">Reason <span class="required">*</span></label>
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
                    <div class="text-center mt-4">
                        <asp:Button 
                            ID="btnSubmit" 
                            runat="server" 
                            Text="Submit"
                            CssClass="btn btn-success px-4 w-25 me-2"
                            ValidationGroup="LeaveForm" />

                        <asp:Button ID="btnCancel"
                            runat="server"
                            Text="Cancel"
                            CssClass="btn btn-secondary w-25 px-4"
                            CausesValidation="false" />
                    </div>
            </div>
        </div>
    </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

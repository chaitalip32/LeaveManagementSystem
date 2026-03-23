<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="NewLeaveForm.aspx.cs" Inherits="LeaveManagementSystem.Employee.NewLeaveForm" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .form-card { 
            background: white;
            border-radius: 8px; }

        .btn-theme { 
            background-color: #E2A63A; 
            border-color: #E2A63A; color: white; }

        .btn-theme:hover { 
            background-color: #F9B12B; 
            border-color: #F9B12B; color: white; }

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: #f8f9fa; }

        .form-control, .form-select { 
            border-radius: 4px; 
            border: 1px solid #ced4da; 
            padding: 0.6rem; }

        .required { 
            color: red; }

        .text-danger { 
            font-size: 12px; 
            display: block; 
            margin-top: 4px; 
            line-height: 1; }

        .form-card .col-md-6, .form-card .col-md-12 {
            margin-bottom: 20px !important; /*this creates the exact same vertical gap for every field */
        }

        .form-label { margin-bottom: 8px; font-size: 14px; font-weight: 500; color: #333; }

        .custom-radio-list {
            display: flex !important;
            gap: 10px; //space between options hald day and full day
            margin-top: 8px;
            align-items: center;
        }

        .custom-radio-list span {
            display: flex;
            align-items: center;
            margin-right: 8px;
        }

        .custom-radio-list input[type="radio"] {
            margin-right: 4px !important;   /*space between radio and text */
            width: 16px;
            height: 16px;
            cursor: pointer;
        }

        .custom-radio-list label {
            margin: 0;
            font-size: 14px;
            cursor: pointer;
        }
        
        /* Panel alignment fix: Force the panel to not interfere with the grid row */
        .grid-panel { 
            width: 100%;
        }

    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-lg-10">

                <h4 class="mb-4 fw-semibold text-center">Send Leave Email</h4>

                <div class="form-card shadow-sm p-5">
                    <div class="row">
                        
                        <div class="col-md-6">
                            <label class="form-label">Subject <span class="required">*</span></label>
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtSubject" 
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="Subject is required"   />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">CC Email</label>
                            <div class="dropdown">
                                <button class="form-select text-start w-100" type="button" data-bs-toggle="dropdown">Select Managers</button>
                                <div class="dropdown-menu p-3 w-100" style="max-height:200px; overflow-y:auto;">
                                    <asp:CheckBoxList ID="cblCCEmail" CssClass="form-check" RepeatLayout="Flow" runat="server"></asp:CheckBoxList>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Leave Type <span class="required">*</span></label>
                            <asp:DropDownList ID="ddlLeaveType" runat="server" CssClass="form-select"></asp:DropDownList>
                            <asp:RequiredFieldValidator Id="rfvddlLeaveType" runat="server" ControlToValidate="ddlLeaveType" 
                                InitialValue="" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please select a leave type"  />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Leave Duration</label>
                            <asp:RadioButtonList ID="rblLeaveDay" runat="server" RepeatLayout="Flow" AutoPostBack="true" 
                                OnSelectedIndexChanged="rblLeaveDay_SelectedIndexChanged" CssClass="custom-radio-list">
                                <asp:ListItem Value="Half Day">Half Day</asp:ListItem>
                                <asp:ListItem Value="Full Day" Selected="True">Full Day</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>

                        <asp:Panel ID="pnlFullDay" runat="server" CssClass="grid-panel">
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="form-label">Leave From Date <span class="required">*</span></label>
                                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" onchange="calculateDays()"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="calFromDate" runat="server"
                                        TargetControlId="txtFromDate" Format="yyyy-MM-dd" />
                                    <asp:RequiredFieldValidator Id="rfvFromDate" runat="server"
                                        ControlToValidate="txtFromDate"
                                        CssClass="text-danger"
                                        Display="Dynamic"
                                        ErrorMessage="From Date is required"
                                         />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Leave To Date <span class="required">*</span></label>
                                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" onchange="calculateDays()"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="calToDate" runat="server"
                                        TargetControlId="txtToDate" Format="yyyy-MM-dd" />
                                    <asp:RequiredFieldValidator Id="rfvToDate" runat="server"
                                        ControlToValidate="txtToDate"
                                        CssClass="text-danger"
                                        Display="Dynamic"
                                        ErrorMessage="To Date is required"
                                         />
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlHalfDay" runat="server" CssClass="grid-panel">
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="form-label">Date <span class="required">*</span></label>
                                    <asp:TextBox ID="txtHalfDayDate" CssClass="form-control" runat="server" onchange="calculateDays()"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="calhalfDate" runat="server"
                                        TargetControlId="txtHalfDayDate" Format="yyyy-MM-dd" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Day Type</label>
                                    <asp:DropDownList ID="ddlDayType" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                        <asp:ListItem Text="First Half" Value="First Half"></asp:ListItem>
                                        <asp:ListItem Text="Second Half" Value="Second Half"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </asp:Panel>
                        <div class="col-md-6">
                            <label class="form-label">No of days leave taken</label>
                            <asp:TextBox ID="txtNoOfDays" CssClass="form-control" runat="server" ReadOnly="true" style="background-color: #f0f0f0;"></asp:TextBox>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Reason <span class="required">*</span></label>
                            <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator Id="rfvReason" runat="server" ControlToValidate="txtReason" 
                                Display="Dynamic" CssClass="text-danger" ErrorMessage="Reason is required"  />
                        </div>

                        <div class="col-md-12 text-center mt-3">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success px-5 py-2 me-2"
                                  OnClick="btnSubmit_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary px-5 py-2" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function calculateDays() {
            var radios = document.getElementsByName('<%= rblLeaveDay.UniqueID %>');
            var leavetype = "";
            for (var i = 0; i < radios.length; i++) {
                if (radios[i].checked) { leavetype = radios[i].value; break; }
            }
            var txtDays = document.getElementById('<%=txtNoOfDays.ClientID%>');
            if (leavetype === "Half Day") {
                txtDays.value = "0.5";
            } else {
                var fromStr = document.getElementById('<%= txtFromDate.ClientID %>').value;
                var toStr = document.getElementById('<%= txtToDate.ClientID %>').value;
                if (fromStr && toStr) {
                    var start = new Date(fromStr);
                    var end = new Date(toStr);
                    var diff = Math.ceil((end - start) / (1000 * 60 * 60 * 24)) + 1;
                    txtDays.value = diff > 0 ? diff : "";
                }
            }
        }
    </script>
</asp:Content>
<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Employee/EmployeeMaster.master" CodeBehind="NewLeaveForm.aspx.cs" Inherits="LeaveManagementSystem.Employee.NewLeaveForm" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        
        
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
                                    AutoPostBack="true"
                                    runat="server"
                                    CssClass="d-flex align-items-center" OnSelectedIndexChanged="rblLeaveDay_SelectedIndexChanged">
                                    <asp:ListItem Value="Half Day" class="me-4">&nbsp;Half Day</asp:ListItem>
                                    <asp:ListItem Value="Full Day">&nbsp;Full Day</asp:ListItem>
                                </asp:RadioButtonList>

                            </div>

                            <!--Form Date-->
                            <asp:Panel ID="pnlFullDay" runat="server" CssClass="row">
                                <div class="col-md-6">
                                    <label class="form-label" runat="server">Leave From Date <span class="required">*</span></label>
                                    <asp:TextBox ID="txtFromDate" runat="server" 
                                        CssClass="form-control"
                                        onchange="calculateFays()"></asp:TextBox>

                                    <ajaxToolkit:CalendarExtender 
                                        ID="calFromDate"
                                        runat="server"
                                        TargetControlId="txtFromDate"
                                        Format="yyyy-MM-dd"/>
                        
                                    <asp:RequiredFieldValidator 
                                        Id="rfvFromDate"
                                        runat="server"
                                        ControlToValidate="txtFromDate"
                                        CssClass="text-danger"
                                        ErrorMessage="From Date is required"
                                        ValidationGroup="LeaveForm"
                                        />
                                </div>

                                <!-- To Date-->
                                <div class="col-md-6">
                                    <label class="form-label" runat="server">Leave To Date <span class="required">*</span></label>
                                    <asp:TextBox ID="txtToDate" runat="server" 
                                        CssClass="form-control"
                                        onchange="calculateFays()"></asp:TextBox>
                            
                                    <ajaxToolkit:CalendarExtender
                                        runat="server"
                                        ID="calToDate"
                                        TargetControlId="txtToDate"
                                        Format="yyyy-MM-dd" />
                                
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
                            </asp:Panel>


                            <asp:Panel ID="pnlHalfDay" runat="server" CssClass="row">
                                <div class="col-md-6">
                                    <label class="form-label">Date</label>
                                    <asp:TextBox ID="txtHalfDayDate"
                                        CssClass="form-control" runat="server"
                                        onchange="calculateFays()"></asp:TextBox>
                                
                                    <ajaxToolkit:CalendarExtender 
                                        ID="calhalfDate"
                                        runat="server"
                                        TargetControlId="txtHalfDayDate"
                                        Format="yyyy-MM-dd"/>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Day Type</label>
                                    <asp:DropDownList ID="ddlDayType" runat="server"
                                        CssClass="form-select">
                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                        <asp:ListItem Text="First Half" Value="First Half"></asp:ListItem>
                                        <asp:ListItem Text="Second Half" Value="Second Half"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </asp:Panel>

                            <div class="col-md-6">
                                <label class="form-label">No of days leave taken</label>

                                <asp:TextBox ID="txtNoOfDays" 
                                    CssClass="form-control"
                                    runat="server"
                                    ReadOnly="true"></asp:TextBox>
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
                            ValidationGroup="LeaveForm" OnClick="btnSubmit_Click" />

                        <asp:Button ID="btnCancel"
                            runat="server"
                            Text="Cancel"
                            CssClass="btn btn-secondary w-25 px-4"
                            CausesValidation="false" />
                    </div>
            </div>
        </div>
    </div>
    <script>
        function calculateFays() {

            //for half fay
            var leavetype = document.querySelector('input[name="<%= rblLeaveDay.UniqueID %>"]:checked').value;
            if (leavetype == "Half Day")
            {
                document.getElementById('<%=txtNoOfDays.ClientID%>').value = 0.5;
                return;
            }

            //full day calculation
            var fromDate = document.getElementById('<%= txtFromDate.ClientID %>').value;
            var toDate = document.getElementById('<%= txtToDate.ClientID %>').value;
                       
            if(fromDate !=="" && toDate !=="")
            {

                var start = new Date(fromDate);
                var end = new Date(toDate);
                
                var timeDiff = end-start;

                var diffDays = timeDiff / (1000 * 60 * 60 * 24) + 1;

                if (diffDays >= 0)
                    document.getElementById('<%= txtNoOfDays.ClientID %>').value = diffDays;
                else
                    document.getElementById('<%= txtNoOfDays.ClientID %>').value = "";
            }          

        }
    </script>
</asp:Content>
    
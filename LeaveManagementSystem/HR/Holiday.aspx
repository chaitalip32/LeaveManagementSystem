<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="Holiday.aspx.cs" Inherits="LeaveManagementSystem.HR.Holiday" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /*  BUTTON  */
 
        .form-card{
            background:white;
        }
        .btn-theme 
        {
            background-color: #E2A63A;
            border-color: #E2A63A;
            color: white;
        }

        .btn-theme:hover {
            background-color: #F9B12B;
            border-color: #F9B12B;
            color: white;
        }

        .btn-purple {
            background-color: #773CA2;
            border-color: #773CA2;
            color: white;
        }

        .btn-purple:hover {
            background-color: #6A3394;
            border-color: #6A3394;
            color: white;
        }

        /*css of NewApply Leave form*/
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
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        
        
    <div class="container mt-3">

            <div class="row justify-content-center">

                <div class="col-lg-10 col-md-11 col-sm-12">
                    <asp:ValidationSummary 
                        ID="ValidationSummary1" 
                        runat="server" 
                        CssClass="alert alert-danger"
                        HeaderText="Please fill the following fields:"
                        ValidationGroup="HolidayForm"/>

                    <h4 class="mb-4 fw-semibold text-center">Add Holiday</h4>

                    <div class="form-card shadow p-5">

                    <div class="card-body">
                        <div class="row g-4">

                            <!--Leave type-->
                            <div class="col-md-6">
                                <label class="form-label">Holiday Name <span class="required">*</span></label>
                                <asp:TextBox ID="txtHolidayName" 
                                    runat="server"
                                    CssClass="form-control"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="rfvSubject" 
                                    runat="server" 
                                    InitialValue=""
                                    CssClass="text-danger"
                                    ErrorMessage="Holiday name is required"
                                    ValidationGroup="HolidayForm"
                                    ControlToValidate="txtHolidayName"></asp:RequiredFieldValidator>
                            </div>

                            <!--Holiday Date-->
                            
                                <div class="col-md-6">
                                    <label class="form-label" runat="server">Holiday Date <span class="required">*</span></label>
                                    <asp:TextBox ID="txtHolidayDate" runat="server" 
                                        CssClass="form-control"></asp:TextBox>

                                    <ajaxToolkit:CalendarExtender 
                                        ID="calHolidayDate"
                                        runat="server"
                                        TargetControlId="txtHolidayDate"
                                        Format="yyyy-MM-dd"
                                        StartDate="<%# DateTime.Today %>"/>
                        
                                    <asp:RequiredFieldValidator 
                                        Id="rfvFromDate"
                                        runat="server"
                                        ControlToValidate="txtHolidayDate"
                                        CssClass="text-danger"
                                        ErrorMessage="Date is required"
                                        ValidationGroup="HolidayForm"
                                        StartDate="<%# DateTime.Today %>"/>
                                </div>

                            <!--Description-->
                            <div class="col-md-12">
                                <label class="form-label" runat="server">Description <span class="required">*</span></label>
                                <asp:TextBox ID="txtDescription" 
                                    runat="server" 
                                    TextMode="MultiLine" 
                                    Rows="3"
                                    CssClass="form-control"></asp:TextBox>

                                <asp:RequiredFieldValidator 
                                    Id="rfvReason"
                                    runat="server"
                                    ControlToValidate="txtDescription"
                                    CssClass="text-danger"
                                    ErrorMessage="Description is required"
                                    ValidationGroup="HolidayForm"/>
                            </div>

                            <div class="col-md-12">
                                <label class="form-label" runat="server">Status</label>
                                <asp:RadioButtonList ID="rblStatus" 
                                    runat="server"
                                    RepeatDirection="Horizontal"
                                    CssClass="d-flex gap-3">

                                    <asp:ListItem Text="Active" Value="1" Selected="True" class="me-4"></asp:ListItem>
                                    <asp:ListItem Text="Deactive" Value="0"></asp:ListItem>

                                </asp:RadioButtonList>
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
                            ValidationGroup="LeaveForm" OnClick="btnSubmit_Click"/>

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

        document.addEventListener("DOMContentLoaded", function () {

            let today = new Date().toISOString().split('T')[0];

            document.getElementById('<%= txtHolidayDate.ClientID%>').setAttribute("min", today);
        });

    </script>
</asp:Content>
    
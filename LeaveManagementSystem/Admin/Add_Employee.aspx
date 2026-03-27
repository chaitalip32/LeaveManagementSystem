<%@ Page Language="C#" 
    MasterPageFile="~/Site.master" 
    AutoEventWireup="true" 
    CodeBehind="Add_Employee.aspx.cs"
    Inherits="LeaveManagementSystem.Admin.Add_Employee" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div>

        <h4 class="mb-4 fw-semibold text-center">Add New Employee</h4>

        <!-- Account Information -->
        <div class="card shadow-sm mb-4">
            <div class="card-header card-header-theme">
                Account Information
            </div>
            <div class="card-body">
                <div class="row g-3">

                    <div class="col-md-6">
                        <label class="form-label">Email <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtxtEmail" runat="server"
                            ControlToValidate="txtEmail"
                            CssClass="text-danger"
                            Display="None"
                            ErrorMessage="Email is required"
                           />

                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
                            ControlToValidate="txtEmail"
                            CssClass="text-danger"
                            Display="None"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ErrorMessage="Invalid email format"
                             />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Role<span class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select"></asp:DropDownList>
                        <asp:RequiredFieldValidator 
                            ID="rfvddlRole" 
                            runat="server"
                            ControlToValidate="ddlRole"
                            InitialValue=""
                            CssClass="text-danger"
                            Display="None"
                            ErrorMessage="Role is required"
                           />
                    </div>
 
                </div>
            </div>
        </div>

        <!-- Job Information-->
        <div class="card shadow-sm mb-4">
            <div class="card-header card-header-theme">
                Job Information
            </div>
            <div class="card-body">
                <div class="row g-3"> <!--gutter spacing between columns and rows, without g-3 fields will stuck together-->
                    <div class="col-md-6">
                        <label class="form-label">Department<span class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select"></asp:DropDownList>

                        <asp:RequiredFieldValidator 
                            ID="rfvDepartment" 
                            runat="server" 
                            ControlToValidate="ddlDepartment"
                            InitialValue=""
                            ErrorMessage="Please select the Department"
                            CssClass="text-danger"
                            Display="None"
                            >
                        </asp:RequiredFieldValidator>
                    </div> 

                    <div class="col-md-6">
                        <label class="form-label">Manager <span class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlManager" runat="server" CssClass="form-select"></asp:DropDownList>
                        
                        <asp:RequiredFieldValidator 
                            ID="rfvManager" runat="server"
                            ControlToValidate="ddlManager"
                            InitialValue=""
                            CssClass="text-danger"
                            Display="None"
                            ErrorMessage="Please select the Manager"
                            />
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">Employee Code<span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtEmployeeCode" runat="server" CssClass="form-control"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator 
                            ID="rfvEmployeeCode" runat="server"
                            ControlToValidate="txtEmployeeCode"
                            CssClass="text-danger"
                            Display="None"
                            ErrorMessage="Employee Code is required" />
                    </div> 
                    
                    <div class="col-md-6">
                        <label class="form-label">Date of Joining<span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtDOJ" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        
                        <ajaxToolkit:CalendarExtender 
                            ID="calFromDate" runat="server"
                            TargetControlId="txtDOJ" 
                            Format="yyyy-MM-dd" />

                        <asp:RequiredFieldValidator Id="rfvFromDate" runat="server"
                             ControlToValidate="txtDOJ"
                             CssClass="text-danger"
                             Display="None"
                             ErrorMessage="Date of Joining is required"
                        />                  

                        
                        <asp:RequiredFieldValidator 
                            ID="rfvDOJ" 
                            runat="server"
                            ControlToValidate="txtDOJ"
                            CssClass="text-danger"
                            Display="None"
                            ErrorMessage="Date of Joining is required"
                            />
                    </div> 

                </div>
            </div>
        </div>

        <div class="card shadow-sm mb-4">
            <div class="card-header card-header-theme">
                Personal Information
            </div>
            <div class="card-body">
                <div class="row g-3"> <!--gutter spacing between columns and rows, without g-3 fields will stuck together-->
                    <div class="col-md-6">
                        <label class="form-label">First Name<span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator 
                            ID="rfvFirstName" 
                            runat="server"
                            ControlToValidate="txtFirstName"
                            CssClass="text-danger"
                            Display="None"
                            ErrorMessage="First Name is required"
                            />
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">Last Name<span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                    
                        <asp:RequiredFieldValidator ID="rfvlastName" runat="server"
                            ControlToValidate="txtLastName"
                            CssClass="text-danger"
                            Display="None"
                            ErrorMessage="Last Name is required"
                            />
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">Gender<span class="text-danger">*</span></label>
                        <asp:RadioButtonList ID="rblgender" runat="server" 
                            RepeatDirection="Horizontal" 
                            RepeatLayout="Flow" 
                            CssClass="custom-rbl">
                            <asp:ListItem Text="Male" Value="Male" class="me-4"></asp:ListItem>
                            <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                        </asp:RadioButtonList>
    
                        <asp:RequiredFieldValidator ID="rfvGender" runat="server"
                            ControlToValidate="rblgender"
                            CssClass="text-danger"
                            Display="None"
                            ErrorMessage="Please select the gender"
                            />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Date of Birth<span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    
                        <ajaxToolkit:CalendarExtender 
                            ID="CalendarExtender1" runat="server"
                            TargetControlId="txtDOB" 
                            Format="yyyy-MM-dd" />
                 
                        <asp:RequiredFieldValidator ID="rfvDOB" runat="server"
                            ControlToValidate="txtDOB"
                            CssClass="text-danger"
                            Display="None"
                            ErrorMessage="Date of Birth is required"
                            />
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">Phone<span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>

                        <asp:RequiredFieldValidator 
                            ID="rfvPhone" 
                            runat="server" 
                            ControlToValidate="txtPhone"
                            ErrorMessage="Phone is required"
                            CssClass="text-danger"
                            Display="None"
                           >
                        </asp:RequiredFieldValidator>

                        <asp:RegularExpressionValidator 
                            ID="rgvPhone" 
                            runat="server" 
                            ControlToValidate="txtPhone"
                            ErrorMessage="Enter valid 10 digit phone number"
                            CssClass="text-danger"
                            Display="None"                           
                            ValidationExpression="^[0-9]{10}$"
                            ></asp:RegularExpressionValidator>
                    </div> 
                    <!--
                    <div class="col-md-6">
                        <label class="form-label required">Aadhar Number</label>
                        <asp:TextBox ID="txtAadhar" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>--> 
                    <div class="col-md-12">
                        <label class="form-label">Address<span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    
                        <asp:RequiredFieldValidator 
                            ID="rfvAddress" 
                            runat="server"
                            ControlToValidate="txtAddress"
                            CssClass="text-danger"
                            Display="None"
                            ErrorMessage="Address is required"
                            />
                    </div> 

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">State<span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlState" 
                                    runat="server" 
                                    CssClass="form-select"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                                </asp:DropDownList>             
                                <asp:RequiredFieldValidator 
                                    ID="rfvState" 
                                    runat="server"
                                    ControlToValidate="ddlState"
                                    InitialValue="0"
                                    CssClass="text-danger"
                                    Display="None"
                                    ErrorMessage="Please select the state"
                                    />
                            </div> 

                            <div class="col-md-6">
                                <label class="form-label">City<span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlCity" runat="server" 
                                    CssClass="form-select"></asp:DropDownList>
                    
                                <asp:RequiredFieldValidator 
                                    ID="rfvCity" 
                                    runat="server"
                                    ControlToValidate="ddlCity"
                                    InitialValue="0"
                                    CssClass="text-danger"
                                    Display="None"
                                    ErrorMessage="Please select the City"
                                    />
                            </div> 
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

         <!-- Documents-->
         <div class="card shadow-sm mb-4">
            <div class="card-header card-header-theme">
                Documents
            </div>
            <div class="card-body">
                <div class="row g-3"> <!--gutter spacing between columns and rows, without g-3 fields will stuck together-->
                    <div class="col-md-6">
                        <label class="form-label">Profile Image<span class="text-danger">*</span></label>
                        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control"/>
                    
                        <asp:RequiredFieldValidator 
                            ID="rfvProfileImage" runat="server"
                            ControlToValidate="FileUpload1"
                            CssClass="text-danger"
                            Display="None"
                            ErrorMessage="Profile Image is required"
                            />
                    </div> 
                    <!--div class="col-md-6">
                        <label class="form-label">Aadhar Image</label>
                        <asp:FileUpload ID="FileUpload2" runat="server" CssClass="form-control"/>
                    </!--div--> 
 
                </div>
            </div>
        </div>

        <!-- Buttons -->
        <div class="text-end mb-5">
            <asp:ValidationSummary 
                ID="EmployeeForm" 
                runat="server" 
                ShowSummary="false" 
                ShowMessageBox="true" 
                HeaderText="Please correct the following errors:" 
                CssClass="text-danger" />

            <asp:Button ID="btnSave" runat="server"
                Text="Save"            
                CssClass="btn btn-theme px-4 me-2" OnClick="btnSave_Click" />

            <asp:Button ID="btnCancel" runat="server"
                Text="Cancel"
                CssClass="btn btn-secondary px-4"
                CausesValidation="false" />
        </div>

    </div>

</asp:Content>
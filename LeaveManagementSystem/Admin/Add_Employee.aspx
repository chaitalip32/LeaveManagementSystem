<%@ Page Language="C#" 
    MasterPageFile="~/Admin/AdminMaster.master" 
    AutoEventWireup="true" 
    CodeBehind="Add_Employee.aspx.cs"
    Inherits="LeaveManagementSystem.Admin.Add_Employee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid">

        <asp:ValidationSummary 
            ID="ValidationSummary1" 
            runat="server"
            CssClass="alert alert-danger"
            HeaderText="Please fix the following errors:"
            ValidationGroup="EmployeeForm" />

        <h4 class="mb-4 fw-semibold text-center">Add New Employee</h4>

        <!-- Account Information -->
        <div class="card shadow-sm mb-4">
            <div class="card-header card-header-theme">
                Account Information
            </div>
            <div class="card-body">
                <div class="row g-3">

                    <div class="col-md-6">
                        <label class="form-label required">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                            ControlToValidate="txtUsername"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Username is required"
                            ValidationGroup="EmployeeForm" />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label required">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtxtEmail" runat="server"
                            ControlToValidate="txtEmail"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Email is required"
                            ValidationGroup="EmployeeForm" />

                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
                            ControlToValidate="txtEmail"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ErrorMessage="Invalid email format"
                            ValidationGroup="EmployeeForm" />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label required">Role</label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select"></asp:DropDownList>
                        <asp:RequiredFieldValidator 
                            ID="rfvddlRole" 
                            runat="server"
                            ControlToValidate="ddlRole"
                            InitialValue=""
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Role is required"
                            ValidationGroup="EmployeeForm" />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label required">Temporary Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator 
                            ID="rfvPassword"
                            runat="server"
                            ControlToValidate="txtPassword"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Password is required"
                            ValidationGroup="EmployeeForm" />
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
                        <label class="form-label required">Department<span class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select"></asp:DropDownList>

                        <asp:RequiredFieldValidator 
                            ID="rfvDepartment" 
                            runat="server" 
                            ControlToValidate="ddlDepartment"
                            InitialValue=""
                            ErrorMessage="Please select the Department"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="EmployeeForm">
                        </asp:RequiredFieldValidator>
                    </div> 

                    <div class="col-md-6">
                        <label class="form-label required">Manager</label>
                        <asp:DropDownList ID="ddlManager" runat="server" CssClass="form-select"></asp:DropDownList>
                        
                        <asp:RequiredFieldValidator 
                            ID="rfvManager" runat="server"
                            ControlToValidate="ddlManager"
                            InitialValue=""
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Please select the Manager"
                            ValidationGroup="EmployeeForm" />
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label required">Employee Code</label>
                        <asp:TextBox ID="txtEmployeeCode" runat="server" CssClass="form-control"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator 
                            ID="rfvEmployeeCode" runat="server"
                            ControlToValidate="txtEmployeeCode"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Employee Code is required"
                            ValidationGroup="EmployeeForm" />
                    </div> 
                    
                    <div class="col-md-6">
                        <label class="form-label required">Date of Joining</label>
                        <asp:TextBox ID="txtDOJ" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator 
                            ID="rfvDOJ" 
                            runat="server"
                            ControlToValidate="txtDOJ"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Date of Joining is required"
                            ValidationGroup="EmployeeForm" />
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
                        <label class="form-label required">First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator 
                            ID="rfvFirstName" 
                            runat="server"
                            ControlToValidate="txtFirstName"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="First Name is required"
                            ValidationGroup="EmployeeForm" />
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label required">Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                    
                        <asp:RequiredFieldValidator ID="rfvlastName" runat="server"
                            ControlToValidate="txtLastName"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Last Name is required"
                            ValidationGroup="EmployeeForm" />
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label required">Gender</label>
                        <asp:RadioButtonList ID="rblgender" runat="server" RepeatDirection="Horizontal" 
                            CssClass="d-flex gap-3">
                            <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                            <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                        </asp:RadioButtonList>
                    
                        <asp:RequiredFieldValidator ID="rfvGender" runat="server"
                            ControlToValidate="rblgender"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Please select the gender"
                            ValidationGroup="EmployeeForm" />
                    </div> 

                    <div class="col-md-6">
                        <label class="form-label required">Date of Birth</label>
                        <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    
                        <asp:RequiredFieldValidator ID="rfvDOB" runat="server"
                            ControlToValidate="txtDOB"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Date of Birth is required"
                            ValidationGroup="EmployeeForm" />
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label required">Phone</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>

                        <asp:RequiredFieldValidator 
                            ID="rfvPhone" 
                            runat="server" 
                            ControlToValidate="txtPhone"
                            ErrorMessage="Phone is required"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="EmployeeForm">
                        </asp:RequiredFieldValidator>

                        <asp:RegularExpressionValidator 
                            ID="rgvPhone" 
                            runat="server" 
                            ControlToValidate="txtPhone"
                            ErrorMessage="Enter valid 10 digit phone number"
                            CssClass="text-danger"
                            Display="Dynamic"                           
                            ValidationExpression="^[0-9]{10}$"
                            ValidationGroup="EmployeeForm"></asp:RegularExpressionValidator>
                    </div> 
                    <!--
                    <div class="col-md-6">
                        <label class="form-label required">Aadhar Number</label>
                        <asp:TextBox ID="txtAadhar" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>--> 
                    <div class="col-md-12">
                        <label class="form-label required">Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    
                        <asp:RequiredFieldValidator 
                            ID="rfvAddress" 
                            runat="server"
                            ControlToValidate="txtAddress"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Address is required"
                            ValidationGroup="EmployeeForm" />
                    </div> 

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>

                            <div class="col-md-6">
                                <label class="form-label required">State</label>
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
                                    Display="Dynamic"
                                    ErrorMessage="Please select the state"
                                    ValidationGroup="EmployeeForm" />
                            </div> 

                            <div class="col-md-6">
                                <label class="form-label required">City</label>
                                <asp:DropDownList ID="ddlCity" runat="server" 
                                    CssClass="form-select"></asp:DropDownList>
                    
                                <asp:RequiredFieldValidator 
                                    ID="rfvCity" 
                                    runat="server"
                                    ControlToValidate="ddlCity"
                                    InitialValue="0"
                                    CssClass="text-danger"
                                    Display="Dynamic"
                                    ErrorMessage="Please select the City"
                                    ValidationGroup="EmployeeForm" />
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
                        <label class="form-label required">Profile Image</label>
                        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control"/>
                    
                        <asp:RequiredFieldValidator 
                            ID="rfvProfileImage" runat="server"
                            ControlToValidate="FileUpload1"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Profile Image is required"
                            ValidationGroup="EmployeeForm" />
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
            <asp:Button ID="btnSave" runat="server"
                Text="Save Employee"
                ValidationGroup="EmployeeForm"
                CssClass="btn btn-theme px-4 me-2" />

            <asp:Button ID="btnCancel" runat="server"
                Text="Cancel"
                CssClass="btn btn-secondary px-4"
                CausesValidation="false" />
        </div>

    </div>

</asp:Content>
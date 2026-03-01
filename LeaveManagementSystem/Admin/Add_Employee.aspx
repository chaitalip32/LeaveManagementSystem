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
                        <label class="form-label">Username <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                            ControlToValidate="txtUsername"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="Username is required"
                            ValidationGroup="EmployeeForm" />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Email <span class="text-danger">*</span></label>
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
                        <label class="form-label">Role</label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Temporary Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
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
                            ErrorMessage="Department is required"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="EmployeeForm">
                        </asp:RequiredFieldValidator>
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">Manager</label>
                        <asp:DropDownList ID="ddlManager" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">Employee Code</label>
                        <asp:TextBox ID="txtEmployeeCode" runat="server" CssClass="form-control"></asp:TextBox>
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">Date of Joining</label>
                        <asp:TextBox ID="txtDOJ" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
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
                        <label class="form-label">First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">Gender</label>
                        <asp:RadioButtonList ID="rblgender" runat="server" RepeatDirection="Horizontal" 
                            CssClass="d-flex gap-3">
                            <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                            <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">Date of Birth</label>
                        <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">Phone</label>
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
                            ID="RegularExpressionValidator2" 
                            runat="server" 
                            ControlToValidate="txtPhone"
                            ErrorMessage="Enter valid 10 digit phone number"
                            CssClass="text-danger"
                            Display="Dynamic"                           
                            ValidationExpression="^[0-9]{10}$"
                            ValidationGroup="EmployeeForm"></asp:RegularExpressionValidator>
                    </div> 

                    <!--div class="col-md-6">
                        <label class="form-label">Aadhar Number</label>
                        <asp:TextBox ID="txtAadhar" runat="server" CssClass="form-control"></asp:TextBox>
                    </!--div--> 
                    <div class="col-md-12">
                        <label class="form-label">Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">State</label>
                        <asp:DropDownList ID="txtState" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div> 
                    <div class="col-md-6">
                        <label class="form-label">City</label>
                        <asp:DropDownList ID="txtCity" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div> 

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
                        <label class="form-label">Profile Image</label>
                        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control"/>
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
                CssClass="btn btn-primary px-4 me-2" />

            <asp:Button ID="btnCancel" runat="server"
                Text="Cancel"
                CssClass="btn btn-secondary px-4"
                CausesValidation="false" />
        </div>

    </div>

</asp:Content>
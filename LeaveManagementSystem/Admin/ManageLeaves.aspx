<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="ManageLeaves.aspx.cs" Inherits="LeaveManagementSystem.Admin.ManageLeaves" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Label 
         ID="lblMessage" 
         runat="server" 
         Visible="false">
    </asp:Label>

    <div class="card shadow-sm mb-4">
        
        <div class="card-header card-header-theme">
            Add Leave Type
        </div>

        <div class="card-body">
            <asp:ValidationSummary 
                ID="ValidationSummary1" 
                runat="server"
                CssClass="alert alert-danger"
                HeaderText="Please fix the following errors"
                ValidationGroup="LeaveTypeForm" />

            <div class="row g-3">

                <!-- Leave Type Name-->
                <div class="col-md-6">
                    <label class="form-label required">Leave Type Name</label>
                    <asp:TextBox ID="txtLeaveType" 
                        runat="server"
                        CssClass="form-control">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator 
                        ID="rfvLeaveType" 
                        runat="server" 
                        ControlToValidate="txtLeaveType"
                        CssClass="text-danger"
                        Display="Dynamic"
                        ErrorMessage="Leave type name is required"
                        ValidationGroup="LeaveTypeForm">
                    </asp:RequiredFieldValidator>
                </div>

                <!-- Default Days-->
                <div class="col-md-6">
                    <label class="form-label required">Default Days</label>
                    <asp:TextBox ID="txtDefaultDays" 
                        runat="server"
                        CssClass="form-control"
                        TextMode="Number"
                        min="0">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator 
                        ID="rfvDefaultDays" 
                        runat="server" 
                        ControlToValidate="txtDefaultDays"
                        CssClass="text-danger"
                        Display="Dynamic"
                        ErrorMessage="Default Days is required"
                        ValidationGroup="LeaveTypeForm">
                    </asp:RequiredFieldValidator>

                    <asp:RangeValidator 
                        ID="rgvDefaultDays" 
                        runat="server" 
                        ControlToValidate="txtDefaultDays"
                        MinimumValue="0"
                        maximumValue="365"
                        Type="Integer"
                        CssClass="text-danger"
                        ErrorMessage="Default days must be 0 or greater"
                        ValidationGroup="LeaveTypeForm">
                    </asp:RangeValidator>
                </div>

                <!-- Description -->
                <div class="col-md-12">
                    <label class="form-label required">Description</label>
                    <asp:TextBox ID="txtDescription" 
                        runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="3">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator 
                        ID="rfvDescription" 
                        runat="server" 
                        ControlToValidate="txtDescription"
                        CssClass="text-danger"
                        Display="Dynamic"                       
                        ErrorMessage="Enter description"
                        ValidationGroup="LeaveTypeForm">
                    </asp:RequiredFieldValidator>
                </div>

                <!-- Leave Status Active or Inactive-->
                <div class="col-md-6">
                    <label class="form-label required">Status</label>
                    <asp:RadioButtonList ID="rblStatus" 
                        runat="server"
                        RepeatDirection="Horizontal"
                        CssClass="d-flex gap-3">

                        <asp:ListItem Text="Active" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>

                    </asp:RadioButtonList>
                </div>

            </div>

        </div>   
        
    </div>

    <!-- Buttons-->
    <div class="text-end mb-4">
        <asp:Button ID="btnSaveLeaveType"
            runat="server"
            Text="Save Leave Type"
            CssClass="btn btn-purple px-4 me-2"
            ValidationGroup="LeaveTypeForm" OnClick="btnSaveLeaveType_Click"/>

        <asp:Button ID="btnCancel"
            runat="server"
            Text="Cancel"
            CssClass="btn btn-secondary px-4"
            CausesValidation="false"/>
    </div>

    <!-- Search -->

    <div class="card shadow-sm mb-4">
        <div class="card-header card-header-theme">
            Search Leave Type
        </div>

        <div class="card-body">
            <div class="row g-3 align-items-center">

                <div class="col-md-4">
                    <asp:TextBox ID="txtSearchLeaveType" 
                        runat="server"
                        CssClass="form-control"
                        placeholder="Search Leave Type...">
                    </asp:TextBox>
                </div>

                <div class="col-md-3">
                    <asp:Button 
                        ID="btnSeaech" 
                        runat="server" 
                        Text="Search"
                        CssClass="btn btn-theme me-2" OnClick="btnSeaech_Click" />
                    <asp:Button 
                        ID="btnReset" 
                        runat="server" 
                        Text="Reset"
                        CssClass="btn btn-secondary" />
                </div>
            </div>
        </div>
    </div>

    <!-- Gridview Table -->
    <div class="card shadow-sm mb-4">

        <div class="card-header card-header-theme">
            Leave Types List
        </div>

        <div class="card-body">

            <asp:GridView 
                ID="gvLeaveTypes" 
                runat="server"
                AutoGenerateColumns="false"
                CssClass="table table-bordered"
                DataKeyNames="LeaveTypeId"
                EmptyDataText="No leave types found" OnRowCancelingEdit="gvLeaveTypes_RowCancelingEdit" OnRowDeleting="gvLeaveTypes_RowDeleting" OnRowEditing="gvLeaveTypes_RowEditing" OnRowUpdating="gvLeaveTypes_RowUpdating">

                <Columns>

                    <asp:TemplateField HeaderText="Leave Type">
                        <ItemTemplate>
                            <%# Eval("LeaveTypeName") %>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <asp:TextBox 
                                ID="txtEditLeaveType"
                                runat="server"
                                CssClass="form-control"
                                Text='<%# Bind("LeaveTypeName") %>'>
                            </asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Default Days">
                        <ItemTemplate>
                            <%# Eval("DefaultDays") %>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <asp:TextBox 
                                ID="txtEditDefaultDays"
                                runat="server"
                                CssClass="form-control"
                                Text='<%# Bind("DefaultDays") %>'>
                            </asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <%# Eval("Description") %>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <asp:TextBox 
                                ID="txtEditDescription"
                                runat="server"
                                CssClass="form-control"
                                Text='<%# Bind("Description") %>'>
                            </asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status">

                        <ItemTemplate>
                            <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive"%>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <asp:RadioButtonList 
                                ID="rblEditStatus"
                                runat="server"
                                RepeatDirection="Horizontal"
                                CssClass="d-flex gap-3"
                                SelectedValue='<%# Bind("IsActive") %>'>

                                <asp:ListItem Text="Active" Value="True"></asp:ListItem>
                                <asp:ListItem Text="Inactive" Value="False"></asp:ListItem>

                            </asp:RadioButtonList>

                        </EditItemTemplate>

                    </asp:TemplateField>

                    <asp:BoundField 
                        DataField="CreatedDate"
                        HeaderText="Created Date"
                        DataFormatString="{0:dd-MM-yyyy}"/>

                    <asp:TemplateField HeaderText="Action">

                    <ItemTemplate>

                        <asp:LinkButton 
                            ID="btnEdit"
                            runat="server"
                            Text="Edit"
                            CssClass="btn btn-sm btn-purple me-2"
                            CommandName="Edit"
                            CausesValidation="false" />

                        <asp:LinkButton 
                            ID="btnDelete"
                            runat="server"
                            Text="Delete"
                            CssClass="btn btn-sm btn-danger"
                            CommandName="Delete"
                            CausesValidation="false"
                            OnClientClick="return confirm('Are you sure you want to delete this leave type?');" />

                    </ItemTemplate>

                    <EditItemTemplate>

                        <asp:LinkButton 
                            ID="btnUpdate"
                            runat="server"
                            Text="Update"
                            CssClass="btn btn-sm btn-theme me-2"
                            CommandName="Update"
                            CausesValidation="false" />

                        <asp:LinkButton 
                            ID="btnCancel"
                            runat="server"
                            Text="Cancel"
                            CssClass="btn btn-sm btn-secondary"
                            CommandName="Cancel"
                            CausesValidation="false" />

                    </EditItemTemplate>

                    </asp:TemplateField>
                </Columns>
                
            </asp:GridView>

        </div>
    </div>
</asp:Content>

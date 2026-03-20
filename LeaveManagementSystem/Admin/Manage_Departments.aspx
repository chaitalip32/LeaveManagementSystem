<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="Manage_Departments.aspx.cs" Inherits="LeaveManagementSystem.Admin.Manage_Departments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid">

    <h3 class="mb-4">Manage Departments</h3>

    <!-- Add Button -->
    <asp:Button ID="btnAddNew" runat="server"
        Text="Add Department"
        CssClass="btn btn-success mb-3"
        OnClientClick="openAddModal(); return false;" />

    <!-- Message -->
    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-2"></asp:Label>

    <!-- Grid -->
    <asp:GridView ID="gvDepartments" runat="server"
        CssClass="table table-bordered table-hover"
        AutoGenerateColumns="False"
        DataKeyNames="DepartmentId"
        OnRowCommand="gvDepartments_RowCommand"
        OnRowDeleting="gvDepartments_RowDeleting">

        <Columns>

            <asp:BoundField DataField="DepartmentId" HeaderText="ID" />

            <asp:BoundField DataField="DepartmentName" HeaderText="Department Name" />

            <asp:BoundField DataField="Description" HeaderText="Description" />

            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>

                    <asp:LinkButton ID="btnEdit" runat="server"
                        CommandName="EditDept"
                        CommandArgument='<%# Eval("DepartmentId") %>'
                        CssClass="btn btn-primary btn-sm me-2">
                        Edit
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnDelete" runat="server"
                        CommandName="Delete"
                        CssClass="btn btn-danger btn-sm"
                        OnClientClick="return confirm('Delete this department?');">
                        Delete
                    </asp:LinkButton>

                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</div>

<!--  Modal -->
<div class="modal fade" id="deptModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Department</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">

        <asp:HiddenField ID="hfDepartmentId" runat="server" />

        <div class="mb-3">
            <asp:TextBox ID="txtDeptName" runat="server"
                CssClass="form-control"
                placeholder="Department Name"></asp:TextBox>
        </div>

        <div class="mb-3">
            <asp:TextBox ID="txtDeptDesc" runat="server"
                CssClass="form-control"
                placeholder="Description"></asp:TextBox>
        </div>

      </div>

      <div class="modal-footer">
        <asp:Button ID="btnSave" runat="server"
            Text="Save"
            CssClass="btn btn-success"
            OnClick="btnSave_Click" />

        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            Cancel
        </button>
      </div>

    </div>
  </div>
</div>

<!-- JS -->
<script>
function openAddModal() {
    document.getElementById('<%= hfDepartmentId.ClientID %>').value = "";
    document.getElementById('<%= txtDeptName.ClientID %>').value = "";
    document.getElementById('<%= txtDeptDesc.ClientID %>').value = "";

    $('#deptModal').modal('show');
}
</script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
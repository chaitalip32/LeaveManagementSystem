<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LeaveApprovalForm.aspx.cs" Inherits="LeaveManagementSystem.Manager.LeaveApprovalForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">


    <title>Leave Management System</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

    <style>
        .form-control{
            border-radius: 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <div class="modal fade" id="leaveModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">

    <div class="modal-content">

        <!-- Header -->
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">
                <span>&times;</span>
            </button>
        </div>

        <!-- Body -->
        <div class="modal-body">

            <div class="row">

                <!-- Employee Name -->
                <div class="col-md-6 mb-3">
                    <label>Employee Name</label>
                    <asp:TextBox ID="txtEmployeeName"
                        runat="server"
                        CssClass="form-control"
                        ReadOnly="true"></asp:TextBox>
                </div>

                <!-- Department -->
                <div class="col-md-6 mb-3">
                    <label>Department</label>
                    <asp:TextBox ID="txtDepartment"
                        runat="server"
                        CssClass="form-control"
                        ReadOnly="true"></asp:TextBox>
                </div>

                <!-- Leave Type -->
                <div class="col-md-6 mb-3">
                    <label>Leave Type</label>
                    <asp:TextBox ID="txtLeaveType"
                        runat="server"
                        CssClass="form-control"
                        ReadOnly="true"></asp:TextBox>
                </div>

                <!-- Total Days -->
                <div class="col-md-6 mb-3">
                    <label>Total Days</label>
                    <asp:TextBox ID="txtTotalDays"
                        runat="server"
                        CssClass="form-control"
                        ReadOnly="true"></asp:TextBox>
                </div>

                <!-- From Date -->
                <div class="col-md-6 mb-3">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate"
                        runat="server"
                        CssClass="form-control"
                        ReadOnly="true"></asp:TextBox>
                </div>

                <!-- To Date -->
                <div class="col-md-6 mb-3">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate"
                        runat="server"
                        CssClass="form-control"
                        ReadOnly="true"></asp:TextBox>
                </div>

                <!-- Reason -->
                <div class="col-md-12 mb-3">
                    <label>Reason</label>
                    <asp:TextBox ID="txtReason"
                        runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="3"
                        ReadOnly="true"></asp:TextBox>
                </div>

                <!-- Manager Comment -->
                <div class="col-md-12 mb-3">
                    <label>Manager Comment</label>
                    <asp:TextBox ID="txtManagerComment"
                        runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="3"
                        placeholder="Enter your comment"></asp:TextBox>
                </div>

                <!-- Status -->
                <div class="col-md-6 mb-3">
                    <label>Status</label>
                    <asp:DropDownList ID="ddlStatus"
                        runat="server"
                        CssClass="form-control">
                        <asp:ListItem Value="">Select Status</asp:ListItem>
                        <asp:ListItem Value="Approved">Approve</asp:ListItem>
                        <asp:ListItem Value="Rejected">Reject</asp:ListItem>
                    </asp:DropDownList>
                </div>

            </div>

            <!-- Hidden LeaveId -->
            <asp:HiddenField ID="hfLeaveId" runat="server" />

        </div>

        <!-- Footer -->
        <div class="modal-footer">

            <asp:Button ID="btnUpdate"
                runat="server"
                Text="Update"
                CssClass="btn btn-success"
                 />

            <button type="button"
                class="btn btn-secondary"
                data-dismiss="modal">
                Cancel
            </button>

        </div>

    </div>

</div>


</div>
    </form>

    <script>
        $(document).ready(function(){
            $('#leaveModal').modal('show');
        });
    </script>
</body>
</html>

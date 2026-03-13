<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManagerLeaveRequests.aspx.cs" Inherits="LeaveManagementSystem.Manager.ManagerLeaveRequests" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manager Leave Requests</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

    <style>

        h3{
            font-weight:600;
            font-size:18px;
            text-align:center;
        }

        .table th{
            background:#343a40;
            color:white;
            text-align:center;
        }

        .table td{
            vertical-align:middle;
        }

        .reason-col{
            max-width:250px;
            white-space:nowrap;
            overflow:hidden;
            text-overflow:ellipsis;
        }

        .form-control{
            border: 0;
        }
    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container mt-5">


        <h3>Pending Leave Requests</h3>

            <div class="table-responsive">

                <asp:GridView ID="gvLeaveRequests" runat="server"
                    AutoGenerateColumns="false"
                    CssClass="table table-bordered table-hover"
                    EmptyDataText="No leave requests found" OnRowCommand="gvLeaveRequests_RowCommand">

                    <Columns>

                        <asp:BoundField DataField="EmployeeName" HeaderText="Employee" />

                        <asp:BoundField DataField="DepartmentName" HeaderText="Department" />

                        <asp:BoundField DataField="LeaveTypeName" HeaderText="Leave Type" />

                        <asp:BoundField DataField="DayType" HeaderText="Duration" />                       

                        <asp:BoundField DataField="FromDate"
                            HeaderText="From Date"
                            DataFormatString="{0:dd-MMM-yyyy}" />

                        <asp:BoundField DataField="ToDate"
                            HeaderText="To Date"
                            DataFormatString="{0:dd-MMM-yyyy}" />

                        <asp:BoundField DataField="TotalDays"
                            HeaderText="Days" />

                        <asp:TemplateField HeaderText="Reason">
                            <ItemTemplate>
                                <span class="reason-col">
                                    <%# Eval("Reason") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status">

                            <ItemTemplate>

                                <span><%# Eval("Status") %></span>

                                <asp:LinkButton ID="btnEditStatus"
                                    runat="server"
                                    CssClass="btn btn-sm btn-primary ml-2"
                                    CommandName="EditStatus"
                                    CommandArgument='<%# Eval("LeaveApplicationId") %>'>
                                    Update
                                </asp:LinkButton>

                            </ItemTemplate>
                         </asp:TemplateField>

                    </Columns>

                </asp:GridView>
    </div>
</div>

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
            <asp:HiddenField ID="hfLeaveRequestId" runat="server" />

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
</form>

</body>
</html>
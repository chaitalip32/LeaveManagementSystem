<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeaveRequests.aspx.cs" Inherits="LeaveManagementSystem.Common.LeaveRequests" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
<style>

            .custom-table {
                border-radius: 10px;
                overflow: hidden;
                background: #ffffff;
            }

            /* HEADER */
            .custom-table th {
                background: #1f2937;
                color: #fff;
                font-weight: 600;
                text-align: left;
                padding: 12px;
                font-size: 14px;
            }

            /* ROWS */
            .custom-table td {
                padding: 12px;
                vertical-align: middle;
                font-size: 14px;
                border-top: 1px solid #f1f5f9;
            }

            /* HOVER */
            .custom-table tbody tr:hover {
                background: #f9fafb;
                transition: 0.2s;
            }

            /* REASON COLUMN */
            .reason-col {
                max-width: 180px;
                display: inline-block;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            /* BADGE */
            .badge {
                font-size: 12px;
                padding: 6px 10px;
                border-radius: 20px;
            }

            /* ACTION BUTTON */
            .action-btn {
                margin-left: 10px;
                color: #2563eb;
                font-size: 14px;
            }

            .action-btn:hover {
                color: #1d4ed8;
            }

            /* CARD LOOK */
            .table-responsive {
                background: #fff;
                padding: 15px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            }

            @media (max-width: 768px) {

                .custom-table thead {
                    display: none;
                }

                .custom-table,
                .custom-table tbody,
                .custom-table tr,
                .custom-table td {
                    display: block;
                    width: 100%;
                }

                .custom-table tr {
                    margin-bottom: 15px;
                    background: #fff;
                    border-radius: 10px;
                    padding: 10px;
                    box-shadow: 0 3px 8px rgba(0,0,0,0.05);
                }

                .custom-table td {
                    text-align: right;
                    padding-left: 50%;
                    position: relative;
                }

                .custom-table td::before {
                    content: attr(data-label);
                    position: absolute;
                    left: 12px;
                    top: 12px;
                    font-weight: 600;
                    color: #6b7280;
                    text-align: left;
                }
            }

            .modal {
                z-index: 3000 !important;
            }


            .modal-backdrop {
                z-index: 2500 !important;
            }

            .status-inline {
                display: flex;
                align-items: center;   /* ⭐ THIS fixes vertical alignment */
                gap: 8px;
            }

            .action-btn {
                display: flex;
                align-items: center;
                justify-content: center;
                color: #2563eb;
                font-size: 14px;
            }

            .action-btn i {
                line-height: 1;   /* removes weird icon spacing */
            }
        </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    

    <div class="container mt-3">        

       
            <h4 class="mb-4 fw-semibold text-center">Pending Leave Requests</h4>
 

                <div class="table-responsive">

                    <asp:GridView ID="gvLeaveRequests" runat="server"
                        AutoGenerateColumns="false"
                        CssClass="table custom-table"
                        EmptyDataText="No leave requests found"
                        OnRowCommand="gvLeaveRequests_RowCommand"
                        DataKeyNames="LeaveApplicationId,EmployeeName,DepartmentName,LeaveTypeName,FromDate,ToDate,TotalDays,Reason">

                        <Columns>

                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee" />
                            <asp:BoundField DataField="DepartmentName" HeaderText="Department" />
                            <asp:BoundField DataField="LeaveTypeName" HeaderText="Leave Type" />
                            <asp:BoundField DataField="DayType" HeaderText="Duration" />

                            <asp:BoundField DataField="FromDate"
                                HeaderText="From"
                                DataFormatString="{0:dd MMM yyyy}" />

                            <asp:BoundField DataField="ToDate"
                                HeaderText="To"
                                DataFormatString="{0:dd MMM yyyy}" />

                            <asp:BoundField DataField="TotalDays" HeaderText="Days" />
 
                            <asp:TemplateField HeaderText="Reason">
                                <ItemTemplate>
                                    <span class="reason-col" title='<%# Eval("Reason") %>'>
                                        <%# Eval("Reason") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>

                                    <div class="status-inline">

                                        <span class='badge 
                                            <%# Eval("Status").ToString() == "Approved" ? "bg-success" :
                                                Eval("Status").ToString() == "Rejected" ? "bg-danger" :
                                                "bg-warning text-dark" %>'>

                                            <%# Eval("Status") %>
                                        </span>

                                        <asp:LinkButton ID="btnEditStatus"
                                            runat="server"
                                            CssClass="action-btn"
                                            CommandName="EditStatus"
                                            CommandArgument='<%# Eval("LeaveApplicationId") %>'>

                                            <i class="fa fa-pen"></i>
                                        </asp:LinkButton>

                                    </div>

                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
        </div>
    </div>

        <div class="modal fade" id="leaveModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <div class="modal-header">
                        <h5 class="modal-title">Update Leave</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
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
                                <label>Comment</label>
                                <asp:TextBox ID="txtManagerComment"
                                    runat="server"
                                    CssClass="form-control border"
                                    TextMode="MultiLine"
                                    Rows="3"
                                    placeholder="Enter your comment"></asp:TextBox>
                            </div>

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

                    <div class="modal-footer">
                        <asp:Button ID="btnUpdate" runat="server"
                            Text="Update"
                            CssClass="btn btn-success"
                            OnClick="btnUpdate_Click" />

                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            Cancel
                        </button>
                    </div>

            </div>
        </div>
</div>

</asp:Content>

        

        

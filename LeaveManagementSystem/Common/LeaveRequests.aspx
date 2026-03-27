<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeaveRequests.aspx.cs" Inherits="LeaveManagementSystem.Common.LeaveRequests" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <style>

    .table-responsive {
        background: #fff;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.02);
        border: 1px solid #eef2f7;
        overflow-x: hidden !important; 
    }

    .custom-table {
        border-collapse: separate;
        border-spacing: 0;
        width: 100% !important;
        margin-bottom: 0;
    }

    .custom-table th {
        background: #1f2937;
        color: #fff;
        font-weight: 600;
        text-align: left;
        padding: 12px;
        font-size: 14px;
    }

    .custom-table td {
        padding: 16px;
        vertical-align: middle;
        color: #1e293b;
        border-top: 1px solid #f1f5f9;
    }


    .status-container {
        display: flex;
        align-items: center;
        justify-content: space-between; 
        width: 100%;
        min-width: 140px;
    }

    .badge {
        padding: 6px 12px;
        border-radius: 6px;
        font-weight: 500;
        font-size: 11px;
    }

    .bg-pending { 
        background: #fef3c7 !important; 
        color: #92400e !important; 
    }
    .bg-approved { 
        background: #dcfce7 !important; 
        color: #166534 !important; 
    }
    .bg-rejected { 
        background: #fee2e2 !important; 
        color: #991b1b !important; 
    }

    .action-btn {
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        /*background: #f1f5f9;*/
        color: #2563eb;
        border-radius: 8px;
        transition: 0.2s;
    }

    @media (max-width: 992px) {
        .table-responsive {
            padding: 5px !important;
            border: none;
            box-shadow: none;
            background: transparent;
            overflow-x: hidden !important;
        }

        .custom-table thead, 
        .custom-table tr:first-child, 
        .custom-table th { 
            display: none !important; 
            visibility: hidden !important;
            opacity: 0 !important;
            height: 0 !important;
            width: 0 !important;
            padding: 0 !important;
            margin: 0 !important;
            border: none !important;
        }
        
        .custom-table, .custom-table tbody, .custom-table tr {
            display: block !important;
            width: 100% !important;
        }

        .custom-table tr {
            margin-bottom: 1.5rem !important;
            border: 1px solid #e2e8f0 !important;
            border-radius: 12px !important;
            padding: 10px !important;
            background: #ffffff !important;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05) !important;
            box-sizing: border-box !important;
        }

        .custom-table td {
            display: flex !important; 
            justify-content: flex-end !important; 
            align-items: center;
            text-align: right !important;
            padding: 12px 12px 12px 45% !important; 
            position: relative !important;
            border: none !important;
            border-bottom: 1px solid #f8fafc !important;
            min-height: 45px;
            box-sizing: border-box !important;
            width: 100% !important;
        }

        .custom-table td:last-child {
            border-bottom: none !important;
        }

        .custom-table td::before {
            content: attr(data-label); 
            position: absolute;
            left: 12px;
            width: 40%; /* Label occupies the left 40% */
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            font-size: 10px;
            text-align: left;
            white-space: nowrap;
        }

        .status-container {
            justify-content: flex-end !important; 
            gap: 10px;
            width: auto !important;
            min-width: 0 !important; 
        }

        .reason-col {
            max-width: 100% !important;
            white-space: normal !important;
            text-align: right !important;
            word-wrap: break-word;
        }
    }

    .modal { z-index: 3000 !important; }
    .modal-backdrop { z-index: 2500 !important; }
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
                OnRowDataBound="gvLeaveRequests_RowDataBound"
                GridLines="None"
                DataKeyNames="LeaveApplicationId,EmployeeName,DepartmentName,LeaveTypeName,FromDate,ToDate,TotalDays,Reason">

                <Columns>
                    <asp:BoundField DataField="EmployeeName" HeaderText="Employee" />

                    <asp:BoundField DataField="LeaveTypeName" HeaderText="Leave Type" />
                    <asp:BoundField DataField="DayType" HeaderText="Duration" />
                    <asp:BoundField DataField="FromDate" HeaderText="From" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:BoundField DataField="ToDate" HeaderText="To" DataFormatString="{0:dd MMM yyyy}" />
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
                            <div class="status-container">
                                <span class='badge <%# 
                                    Eval("Status").ToString().Contains("Approved") ? "bg-approved" : 
                                    Eval("Status").ToString().Contains("Rejected") ? "bg-rejected" : "bg-pending" %>'>
                                    <%# Eval("Status") %>
                                </span>

                                <asp:LinkButton ID="btnEditStatus" runat="server"
                                    CssClass="action-btn"
                                    CommandName="EditStatus"
                                    CommandArgument='<%# Eval("LeaveApplicationId") %>'>
                                    <i class="fa fa-edit"></i>
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
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Employee Name</label>
                            <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Department</label>
                            <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                

                
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Leave Type</label>
                            <asp:TextBox ID="txtLeaveType" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                       
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Total Days</label>
                            <asp:TextBox ID="txtTotalDays" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">From Date</label>
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">To Date</label>
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-md-12 mb-3">
                            <label class="form-label">Reason</label>
                            <asp:TextBox ID="txtReason" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-md-12 mb-3">
                            <label class="form-label">Comment</label>
                            <asp:TextBox ID="txtManagerComment" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter your comment"></asp:TextBox>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Action</label>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                                <asp:ListItem Value="">Select Action</asp:ListItem>
                                <asp:ListItem Value="Approved">Approve</asp:ListItem>
                                <asp:ListItem Value="Rejected">Reject</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <asp:HiddenField ID="hfLeaveRequestId" runat="server" />
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnUpdate" runat="server" Text="Submit" CssClass="btn btn-success" OnClick="btnUpdate_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
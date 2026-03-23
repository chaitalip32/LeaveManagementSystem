<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeaveRequests.aspx.cs" Inherits="LeaveManagementSystem.Common.LeaveRequests" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
<style>

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

            .modal {
                z-index: 3000 !important;
            }


            .modal-backdrop {
                z-index: 2500 !important;
            }

        </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    

    <div class="container mt-3">        

       
            <h4 class="mb-4 fw-semibold text-center">Pending Leave Requests</h4>
 

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
                                    <asp:Label runat="server" ID="lblReason" CssClass="reason-col"
                                        Text='<%# Eval("Reason") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">

                                <ItemTemplate>

                                    <span><%# Eval("Status") %></span>

                                    <asp:LinkButton ID="btnEditStatus"
                                        runat="server"
                                        CssClass="text-primary ml-2"
                                        CommandName="EditStatus"
                                        CommandArgument='<%# Eval("LeaveApplicationId") %>'>
                                        
                                        <i class="fa fa-edit"></i>
                                    </asp:LinkButton>

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
                                <label>Comment</label>
                                <asp:TextBox ID="txtManagerComment"
                                    runat="server"
                                    CssClass="form-control border"
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

        

        

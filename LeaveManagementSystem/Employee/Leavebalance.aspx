<%@ Page Title="Leave Balance" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="LeaveBalance.aspx.cs" Inherits="LeaveManagementSystem.Employee.LeaveBalance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid mt-4">

    <!-- Page Header -->
    <div class="mb-4">
        <h4 class="mb-1">Leave Balance</h4>
        <small class="text-muted">Overview of your allocated and remaining leaves</small>
    </div>

    <div class="row">

        <asp:Repeater ID="rptLeaveBalance" runat="server">

            <ItemTemplate>

                <div class="col-lg-4 col-md-6 mb-4">

                    <div class="card shadow-sm border-0 h-100">

                        <div class="card-body">

                            <h6 class="card-title mb-3 font-weight-bold text-dark">
                                <%# Eval("LeaveTypeName") %>
                            </h6>

                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Allocated</span>
                                <span class="font-weight-bold">
                                    <%# Eval("AllocatedDays") %>
                                </span>
                            </div>

                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Used</span>
                                <span class="font-weight-bold">
                                    <%# Eval("UsedDays") %>
                                </span>
                            </div>

                            <hr class="my-2" />

                            <div class="d-flex justify-content-between">
                                <span class="text-muted">Remaining</span>
                                <span class="font-weight-bold text-success">
                                    <%# Eval("RemainingDays") %>
                                </span>
                            </div>

                        </div>

                    </div>

                </div>

            </ItemTemplate>

            <FooterTemplate>

                <asp:Panel ID="pnlNoData" runat="server" Visible='<%# rptLeaveBalance.Items.Count == 0 %>'>
                    <div class="col-12">
                        <div class="alert alert-info">
                            No leave balance information available.
                        </div>
                    </div>
                </asp:Panel>

            </FooterTemplate>

        </asp:Repeater>

    </div>

</div>

</asp:Content>
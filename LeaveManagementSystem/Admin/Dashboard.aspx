<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LeaveManagementSystem.Admin.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid">

        <!-- ================= SUMMARY CARDS ================= -->
        <div class="row g-4 mb-4">

            <!-- Total Employees -->
            <div class="col-xl-3 col-lg-6 col-md-6">
                <div class="card shadow-sm text-center p-3">
                    <h6 class="text-muted">Total Employees</h6>
                    <h3 class="fw-bold text-primary">
                        <asp:Label ID="lblTotalEmployees" runat="server" Text="0"></asp:Label>
                    </h3>
                </div>
            </div>

            <!-- Active Employees -->
            <div class="col-xl-3 col-lg-6 col-md-6">
                <div class="card shadow-sm text-center p-3">
                    <h6 class="text-muted">Active Employees</h6>
                    <h3 class="fw-bold text-success">
                        <asp:Label ID="lblActiveEmployees" runat="server" Text="0"></asp:Label>
                    </h3>
                </div>
            </div>

            <!-- Pending Leaves -->
            <div class="col-xl-3 col-lg-6 col-md-6">
                <div class="card shadow-sm text-center p-3">
                    <h6 class="text-muted">Pending Leaves</h6>
                    <h3 class="fw-bold text-warning">
                        <asp:Label ID="lblPendingLeaves" runat="server" Text="0"></asp:Label>
                    </h3>
                </div>
            </div>

            <!-- Approved Leaves -->
            <div class="col-xl-3 col-lg-6 col-md-6">
                <div class="card shadow-sm text-center p-3">
                    <h6 class="text-muted">Approved Leaves</h6>
                    <h3 class="fw-bold text-info">
                        <asp:Label ID="lblApprovedLeaves" runat="server" Text="0"></asp:Label>
                    </h3>
                </div>
            </div>

        </div>


        <!-- ================= EMPLOYEE LIST ================= -->
        <div class="card shadow-sm">
            <div class="card-header card-header-theme">
                Employee List
            </div>

            <div class="card-body">

                <div class="table-responsive">

                    <asp:GridView 
                        ID="gvEmployees" 
                        runat="server" 
                        CssClass="table table-bordered table-hover align-middle"
                        AutoGenerateColumns="False"
                        EmptyDataText="No employees found">

                        <Columns>

                            <asp:BoundField DataField="EmployeeId" HeaderText="ID" />
                            <asp:BoundField DataField="FullName" HeaderText="Name" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:BoundField DataField="Department" HeaderText="Department" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />

                        </Columns>

                        <HeaderStyle CssClass="table-light" />
                    </asp:GridView>

                </div>

            </div>
        </div>

    </div>

</asp:Content>
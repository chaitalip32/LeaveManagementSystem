<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LeaveManagementSystem.Admin.Dashboard" %>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>

        .dashboard-card{
            background: var(--card);
            padding:20px;
            border-radius:12px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.06);
            transition:0.3s;
            height:100%;
        }

        .dashboard-card:hover{
            transform:translateY(-4px);
        }

        .dashboard-card h6{
            color: var(--text-light);
            margin-bottom:10px;
        }

        .dashboard-card h3{
            font-size: 28px;
            font-weight:700;
            color: var(--text-dark);
        }

        .card-icons{
            font-size: 14px;
            font-weight:500;
        }
        .chart-container{
            background: #ffffff;
            position:relative;
            height:300px;
            width:100%;
            margin-top:20px;
            padding:15px;
            border-radius:12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.04);
        }

        @media(max-width: 768px){
            .chart-container{
                height:220px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container-fluid">
        <div class="row g-3 mt-3">

            <!--Total Days-->
            <div class="col-lg-3 col-md-6">
                <div class="dashboard-card">
                    <h6>Total Departments</h6>

                    <h3><asp:Label ID="lblTotalDepartments" runat="server" Text="0"/></h3>

                    <span class="card-icons text-primary">
                        <i class="bi bi-calendar-check"></i> Days
                    </span>
                </div>
            </div>

            <!-- Remaining days -->
            <div class="col-lg-3 col-md-6">
                <div class="dashboard-card">
                    <h6>Total Employees</h6>

                    <h3><asp:Label ID="lblTotalEmployees" runat="server" Text="0"/></h3>

                    <span class="text-primary">
                        <i class="bi bi-calendar-check"></i> Days
                    </span>
                </div>
            </div>

            <!-- card for Total leave taken-->
            <div class="col-lg-3 col-md-6">
                <div class="dashboard-card">
                    <h6>Active Employees</h6>

                    <h3><asp:Label ID="lblActiveEmployees" runat="server" Text="0"/></h3>

                    <span class="text-danger">
                        <i class="bi bi-arrow-down"></i> Days
                    </span>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="dashboard-card">
                    <h6>Leave Types</h6>

                    <h3><asp:Label ID="lblTypes" runat="server" Text="0"/></h3>

                    <span class="text-warning">
                        <i class="bi bi-hourglass"></i> 
                    </span>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="dashboard-card">
                    <h6>Total Requests</h6>

                    <h3><asp:Label ID="lblTotalRequests" runat="server" Text="0"/></h3>

                    <span class="text-success">
                        <i class="bi bi-calendar-check"></i> Rejected
                    </span>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="dashboard-card">
                    <h6>Approved Requests</h6>

                    <h3><asp:Label ID="lblApproved" runat="server" Text="0"/></h3>

                    <span class="text-success">
                        <i class="bi bi-calendar-check"></i> Approved
                    </span>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="dashboard-card">
                    <h6>Pending Requests</h6>

                    <h3><asp:Label ID="lblPending" runat="server" Text="0"/></h3>

                    <span class="text-success">
                        <i class="bi bi-calendar-check"></i> Pending
                    </span>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6">
                <div class="dashboard-card">
                    <h6>Rejected Requests</h6>

                    <h3><asp:Label ID="lblRejected" runat="server" Text="0"/></h3>

                    <span class="text-success">
                        <i class="bi bi-calendar-check"></i> Rejected
                    </span>
                </div>
            </div>
        </div>


        <div class=" chart-container">
            <canvas id="leaveChart"></canvas>
        </div>

        <div class=" chart-container">
            <canvas id="leaveTypeChart"></canvas>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    </div>

</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LeaveManagementSystem.Employee.Dashboard" %>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .dashboard-card {
            background: var(--card);
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.06);
            transition: 0.3s;
            height: 100%;
        }

        .dashboard-card:hover {
            transform: translateY(-4px);
        }

        .dashboard-card h6 {
            color: var(--text-light);
            margin-bottom: 10px;
        }

        .dashboard-card h3 {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-dark);
        }

        .chart-container {
            background: #ffffff;
            height: 300px;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.04);
        }

        @media(max-width: 768px) {
            .chart-container {
                height: 220px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid">

        <!-- CARDS -->
        <div class="row g-3 mt-3">

            <div class="col-lg-3 col-md-6">
                <div class="dashboard-card">
                    <h6>Allocated Balance</h6>
                    <h3><asp:Label ID="lblAllocated" runat="server" Text="0" /></h3>
                    <span class="text-primary">Days</span>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="dashboard-card">
                    <h6>Used Balance</h6>
                    <h3><asp:Label ID="lblTaken" runat="server" Text="0" /></h3>
                    <span class="text-primary">Days</span>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="dashboard-card">
                    <h6>Remaining Balance</h6>
                    <h3><asp:Label ID="lblBalance" runat="server" Text="0" /></h3>
                    <span class="text-danger">Days</span>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="dashboard-card">
                    <h6>Approved Requests</h6>
                    <h3><asp:Label ID="lblApproved" runat="server" Text="0" /></h3>
                    <span class="text-success">Approved</span>
                </div>
            </div>

        </div>

        <!-- CHARTS -->
        <div class="row mt-4">

            <div class="col-lg-6 col-md-12">
                <div class="chart-container">
                    <canvas id="leaveChart"></canvas>
                </div>
            </div>

            <div class="col-lg-6 col-md-12">
                <div class="chart-container">
                    <canvas id="leaveTypeChart"></canvas>
                </div>
            </div>

        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        window.onload = function () {

            // BAR CHART
            var ctx = document.getElementById('leaveChart').getContext('2d');

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: [<%= chartLabel %>],
                    datasets: [
                        {
                            label: 'Allocated',
                            data: [<%= chartTotal %>],
                            backgroundColor: '#2563eb'
                        },
                        {
                            label: 'Used',
                            data: [<%= chartUsed %>],
                            backgroundColor: '#dc2626'
                        },
                        {
                            label: 'Remaining',
                            data: [<%= chartRemaining %>],
                            backgroundColor: '#16a34a'
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });

            // PIE CHART
            var ctx2 = document.getElementById('leaveTypeChart').getContext('2d');

            new Chart(ctx2, {
                type: 'pie',
                data: {
                    labels: [<%= chartLabel %>],
                    datasets: [{
                        data: [<%= chartTotal %>],
                        backgroundColor: [
                            '#2563eb',
                            '#16a34a',
                            '#f59e0b',
                            '#dc2626',
                            '#6b7280'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        };
    </script>

</asp:Content>
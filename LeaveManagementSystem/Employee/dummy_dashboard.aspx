<%@ Page Title="" Language="C#" MasterPageFile="~/Employee/EmpMaster.Master" AutoEventWireup="true" CodeBehind="dummy_dashboard.aspx.cs" Inherits="LeaveManagementSystem.Employee.dummy_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>

.dashboard-card{
background:white;
padding:25px;
border-radius:12px;
box-shadow:0 4px 10px rgba(0,0,0,0.04);
transition:0.3s;
height:100%;
}

.dashboard-card:hover{
transform:translateY(-4px);
}

.dashboard-card h6{
color:#6b7280;
margin-bottom:10px;
}

.dashboard-card h3{
font-weight:700;
}

.chart-card{
background:white;
padding:25px;
border-radius:12px;
box-shadow:0 4px 10px rgba(0,0,0,0.04);
}

.chart-card canvas{
max-height:300px;
}

</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid">

<!-- DASHBOARD CARDS -->

<div class="row g-4">

<div class="col-xl-3 col-md-6">

<div class="dashboard-card">

<h6>Total Employees</h6>

<h3>352</h3>

<span class="text-success">
<i class="bi bi-arrow-up"></i> 15%
</span>

</div>

</div>


<div class="col-xl-3 col-md-6">

<div class="dashboard-card">

<h6>Total Leave Taken</h6>

<h3>22</h3>

<span class="text-danger">
<i class="bi bi-arrow-down"></i> 10%
</span>

</div>

</div>


<div class="col-xl-3 col-md-6">

<div class="dashboard-card">

<h6>Pending Requests</h6>

<h3>7</h3>

<span class="text-warning">
<i class="bi bi-hourglass"></i> Pending
</span>

</div>

</div>


<div class="col-xl-3 col-md-6">

<div class="dashboard-card">

<h6>Leave Balance</h6>

<h3>14</h3>

<span class="text-primary">
<i class="bi bi-calendar-check"></i> Days
</span>

</div>

</div>

</div>


<!-- CHART SECTION -->

<div class="row mt-4 g-4">

<!-- Leave Distribution -->

<div class="col-lg-6">

<div class="chart-card">

<h6 class="mb-3">Leave Distribution</h6>

<canvas id="leaveChart"></canvas>

</div>

</div>


<!-- Attendance Chart -->

<div class="col-lg-6">

<div class="chart-card">

<h6 class="mb-3">Monthly Attendance</h6>

<canvas id="attendanceChart"></canvas>

</div>

</div>

</div>



<!-- RECENT LEAVE REQUEST TABLE -->

<div class="row mt-4">

<div class="col-lg-12">

<div class="chart-card">

<h6 class="mb-3">Recent Leave Requests</h6>

<div class="table-responsive">

<table class="table table-hover">

<thead>

<tr>
<th>Employee</th>
<th>Leave Type</th>
<th>From</th>
<th>To</th>
<th>Status</th>
</tr>

</thead>

<tbody>

<tr>
<td>Rahul Sharma</td>
<td>Sick Leave</td>
<td>10 Mar</td>
<td>12 Mar</td>
<td><span class="badge bg-warning">Pending</span></td>
</tr>

<tr>
<td>Anjali Verma</td>
<td>Casual Leave</td>
<td>5 Mar</td>
<td>6 Mar</td>
<td><span class="badge bg-success">Approved</span></td>
</tr>

<tr>
<td>Vikas Patil</td>
<td>Earned Leave</td>
<td>1 Mar</td>
<td>3 Mar</td>
<td><span class="badge bg-danger">Rejected</span></td>
</tr>

</tbody>

</table>

</div>

</div>

</div>

</div>


</div>


<script>

/* Leave Chart */

new Chart(document.getElementById("leaveChart"), {

type: "doughnut",

data: {

labels: ["Casual Leave","Sick Leave","Earned Leave"],

datasets: [{

data: [12,7,5],

backgroundColor: [

"#4F46E5",
"#10B981",
"#F59E0B"

]

}]

}

});


/* Attendance Chart */

new Chart(document.getElementById("attendanceChart"), {

type: "bar",

data: {

labels:["Jan","Feb","Mar","Apr","May","Jun"],

datasets:[

{
label:"Present",
data:[22,20,23,21,24,26],
backgroundColor:"#4F46E5"
},

{
label:"Absent",
data:[2,3,1,2,1,2],
backgroundColor:"#EF4444"
}

]

}

});

</script>

</asp:Content>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;
using System.Data;

namespace LeaveManagementSystem.Employee
{
    public partial class Dashboard : System.Web.UI.Page
    {
        
        public string chartLabel = "";
        public string chartTotal = "";
        public string chartUsed = "";
        public string chartRemaining = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            
            if(!IsPostBack)
            {
                LoadDashboardData();
                LoadChartData();
            }
        }

        protected void LoadDashboardData()
        {
            int employeeId = Convert.ToInt32(Session["EmployeeId"]);

            DashboardBLL bll = new DashboardBLL();
            DataTable dt = bll.GetDashboardData(employeeId);

            if(dt.Rows.Count>0)
            {
                int allocated = Convert.ToInt32(dt.Rows[0]["TotalAllocated"]);
                int taken = Convert.ToInt32(dt.Rows[0]["TotalUsed"]);
                int remaining = Convert.ToInt32(dt.Rows[0]["RemainingBalance"]);
                int pending = Convert.ToInt32(dt.Rows[0]["PendingCount"]);
                int approved = Convert.ToInt32(dt.Rows[0]["ApprovedCount"]);

                lblAllocated.Text = allocated.ToString();
                lblTaken.Text = taken.ToString();
                lblBalance.Text = remaining.ToString();
                //lblPending.Text = pending.ToString();
                lblApproved.Text = approved.ToString();

            }
        }

        public void LoadChartData()
        {
            int employeeId = Convert.ToInt32(Session["EmployeeId"]);

            DashboardBLL bll = new DashboardBLL();
            DataTable dt = bll.GetLeaveTypeChart(employeeId);

            foreach(DataRow row in dt.Rows)
            {
                chartLabel += "'" + row["LeaveTypeName"] + "',";
                chartTotal += row["AllocatedDays"] + ",";
                chartUsed += row["UsedDays"] + ",";
                chartRemaining += row["RemainingDays"] + ",";
            }
        }

    }
}
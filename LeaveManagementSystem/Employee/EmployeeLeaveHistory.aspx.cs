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
    public partial class EmployeeLeaveHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeId"] == null)
                Response.Redirect("~/Account/Login.aspx");

            if (!IsPostBack)
                BindLeaveHistory();
        }

        private void BindLeaveHistory()
        {
            int employeeId = Convert.ToInt32(Session["EmployeeId"]);

            LeaveApplicationBLL bll = new LeaveApplicationBLL();

            DataTable dt = bll.GetEmployeeLeaveHistory(employeeId);

            gvLeaveHistory.DataSource = dt;
            gvLeaveHistory.DataBind();
        }
    }
}
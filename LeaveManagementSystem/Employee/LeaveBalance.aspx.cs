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
    public partial class LeaveBalance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["EmployeeId"]==null)
            {
                Response.Redirect("/Account/Login.aspx");
            }

            if(!IsPostBack)
            {
                BindLeaveBalance();
            }
        }

        protected void BindLeaveBalance()
        {
            LeaveApplicationBLL bll = new LeaveApplicationBLL();

            int employeeId = Convert.ToInt32(Session["EmployeeId"]);

            DataTable dt = bll.GetEmployeeLeaveBalance(employeeId);

            rptLeaveBalance.DataSource = dt;
            rptLeaveBalance.DataBind();
        }
    }
}
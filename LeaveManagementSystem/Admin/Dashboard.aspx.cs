using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;

namespace LeaveManagementSystem.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        DepartmentBLL deptBll = new DepartmentBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                Response.Redirect("~/Account/Login.aspx");

            if (Convert.ToInt32(Session["RoleId"]) != 1)
                Response.Redirect("~/Unauthorized.aspx");

            if(!IsPostBack)
            {
                LoadDashboardCount();
            }
        }

        private void LoadDashboardCount()
        {
            try
            {
                lblTotalDepartments.Text = deptBll.GetDepartmentCount().ToString();
            }
            catch(Exception)
            {
                lblTotalDepartments.Text = "0";
            }
        }
    }
}
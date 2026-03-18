using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;
using System.Data;

namespace LeaveManagementSystem.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                Response.Redirect("~/Account/Login.aspx");

            if (Convert.ToInt32(Session["RoleId"]) != 1)
                Response.Redirect("~/Unauthorized.aspx");

            if(!IsPostBack)
            {
                GetDashboardCounts();
            }
        }

        private void GetDashboardCounts()
        {
            try
            {

                AdminDashboardBLL bll = new AdminDashboardBLL();

                DataTable dt = bll.GetDashboardCounts();
                
                if(dt.Rows.Count>0)
                {
                    lblTotalDepartments.Text = dt.Rows[0]["TotalDepartments"].ToString();
                    lblTotalEmployees.Text = dt.Rows[0]["TotalEmployees"].ToString();
                    lblActiveEmployees.Text = dt.Rows[0]["ActiveEmployees"].ToString();
                    lblTypes.Text = dt.Rows[0]["TotalLeaveTypes"].ToString();
                    lblTotalRequests.Text=dt.Rows[0]["TotalRequests"].ToString();
                    lblApproved.Text = dt.Rows[0]["ApprovedRequests"].ToString();
                    lblPending.Text = dt.Rows[0]["PendingRequests"].ToString();
                    lblRejected.Text = dt.Rows[0]["RejectedRequests"].ToString();
                }
            }
            catch(Exception)
            {
                throw new Exception("Exception in getting count");
            }
        }
    }
}
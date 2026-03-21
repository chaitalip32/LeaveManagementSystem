using System;
using System.Web.UI.WebControls;

namespace LeaveManagementSystem
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["RoleId"] == null)
            {
                Response.Redirect("~/Account/Login.aspx");
                return;
            }

            LoadMenu();
        }

        private void LoadMenu()
        {
            int roleId = Convert.ToInt32(Session["RoleId"]);

            string menuHtml = "";

            if (roleId == 4) 
            {
                menuHtml = @"
                    <li><a href='/Employee/Dashboard.aspx'>Dashboard</a></li>
                    <li><a href='/Employee/NewLeaveForm.aspx'>Apply Leave</a></li>
                    <li><a href='/Employee/EmployeeLeaveHistory.aspx'>Leave History</a></li>";
            }
            else if (roleId == 3)
            {
                menuHtml = @"
                    <li><a href='/Manager/Dashboard.aspx'>Dashboard</a></li>
                    <li><a href='/Common/LeaveRequests.aspx'>Leave Requests</a></li>";
            }
            else if (roleId == 2) 
            {
                menuHtml = @"
                    <li><a href='/HR/Dashboard.aspx'>Dashboard</a></li>
                    <li><a href='/Common/LeaveRequests.aspx'>Manage Leaves</a></li>";
            }
            else if (roleId == 1)
            {
                menuHtml = @"
                    <li><a href='/Admin/Dashboard.aspx'>Dashboard</a></li>";
            }

            // Loading menu
            phMenu.Controls.Clear();
            phMenu.Controls.Add(new Literal { Text = menuHtml });
        }
    }
}
using System;
using System.Web.UI.WebControls;
using System.Web;
using System.Web.Security;

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

            if (Session["UserId"] == null)
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
            else if (roleId == 1) // Admin
            {
                menuHtml = @"
                <li><a href='/Admin/Dashboard.aspx'>Dashboard</a></li>
                <li><a href='/Admin/Add_Employee.aspx'>Add Employee</a></li>
                <li><a href='/Admin/Add_Department.aspx'>Add Department</a></li>
                <li><a href='/Admin/Manage_Departments.aspx'>Manage Department</a></li>
                <li><a href='/Admin/ManageLeaves.aspx'>Manage Leaves</a></li>
                <li><a href='/Admin/Add_LeaveType.aspx'>Add Leave</a></li>
                <li><a href='/Admin/EmployeeList.aspx'>Employee List</a></li>";
            }

            // Loading menu
            phMenu.Controls.Clear();
            phMenu.Controls.Add(new Literal { Text = menuHtml });
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            //for preventing browser back button caching
            Response.Cache.SetCacheability(HttpCacheability.NoCache); //browser will rerequest page from server
            Response.Cache.SetNoStore(); //page will not stored in cache
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1)); //page expiry

            Response.Redirect("~/Account/Login.aspx");
        }
    }
}
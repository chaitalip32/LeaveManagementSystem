using System;
using LeaveManagementSystem.BLL;
using LeaveManagementSystem.Models;

namespace LeaveManagementSystem.Account
{
    public partial class Login : System.Web.UI.Page
    {
        UserBLL bll = new UserBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoginError"] != null)
            {
                lblMessage.Text = Session["LoginError"].ToString();
                lblMessage.Visible = true;

                Session.Remove("LoginError");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;

            if (!Page.IsValid)
                return;

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            UserModel user = bll.ValidateUsers(email, password);

            if (user == null)
            {
                //Session["LoginError"] = "Invalid Email or Password";
                Response.Redirect("Login.aspx");
                return;
            }

            // Store session
            Session["UserId"] = user.UserId;
            Session["Email"] = user.Email;
            Session["RoleId"] = user.RoleId;

            // Role string
            string role = "";
            switch (user.RoleId)
            {
                case 1: role = "Admin"; break;
                case 2: role = "HR"; break;
                case 3: role = "Manager"; break;
                case 4: role = "Employee"; break;
            }
            Session["Role"] = role;

            int employeeId = bll.GetEmployeeIdByUserId(user.UserId);
            Session["EmployeeId"] = employeeId;

            // Redirect
            if (user.RoleId == 2 || user.RoleId == 3)
            {
                Response.Redirect("~/Common/LeaveRequests.aspx"); // ONE PAGE
            }
            else if (user.RoleId == 1)
            {
                Response.Redirect("~/Admin/Dashboard.aspx");
            }
            else
            {
                Response.Redirect("~/Employee/Dashboard.aspx");
            }
        }
    }
}
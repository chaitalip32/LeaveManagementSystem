using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;
using LeaveManagementSystem.Models;

namespace LeaveManagementSystem.Account
{
    public partial class Login : System.Web.UI.Page
    {
        UserBLL bll = new UserBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoginError"]!=null)
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

            if(user==null)
            {
                Session["LoginError"] = "Invalid Email or Password";
                Response.Redirect("Login.aspx");
            }

            // Session Storing
            Session["UserId"] = user.UserId;
            Session["Email"] = user.Email;
            Session["RoleId"] = user.RoleId;

            //for employees while applying leave
            int employeeId = bll.GetEmployeeIdByUserId(user.UserId);
            Session["EmployeeId"] = employeeId;

            // Role based redirection
            switch (user.RoleId)
            {
                case 1:
                    /*Admin RoleId = 1*/
                    Response.Redirect("~/Admin/Dashboard.aspx"); 
                    break;

                case 2:
                    /*HR RoleId = 2*/
                    Response.Redirect("~/HR/Dashboard.aspx");
                    break;

                case 3:
                    /*manager RoleId = 3*/
                    Response.Redirect("~/Manager/Dashboard.aspx");
                    break;

                case 4:
                    /*Employee RoleId = 4*/
                    Response.Redirect("~/Employee/Dashboard.aspx");
                    break;

                default:
                    Response.Redirect("~/Unauthorized.aspx");
                    break;
            }
        }
    }
}
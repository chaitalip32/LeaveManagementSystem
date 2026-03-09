using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;

namespace LeaveManagementSystem.Account
{
    public partial class SetPassword : System.Web.UI.Page
    {
        UserBLL bll = new UserBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    string token = Request.QueryString["token"];

                    if (string.IsNullOrEmpty(token))
                    {
                        ShowError("Invalid password reset link.");
                        btnResetPassword.Enabled = false;
                        return;
                    }
                    ViewState["ResetToken"] = token;
                }
                catch
                {
                    ShowError("Error loading the page. Please try again.");
                }
            }           
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                    return;

                string token = ViewState["ResetToken"]?.ToString();

                if (string.IsNullOrEmpty(token))
                {
                    ShowError("Invalid password reset request.");
                    return;
                }

                string password = txtPassword.Text.Trim();
                bool result = bll.ResetPassword(token, password);

                if(result)
                {
                    lblMessage.CssClass = "alert alert-success text-center";
                    lblMessage.Text = "Password reset successfully. Please login.";
                    lblMessage.Visible = true;

                    //lblMessage.Text = "";
                    txtConfirmPassword.Text = "";
                }
                else
                {
                    ShowError("Reset link is invalid or exprired.");
                }
            }
            catch(Exception ex)
            {
                ShowError(ex.Message);
            }
        }

        private void ShowError(string message)
        {
            lblMessage.CssClass = "alert alert-danger text-center";
            lblMessage.Text = message;
            lblMessage.Visible = true;
        }
    }
}
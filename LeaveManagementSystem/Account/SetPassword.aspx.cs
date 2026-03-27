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
                        ShowAlert("Invalid password reset link.");
                        btnResetPassword.Enabled = false;
                        return;
                    }
                    ViewState["ResetToken"] = token;
                }
                catch
                {
                    ShowAlert("Error loading the page. Please try again.");
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
                    ShowAlert("Invalid password reset request.");
                    return;
                }

                string password = txtPassword.Text.Trim();
                bool result = bll.ResetPassword(token, password);

                if(result)
                {

                    ShowAlert("Password reset successfully. Please login.");
                }
                else
                {
                    ShowAlert("Reset link is invalid or exprired.");
                }
            }
            catch(Exception ex)
            {
                ShowAlert(ex.Message);
            }
        }

        private void ShowAlert(string message, string redirectUrl = null)
        {
            string cleanMessage = message.Replace("'", "\\'");
            string script;

            if (!string.IsNullOrEmpty(redirectUrl))
            {
                script = $"alert('{cleanMessage}'); window.location='{redirectUrl}';";
            }
            else
            {
                script = $"alert('{cleanMessage}');";
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "PopupScript", script, true);
        }
    }
}
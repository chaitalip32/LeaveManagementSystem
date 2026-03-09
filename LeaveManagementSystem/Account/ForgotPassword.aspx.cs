using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;

namespace LeaveManagementSystem.Account
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        UserBLL bll = new UserBLL();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSendLink_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtEmail.Text.Trim();

                if (string.IsNullOrEmpty(email))
                {
                    ShowError("Please enter email.");
                    return;
                }

                bool result = bll.GeneratePasswordResetToken(email);

                if (result)
                {
                    lblMessage.CssClass = "alert alert-success text-center";
                    lblMessage.Text = "Password reset link sent to your email.";
                    lblMessage.Visible = true;
                }
                else
                {
                    ShowError("Email not found.");
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
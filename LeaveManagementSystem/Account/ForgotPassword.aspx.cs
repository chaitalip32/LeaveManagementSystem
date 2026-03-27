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
                    ShowAlert("Please enter email.");
                    return;
                }

                bool result = bll.GeneratePasswordResetToken(email);

                if (result)
                {
                    ShowAlert("Password reset link sent to your email.");
                }
                else
                {
                    ShowAlert("Email not found.");
                }
            }
            catch(Exception ex)
            {
                ShowAlert(ex.Message);
            }
        }

        private void ShowAlert(string message)
        {
            string Message = message.Replace("'", "\\'");
            string script = $"alert('{Message}');";

            ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
        }
    }
}
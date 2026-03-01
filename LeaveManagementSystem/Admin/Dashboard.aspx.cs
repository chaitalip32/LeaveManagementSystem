using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
        }
    }
}
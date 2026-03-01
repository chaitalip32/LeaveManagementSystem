using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LeaveManagementSystem
{
    public partial class GenerateHash : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string hash = BCrypt.Net.BCrypt.HashPassword("Manager@123");

            Response.Write("<h3>" + hash + "</h3>");
        }
    }
}
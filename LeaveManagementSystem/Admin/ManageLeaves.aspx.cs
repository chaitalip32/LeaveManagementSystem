using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;

namespace LeaveManagementSystem.Admin
{
    public partial class ManageLeaves : System.Web.UI.Page
    {
        LeaveTypeBLL bll = new LeaveTypeBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadLeaveTypes();
        }

        protected void LoadLeaveTypes(string search = "")
        {
            gvLeaveTypes.DataSource = bll.GetLeaveTypes(search);
            gvLeaveTypes.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadLeaveTypes(txtSearchLeaveType.Text.Trim());
        }

        protected void gvLeaveTypes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditLeave")
            {
                Response.Redirect("Add_LeaveType.aspx?id=" + e.CommandArgument.ToString());
            }
        }

    }
}
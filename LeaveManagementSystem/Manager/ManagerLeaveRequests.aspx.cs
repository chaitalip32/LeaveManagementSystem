using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;
using System.Data;

namespace LeaveManagementSystem.Manager
{
    public partial class ManagerLeaveRequests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if(Session["EmployeeId"]==null)
                {
                    Response.Redirect("~/Account/Login.aspx");
                }

                if (!IsPostBack)
                {
                    BindLeaveRequests();
                }
            }
            catch(Exception)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "error", "alert('Error loading page');", true);
            }

        }

        private void BindLeaveRequests()
        {
            try
            {
                int managerId = Convert.ToInt32(Session["EmployeeId"]);
                LeaveApplicationBLL bll = new LeaveApplicationBLL();

                DataTable dt = bll.GetManagerLeaveRequests(managerId);

                gvLeaveRequests.DataSource = dt;
                gvLeaveRequests.DataBind();
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "error","alert('Error loading leave requests');", true);
            }
        }

        protected void gvLeaveRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName=="EditStatus")
            {
                hfLeaveRequestId.Value = e.CommandArgument.ToString();

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "Popup", "$('#leaveModal').modal('show')", true);
            }
        }
    }
}
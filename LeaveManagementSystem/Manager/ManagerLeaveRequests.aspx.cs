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
                GridViewRow row = ((LinkButton)e.CommandSource).NamingContainer as GridViewRow;

                //getting leaveid for specific user record to pass in the hidden field to update it
                int leaveId = Convert.ToInt32(e.CommandArgument);

                txtEmployeeName.Text = row.Cells[0].Text;
                txtDepartment.Text = row.Cells[1].Text;
                txtLeaveType.Text = row.Cells[2].Text;

                txtFromDate.Text = row.Cells[4].Text;
                txtToDate.Text = row.Cells[5].Text;
                txtTotalDays.Text = row.Cells[6].Text;

                Label lblReason = (Label)row.FindControl("lblReason");
                txtReason.Text = lblReason.Text;

                hfLeaveRequestId.Value = leaveId.ToString();

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "Popup", "$('#leaveModal').modal('show')", true);
            }
        }

        protected void btnUpdate_Click(object sender,EventArgs e)
        {
            try
            {
                int leaveId = Convert.ToInt32(hfLeaveRequestId.Value);
                string managerComment = txtManagerComment.Text;
                string selectedStatus = ddlStatus.SelectedValue;

                string status = "";

                if(selectedStatus=="Approved")
                {
                    status = "Pending_HR";
                }
                else if(selectedStatus=="Rejected")
                {
                    status = "Rejected";
                }

                int managerId = Convert.ToInt32(Session["EmployeeId"]);

                LeaveApplicationBLL bll = new LeaveApplicationBLL();

                bll.UpdateManagerLeaveStatus(leaveId,status,managerComment,managerId);

                BindLeaveRequests();

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "success", "alert('Leave status updated successfully');",true);
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "error", "alert('Error updating leave status');", true);
            }
        }
    }
}
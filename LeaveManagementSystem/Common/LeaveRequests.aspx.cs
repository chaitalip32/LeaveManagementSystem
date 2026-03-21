using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;

namespace LeaveManagementSystem.Common
{
    public partial class LeaveRequests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["EmployeeId"] == null || Session["RoleId"] == null)
                {
                    Response.Redirect("~/Account/Login.aspx");
                }

                if (!IsPostBack)
                {
                    BindLeaveRequests();
                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "error", "alert('Error loading page');", true);
            }
        }

        private void BindLeaveRequests()
        {
            try
            {
                int userId = Convert.ToInt32(Session["EmployeeId"]);
                int roleId = Convert.ToInt32(Session["RoleId"]);

                LeaveApplicationBLL bll = new LeaveApplicationBLL();
                DataTable dt;

                if (roleId == 3) // Manager
                {
                    dt = bll.GetManagerLeaveRequests(userId);
                }
                else if (roleId == 2) // HR
                {
                    dt = bll.GetHRLeaveRequests(); 
                }
                else
                {
                    dt = null;
                }

                gvLeaveRequests.DataSource = dt;
                gvLeaveRequests.DataBind();
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "error", "alert('Error loading leave requests');", true);
            }
        }

        protected void gvLeaveRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditStatus")
            {
                GridViewRow row = ((LinkButton)e.CommandSource).NamingContainer as GridViewRow;

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

                //int roleId = Convert.ToInt32(Session["RoleId"]);

                ddlStatus.Items.Clear();
                ddlStatus.Items.Add("Approved");
                ddlStatus.Items.Add("Rejected");

                ClientScript.RegisterStartupScript(this.GetType(), "Popup",
    "setTimeout(function(){ var myModal = new bootstrap.Modal(document.getElementById('leaveModal')); myModal.show(); }, 100);",
    true);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                int leaveId = Convert.ToInt32(hfLeaveRequestId.Value);
                string comment = txtManagerComment.Text;
                string selectedStatus = ddlStatus.SelectedValue;

                int userId = Convert.ToInt32(Session["EmployeeId"]);
                int roleId = Convert.ToInt32(Session["RoleId"]);

                LeaveApplicationBLL bll = new LeaveApplicationBLL();

                if (roleId == 3) // Manager
                {
                    string status = "";

                    if (selectedStatus == "Approved")
                    {
                        status = "Pending_HR";
                    }
                    else if (selectedStatus == "Rejected")
                    {
                        status = "Rejected";
                    }

                    bll.UpdateManagerLeaveStatus(leaveId, status, comment, userId);
                }
                else if (roleId == 2) // HR
                {
                    // Final decision
                    bll.UpdateHRLeaveStatus(leaveId, selectedStatus, comment, userId);
                }

                BindLeaveRequests();

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "success", "alert('Leave status updated successfully');", true);
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "error", "alert('Error updating leave status');", true);
            }
        }
    }
}
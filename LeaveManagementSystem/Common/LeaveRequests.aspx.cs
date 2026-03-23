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
    "error", "Swal.fire('Error','Error loading leave requests','error');", true);
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
    "error", "Swal.fire('Error','Error loading leave requests','error');", true);
            }
        }

        protected void gvLeaveRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditStatus")
            {
                GridViewRow row = ((LinkButton)e.CommandSource).NamingContainer as GridViewRow;

                int rowIndex = row.RowIndex;

                var data = gvLeaveRequests.DataKeys[rowIndex];

                int leaveId = Convert.ToInt32(data["LeaveApplicationId"]);

                txtEmployeeName.Text = data["EmployeeName"].ToString();
                txtDepartment.Text = data["DepartmentName"].ToString();
                txtLeaveType.Text = data["LeaveTypeName"].ToString();
                txtFromDate.Text = Convert.ToDateTime(data["FromDate"]).ToString("dd MMM yyyy");
                txtToDate.Text = Convert.ToDateTime(data["ToDate"]).ToString("dd MMM yyyy");
                txtTotalDays.Text = data["TotalDays"].ToString();
                txtReason.Text = data["Reason"].ToString();

                hfLeaveRequestId.Value = leaveId.ToString();

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

                ClientScript.RegisterStartupScript(this.GetType(), "success",
    "window.onload = function(){ Swal.fire('Success','Leave status updated successfully','success'); };",
    true);
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
    "error", "Swal.fire('Error','Error loading leave requests','error');", true);
            }
        }
    }
}
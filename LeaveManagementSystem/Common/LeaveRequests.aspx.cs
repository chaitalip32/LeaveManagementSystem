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
                ShowAlert("error", "Error loading leave requests");
            }
        }

        private void BindLeaveRequests()
        {
            try
            {
                int userId = Convert.ToInt32(Session["EmployeeId"]);
                int roleId = Convert.ToInt32(Session["RoleId"]);

                LeaveApplicationBLL bll = new LeaveApplicationBLL();
                DataTable dt = null;

                if (roleId == 3) // Manager
                    dt = bll.GetManagerLeaveRequests(userId);
                else if (roleId == 2) // HR
                    dt = bll.GetHRLeaveRequests();

                gvLeaveRequests.DataSource = dt;
                gvLeaveRequests.DataBind();
            }
            catch
            {
                ShowAlert("error", "Error fetching data from server");
            }
        }

        protected void gvLeaveRequests_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                for (int i = 0; i < e.Row.Cells.Count; i++)
                {
                    string headerText = gvLeaveRequests.HeaderRow.Cells[i].Text;
                    if (!string.IsNullOrEmpty(headerText))
                    {
                        e.Row.Cells[i].Attributes.Add("data-label", headerText);
                    }
                }
            }
        }

        protected void gvLeaveRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditStatus")
            {
                GridViewRow row = ((LinkButton)e.CommandSource).NamingContainer as GridViewRow;
                int rowIndex = row.RowIndex;
                var data = gvLeaveRequests.DataKeys[rowIndex];

                txtEmployeeName.Text = data["EmployeeName"].ToString();
                txtDepartment.Text = data["DepartmentName"].ToString();
                txtLeaveType.Text = data["LeaveTypeName"].ToString();
                txtFromDate.Text = Convert.ToDateTime(data["FromDate"]).ToString("dd MMM yyyy");
                txtToDate.Text = Convert.ToDateTime(data["ToDate"]).ToString("dd MMM yyyy");
                txtTotalDays.Text = data["TotalDays"].ToString();
                txtReason.Text = data["Reason"].ToString();
                hfLeaveRequestId.Value = data["LeaveApplicationId"].ToString();

                ddlStatus.SelectedIndex = 0;
                txtManagerComment.Text = "";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup",
                    "setTimeout(function(){ var myModal = new bootstrap.Modal(document.getElementById('leaveModal')); myModal.show(); }, 100);", true);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                int leaveId = Convert.ToInt32(hfLeaveRequestId.Value);
                string comment = txtManagerComment.Text;
                string selectedStatus = ddlStatus.SelectedValue;

                if (string.IsNullOrEmpty(selectedStatus))
                {
                    ShowAlert("warning", "Please select a status action");
                    return;
                }

                int userId = Convert.ToInt32(Session["EmployeeId"]);
                int roleId = Convert.ToInt32(Session["RoleId"]);

                LeaveApplicationBLL bll = new LeaveApplicationBLL();

                if (roleId == 3) // Manager
                {
                    string finalStatus = (selectedStatus == "Approved") ? "Pending_HR" : "Rejected";
                    bll.UpdateManagerLeaveStatus(leaveId, finalStatus, comment, userId);
                }
                else if (roleId == 2) // HR
                {
                    bll.UpdateHRLeaveStatus(leaveId, selectedStatus, comment, userId);
                }

                BindLeaveRequests();
                ShowAlert("success", "Leave status updated successfully");
            }
            catch
            {
                ShowAlert("error", "Failed to update leave request");
            }
        }

        private void ShowAlert(string type, string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "sweetalert",
                $"Swal.fire('{type.ToUpper()}', '{msg}', '{type}');", true);
        }
    }
}
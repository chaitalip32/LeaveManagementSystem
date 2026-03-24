using System;
using System.Data;
using System.Web.UI;
using LeaveManagementSystem.BLL;
using LeaveManagementSystem.Models;

namespace LeaveManagementSystem.Admin
{
    public partial class Add_LeaveType : System.Web.UI.Page
    {
        LeaveTypeBLL bll = new LeaveTypeBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["id"]);
                    LoadData(id);
                }
            }
        }

        private void LoadData(int id)
        {
        
            LeaveType lt = bll.GetLeaveTypeById(id);

            if (lt != null)
            {
                hfLeaveTypeId.Value = lt.LeaveTypeId.ToString();
                txtLeaveType.Text = lt.LeaveTypeName;
                txtDefaultDays.Text = lt.DefaultDays.ToString();
                txtDescription.Text = lt.Description;
                rblStatus.SelectedValue = lt.IsActive ? "1" : "0";

                litTitle.Text = "Update Leave Type";
                btnSave.Text = "Update Leave Type";
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                LeaveType lt = new LeaveType
                {
                    LeaveTypeName = txtLeaveType.Text.Trim(),
                    DefaultDays = Convert.ToInt32(txtDefaultDays.Text),
                    Description = txtDescription.Text.Trim(),
                    IsActive = rblStatus.SelectedValue == "1",
                    CreatedBy = Convert.ToInt32(Session["UserId"])
                };

                if (string.IsNullOrEmpty(hfLeaveTypeId.Value))
                {
                    bll.AddLeaveType(lt);
                    ShowAlertAndRedirect("Leave Type added successfully!");
                }
                else
                {
                    lt.LeaveTypeId = Convert.ToInt32(hfLeaveTypeId.Value);
                    bll.UpdateLeaveType(lt);
                    ShowAlertAndRedirect("Leave Type updated successfully!");
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "err", $"Swal.fire('Error','{ex.Message}','error');", true);
            }
        }

        private void ShowAlertAndRedirect(string msg)
        {
            string script = $@"Swal.fire('Success', '{msg}', 'success').then((result) => {{ window.location.href = 'ManageLeaves.aspx'; }});";
            ScriptManager.RegisterStartupScript(this, GetType(), "redirect", script, true);
        }
    }
}
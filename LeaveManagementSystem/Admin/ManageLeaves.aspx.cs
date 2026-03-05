using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;
using LeaveManagementSystem.Models;

namespace LeaveManagementSystem.Admin
{
    public partial class ManageLeaves : System.Web.UI.Page
    {

        LeaveTypeBLL bll = new LeaveTypeBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadLeaveTypes();
        }

        protected void LoadLeaveTypes(string search="")
        {
            try
            {
                gvLeaveTypes.DataSource = bll.GetLeaveTypes(search);
                gvLeaveTypes.DataBind();
            }
            catch(Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.CssClass = "alert alert-danger";
                lblMessage.Visible = true;
            }
        }

        protected void btnSaveLeaveType_Click(object sender, EventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserId"]);

                LeaveType lt = new LeaveType
                {
                    LeaveTypeName = txtLeaveType.Text.Trim(),
                    DefaultDays = Convert.ToInt32(txtDefaultDays.Text),
                    Description = txtDescription.Text.Trim(),
                    IsActive = rblStatus.SelectedValue == "1",
                    CreatedBy = userId
                };

                bll.AddLeaveType(lt);

                lblMessage.Text = "Leave type added successfully";
                lblMessage.CssClass = "alert alert-success";
                lblMessage.Visible = true;

                txtLeaveType.Text = "";
                txtDefaultDays.Text = "";
                txtDescription.Text = "";
            }
            catch(Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.CssClass = "alert alert-dander";
                lblMessage.Visible = true;
            }
        }

        protected void btnSeaech_Click(object sender, EventArgs e)
        {
            try
            {
                string search = txtSearchLeaveType.Text.Trim();
                LoadLeaveTypes(search);
            }
            catch(Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.CssClass = "alert alert-danger";
                lblMessage.Visible = true;
            }
        }
    }
}
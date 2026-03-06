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
                LoadLeaveTypes();

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
                lblMessage.CssClass = "alert alert-danger";
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

        /*protected void LoadLeaveType(int id)
        {
            var leave = bll.GetLeaveTypeById(id);

            txtLeaveType.Text = leave.LeaveTypeName;
            txtDefaultDays.Text = leave.DefaultDays.ToString();
            txtDescription.Text = leave.Description;
            rblStatus.SelectedValue = leave.IsActive ? "1" : "0";

            ViewState["LeaveTypeId"] = id;

            btnSaveLeaveType.Text = "Update Leave Type";
        }*/

        protected void gvLeaveTypes_RowCommdand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if(e.CommandName=="EditeaveType")
            {
               // LoadLeaveType(id);
            }

            if(e.CommandName=="DeleteLeaveType")
            {
                bll.DeleteLeaveType(id);
               // BindGrid();
            }
        }

        protected void gvLeaveTypes_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLeaveTypes.EditIndex = e.NewEditIndex;
            LoadLeaveTypes();
        }

        protected void gvLeaveTypes_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvLeaveTypes.EditIndex = -1;
            LoadLeaveTypes();
        }

        protected void gvLeaveTypes_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int leaveTypeId = Convert.ToInt32(gvLeaveTypes.DataKeys[e.RowIndex].Value);

                GridViewRow row = gvLeaveTypes.Rows[e.RowIndex];

                TextBox txtLeaveType = (TextBox)row.FindControl("txtEditLeaveType");
                TextBox txtDefaultDays = (TextBox)row.FindControl("txtEditDefaultDays");
                TextBox txtDescription = (TextBox)row.FindControl("txtEditDescription");
                RadioButtonList rblStatus = (RadioButtonList)row.FindControl("rblEditStatus");

                LeaveType lt = new LeaveType
                {
                    LeaveTypeId = leaveTypeId,
                    LeaveTypeName = txtLeaveType.Text.Trim(),
                    DefaultDays = Convert.ToInt32(txtDefaultDays.Text),
                    Description = txtDescription.Text.Trim(),
                    IsActive = Convert.ToBoolean(rblStatus.SelectedValue)
                };

                bll.UpdateLeaveType(lt);

                gvLeaveTypes.EditIndex = -1;
                LoadLeaveTypes();

                lblMessage.Text = "Leave type updated successfully";
                lblMessage.CssClass = "alert alert-success";
                lblMessage.Visible = true;
            }
            catch(Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.CssClass = "alert alert-danger";
                lblMessage.Visible = true;
            }
        }

        protected void gvLeaveTypes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int leaveTypeId = Convert.ToInt32(gvLeaveTypes.DataKeys[e.RowIndex].Value);

                bll.DeleteLeaveType(leaveTypeId);

                LoadLeaveTypes();

                lblMessage.Text = "Leave type deleted successfully";
                lblMessage.CssClass = "alert alert-success";
                lblMessage.Visible = true;
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
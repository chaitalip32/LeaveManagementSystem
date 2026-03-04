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
    public partial class Manage_Departments : System.Web.UI.Page
    {
        DepartmentBLL bll = new DepartmentBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDepartments();
            }

            txtDepartmentName.Attributes["placeholder"] = "Enter Department Name";
            txtDescription.Attributes["placeholder"] = "Enter Description";
        }

        private void LoadDepartments()
        {
            try
            {
                gvDepartments.DataSource = bll.GetAllDepartments();
                gvDepartments.DataBind();

                //lblTotalDepartments.Text = bll.GetDepartmentCount().ToString();
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.CssClass = "text-danger";
            }
        }
        protected void gvDepartments_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvDepartments_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvDepartments.DataKeys[e.RowIndex].Value);

                bll.DeleteDepartment(id);

                lblMessage.Text = "Department deleted Sucessfully.";
                lblMessage.CssClass = "text-success";

                LoadDepartments();
            }
            catch(Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.CssClass = "text-danger";
            }
        }

        protected void gvDepartments_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvDepartments.DataKeys[e.RowIndex].Value);

                GridViewRow row = gvDepartments.Rows[e.RowIndex];

                //string name = ((TextBox)gvDepartments.Rows[e.RowIndex].FindControl("txtName")).Text;
                //string desc = ((TextBox)gvDepartments.Rows[e.RowIndex].FindControl("TextDesc")).Text;

                TextBox txtName = (TextBox)row.FindControl("txtEditName");
                TextBox textDesc = (TextBox)row.FindControl("txtEditDescription");

                int userId = Convert.ToInt32(Session["UserId"]);

                Department dept = new Department
                {
                    DepartmentId = id,
                    DepartmentName = txtName.Text.Trim(),
                    Description = textDesc.Text.Trim(),
                    IsActive = true,
                    UpdatedBy = userId // Session ID
                };

                bll.EditDepartments(dept);

                gvDepartments.EditIndex = -1;
                LoadDepartments();

                lblMessage.Text = "Department updated successfully.";
                lblMessage.CssClass = "text-success";
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.CssClass = "text-danger";
            }
        }

        protected void gvDepartments_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvDepartments.EditIndex = e.NewEditIndex;
            LoadDepartments();
        }

        protected void gvDepartments_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDepartments.EditIndex = -1;
            LoadDepartments();
        }

        protected void btnAddepartment_Click(object sender, EventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserId"]);

                Department dept = new Department
                {
                    DepartmentName = txtDepartmentName.Text.Trim(),
                    Description = txtDescription.Text.Trim(),
                    IsActive = true,
                    CreatedBy = userId// Session User ID
                };

                bll.AddDepartments(dept);

                lblMessage.Text = "Department Added Successfully.";
                lblMessage.CssClass = "text-success";

                txtDepartmentName.Text = "";
                txtDescription.Text = "";

                LoadDepartments();
            }
            catch(Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.CssClass = "text-danger";
            }
            
        }
    }
}
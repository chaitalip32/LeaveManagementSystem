using System;
using System.Data;
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
        }

        private void LoadDepartments()
        {
            gvDepartments.DataSource = bll.GetAllDepartments();
            gvDepartments.DataBind();
        }

        //   EDIT CLICK
        protected void gvDepartments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditDept")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                DataTable dt = bll.GetDepartmentById(id);

                if (dt.Rows.Count > 0)
                {
                    hfDepartmentId.Value = id.ToString();
                    txtDeptName.Text = dt.Rows[0]["DepartmentName"].ToString();
                    txtDeptDesc.Text = dt.Rows[0]["Description"].ToString();

                    btnSave.Text = "Update";

                    ScriptManager.RegisterStartupScript(this, GetType(),
    "Popup",
    "var myModal = new bootstrap.Modal(document.getElementById('deptModal')); myModal.show();",
    true);
                }
            }
        }

        //   SAVE / UPDATE
        protected void btnSave_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            Department dept = new Department
            {
                DepartmentName = txtDeptName.Text.Trim(),
                Description = txtDeptDesc.Text.Trim(),
                IsActive = true
            };

            if (string.IsNullOrEmpty(hfDepartmentId.Value))
            {
                // ADD
                dept.CreatedBy = userId;
                bll.AddDepartments(dept);

                ScriptManager.RegisterStartupScript(this, GetType(), "addAlert",
    "Swal.fire('Success','Department added successfully','success');",
    true);
            }
            else
            {
                // UPDATE
                dept.DepartmentId = Convert.ToInt32(hfDepartmentId.Value);
                dept.UpdatedBy = userId;

                bll.EditDepartments(dept);

                ScriptManager.RegisterStartupScript(this, GetType(), "updateAlert",
    "Swal.fire('Success','Department updated successfully','success');",
    true);
            }

            LoadDepartments();

            ScriptManager.RegisterStartupScript(this, GetType(),
                "Popup", "var myModal = bootstrap.Modal.getInstance(document.getElementById('deptModal')); if(myModal){myModal.hide();}", true);
        }

        // DELETE
        protected void gvDepartments_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvDepartments.DataKeys[e.RowIndex].Value);

            bll.DeleteDepartment(id);

            ScriptManager.RegisterStartupScript(this, GetType(), "updateAlert",
    "Swal.fire('Success','Department deleted successfully','success');",
    true);
            lblMessage.CssClass = "text-success";

            LoadDepartments();
        }
    }
}
using System;
using System.Web.UI.WebControls;
using System.Web.UI;
using LeaveManagementSystem.BLL;

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

        protected void gvDepartments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditDept")
            {
                Response.Redirect("Add_Department.aspx?id=" + e.CommandArgument.ToString());
            }
        }

        protected void gvDepartments_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvDepartments.DataKeys[e.RowIndex].Value);
            bll.DeleteDepartment(id);
            LoadDepartments();
            ScriptManager.RegisterStartupScript(this, GetType(), "del", "Swal.fire('Deleted','Department removed','success');", true);
        }
    }
}
using System;
using System.Data;
using System.Web.UI;
using LeaveManagementSystem.BLL;
using LeaveManagementSystem.Models;

namespace LeaveManagementSystem.Admin
{
    public partial class Add_Department : System.Web.UI.Page
    {
        DepartmentBLL bll = new DepartmentBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int deptId;
                    if (int.TryParse(Request.QueryString["id"], out deptId))
                    {
                        LoadDepartmentData(deptId);
                    }
                }
            }
        }

        private void LoadDepartmentData(int id)
        {
            DataTable dt = bll.GetDepartmentById(id);
            if (dt != null && dt.Rows.Count > 0)
            {
                hfDepartmentId.Value = id.ToString();
                txtDeptName.Text = dt.Rows[0]["DepartmentName"].ToString();
                txtDeptDesc.Text = dt.Rows[0]["Description"].ToString();

                litTitle.Text = "Update Department";
                btnSave.Text = "Update";
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
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

                    dept.CreatedBy = userId;
                    bll.AddDepartments(dept);
                    ShowAlertAndRedirect("Department added successfully!");
                }
                else
                {

                    dept.DepartmentId = Convert.ToInt32(hfDepartmentId.Value);
                    dept.UpdatedBy = userId;
                    bll.EditDepartments(dept);
                    ShowAlertAndRedirect("Department updated successfully!");
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "err", $"Swal.fire('Error','{ex.Message}','error');", true);
            }
        }

        private void ShowAlertAndRedirect(string message)
        {
            string script = $@"Swal.fire('Success', '{message}', 'success').then((result) => {{
                window.location.href = 'Manage_Departments.aspx';
            }});";
            ScriptManager.RegisterStartupScript(this, GetType(), "redirect", script, true);
        }
    }
}
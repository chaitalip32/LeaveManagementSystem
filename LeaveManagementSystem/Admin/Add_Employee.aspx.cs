using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using LeaveManagementSystem.BLL;
using System.IO;
using LeaveManagementSystem.Models;
using LeaveManagementSystem.Helpers;

namespace LeaveManagementSystem.Admin
{
    public partial class Add_Employee : System.Web.UI.Page
    {
        LookupBLL lookupBLL = new LookupBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                LoadStates();
                LoadRoles();
                LoadDepartments();
                LoadManagers();
            }
        }

        private void LoadRoles()
        {
            DataTable dt = lookupBLL.GetRoles();

            ddlRole.DataSource = dt;

            ddlRole.DataTextField = "RoleName";
            ddlRole.DataValueField = "RoleId";
            ddlRole.DataBind();

            ddlRole.Items.Insert(0, new ListItem("-- Select Role --", ""));
        }

        private void LoadDepartments()
        {
            DataTable dt = lookupBLL.GetDepartments();

            ddlDepartment.DataSource = dt;

            ddlDepartment.DataTextField = "DepartmentName";
            ddlDepartment.DataValueField = "DepartmentId";
            ddlDepartment.DataBind();

            ddlDepartment.Items.Insert(0, new ListItem("-- Select Department --", ""));
        }

        private void LoadManagers()
        {
            DataTable dt = lookupBLL.GetManagers();

            ddlManager.DataSource = dt;
            ddlManager.DataTextField = "ManagerName";
            ddlManager.DataValueField = "EmployeeId";
            ddlManager.DataBind();

            ddlManager.Items.Insert(0, new ListItem("-- Select Manager --", ""));
        }

        private void LoadStates()
        {
            ddlState.Items.Clear();
            ddlState.Items.Insert(0, new ListItem("Select State", "0"));
            ddlState.Items.Add(new ListItem("Maharashtra", "1"));
            ddlState.Items.Add(new ListItem("Gujarat", "2"));

            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, new ListItem("Select City", "0"));
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0,new ListItem("Select City","0"));
            
            if(ddlState.SelectedValue=="1")
            {
                ddlCity.Items.Add(new ListItem("Mumbai", "1"));
                ddlCity.Items.Add(new ListItem("Pune", "2"));
                ddlCity.Items.Add(new ListItem("Nashik", "3"));
            }
            else if(ddlState.SelectedValue=="2")
            {
                ddlCity.Items.Add(new ListItem("Ahmedabad", "1"));
                ddlCity.Items.Add(new ListItem("Surat", "2"));
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                string imagepath = "";

                if(FileUpload1.HasFile)
                {
                    string folder = Server.MapPath("~/Uploads/ProfileImages/");

                    if (!Directory.Exists(folder))
                        Directory.CreateDirectory(folder);

                    string fileName = Guid.NewGuid().ToString() + Path.GetExtension(FileUpload1.FileName);

                    string fullPath = folder + fileName;

                    FileUpload1.SaveAs(fullPath);

                    imagepath = "~/Uploads/ProfileImages/" + fileName;   
                }

                string token = Guid.NewGuid().ToString();

                EmployeeModel emp = new EmployeeModel
                {
                    Email = txtEmail.Text.Trim(),
                    RoleId = Convert.ToInt32(ddlRole.SelectedValue),

                    DepartmentId = Convert.ToInt32(ddlDepartment.SelectedValue),
                    ManagerId = string.IsNullOrEmpty(ddlManager.SelectedValue) ? (int?)null : Convert.ToInt32(ddlManager.SelectedValue),

                    EmployeeCode = txtEmployeeCode.Text.Trim(),

                    FirstName = txtFirstName.Text.Trim(),
                    LastName = txtLastName.Text.Trim(),

                    Gender = rblgender.SelectedValue,

                    DateOfBirth = Convert.ToDateTime(txtDOB.Text),
                    DateOfJoining = Convert.ToDateTime(txtDOJ.Text),

                    PhoneNumber = txtPhone.Text.Trim(),

                    Address = txtAddress.Text.Trim(),

                    State = ddlState.SelectedItem.Text,
                    City = ddlCity.SelectedItem.Text,

                    ProfileImagePath = imagepath,

                    PasswordToken = token,
                    TokenExpiry = DateTime.Now.AddHours(24)
                };

                EmployeeBLL bll = new EmployeeBLL();

                bll.AddEmployee(emp);

                string emailError;

                bool emailSent= EmailHelper.SendPasswordSetupEmail(emp.Email, token,out emailError);

                if (emailSent)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "success",
                    "window.onload=function(){Swal.fire({title:'Success',text:'Employee added successfully. Password setup email sent.',icon:'success'});};",
                    true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "warning",
                    "window.onload=function(){Swal.fire({title:'Warning',text:'Employee added but email failed: " + emailError + "',icon:'warning'});};",
                    true);
                }

        
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error",
                "window.onload=function(){Swal.fire({title:'Error',text:'Error while saving employee: " + ex.Message.Replace("'", "") + "',icon:'error'});};",
                true);
            }
        }
    }
}
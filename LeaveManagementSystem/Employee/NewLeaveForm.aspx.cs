using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;
using System.Data;

namespace LeaveManagementSystem.Employee
{
    public partial class NewLeaveForm : System.Web.UI.Page
    {
        EmployeeBLL bll = new EmployeeBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                BindManagersAndHR();
                BindLeaveTypes();
            }
        }

        private void BindManagersAndHR()
        {
            try
            {
                DataTable dt = bll.GetManagersAndHR();

                cblCCEmail.DataSource = dt;
                cblCCEmail.DataTextField = "Name";
                cblCCEmail.DataValueField = "Email";
                cblCCEmail.DataBind();

                // Emails of the managers and HR
                List<string> selectedEmails = new List<string>();

                foreach(ListItem item in cblCCEmail.Items)
                {
                    if(item.Selected)
                    {
                        selectedEmails.Add(item.Value);
                    }
                }

                string ccEmail = string.Join(",", selectedEmails);
            }
            catch(Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
        "error", "alert('Error loading managers');", true);
            }
        }

        public void BindLeaveTypes()
        {
            try
            {
                DataTable dt = bll.GetLeaveTypes();

                ddlLeaveType.DataSource = dt;
                ddlLeaveType.DataTextField = "LeaveTypeName";
                ddlLeaveType.DataValueField = "LeaveTypeId";
                ddlLeaveType.DataBind();

                ddlLeaveType.Items.Insert(0, new ListItem("-- Select Leave Type --", ""));
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
        "error", "alert('Error loading leave types');", true);
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;
using System.Data;
using LeaveManagementSystem.Models;
using LeaveManagementSystem.Helpers;

namespace LeaveManagementSystem.Employee
{
    public partial class NewLeaveForm : System.Web.UI.Page
    {
             
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeId"] == null)
            {
                Response.Redirect("~/Account/Login.aspx");
            }

            if (!IsPostBack)
            {
                rblLeaveDay.SelectedIndex = 1;
                BindManagersAndHR();
                BindLeaveTypes();
                ToggleLeavePanels();

                txtFromDate.Attributes.Add("onchange", "calculateDays()");
                txtToDate.Attributes.Add("onchange", "calculateDays()");
                txtHalfDayDate.Attributes.Add("onchange", "calculateDays()");

                DateTime today = DateTime.Today;

                calFromDate.StartDate = today;
                calToDate.StartDate = today;
                calhalfDate.StartDate = today;
            }
        }
            
        private void ToggleLeavePanels()
        {
            if(rblLeaveDay.SelectedValue=="Half Day")
            {
                pnlHalfDay.Visible = true;
                pnlFullDay.Visible = false;
            }
            else
            {
                pnlFullDay.Visible = true;
                pnlHalfDay.Visible = false;
            }
        }

        protected void rblLeaveDay_SelectedIndexChanged(object sender, EventArgs e)
        {
            ToggleLeavePanels();
        }

        private void BindManagersAndHR()
        {
            try
            {
                EmployeeBLL bll = new EmployeeBLL();

                DataTable dt = bll.GetManagersAndHR();

                cblCCEmail.DataSource = dt;
                cblCCEmail.DataTextField = "Name";
                cblCCEmail.DataValueField = "Email";
                cblCCEmail.DataBind();              
            }
            catch(Exception)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error",
"window.onload=function(){Swal.fire('Error','Error loading managers','error');};",
true);
            }
        }

        public void BindLeaveTypes()
        {
            try
            {
                EmployeeBLL bll = new EmployeeBLL();

                DataTable dt = bll.GetLeaveTypes();

                ddlLeaveType.DataSource = dt;
                ddlLeaveType.DataTextField = "LeaveTypeName";
                ddlLeaveType.DataValueField = "LeaveTypeId";
                ddlLeaveType.DataBind();

                ddlLeaveType.Items.Insert(0, new ListItem("-- Select Leave Type --", ""));
            }
            catch (Exception)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error",
"window.onload=function(){Swal.fire('Error','Error loading leave types','error');};",
true);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {          
            if (Page.IsValid)
            {
                LeaveApplication leave = new LeaveApplication();

                // for checking sesion id
                //Response.Write("EmployeeId Session: " + Session["EmployeeId"]);

                leave.EmployeeId = Convert.ToInt32(Session["EmployeeId"]);
                leave.LeaveTypeId = Convert.ToInt32(ddlLeaveType.SelectedValue);
                leave.Reason = txtReason.Text;

                if(rblLeaveDay.SelectedValue=="Full Day")
                {
                    DateTime fromDate, toDate;

                    if (!DateTime.TryParse(txtFromDate.Text, out fromDate) ||
                        !DateTime.TryParse(txtToDate.Text, out toDate))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "dateerror",
"window.onload=function(){Swal.fire('Error','Please select valid dates','error');};",
true);

                        return;
                    }

                    leave.FromDate = fromDate;
                    leave.ToDate = toDate;


                    //  leave.TotalDays = Convert.ToDecimal(txtNoOfDays.Text);
                    leave.TotalDays = (leave.ToDate - leave.FromDate).Days + 1;

                      leave.DayType = null;
                }
                else
                {
                    DateTime halfDate;

                    if (!DateTime.TryParse(txtHalfDayDate.Text, out halfDate))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "dateerror",
"window.onload=function(){Swal.fire('Error','Please select a valid date','error');};",
true);
                      
                        return;
                    }

                    leave.FromDate = halfDate;
                    leave.ToDate = halfDate;

                    leave.TotalDays = 0.5m;

                    leave.DayType = ddlDayType.SelectedValue;
                }

                leave.ManagerId = GetManagerId(leave.EmployeeId);

                LeaveApplicationBLL leavebll = new LeaveApplicationBLL();

                //getting employee name and department to send in email
                DataTable empdt = leavebll.GetEmployeeDetails(leave.EmployeeId);

                string employeeName = "";
                string departmentName = "";

                if(empdt.Rows.Count>0)
                {
                    employeeName = empdt.Rows[0]["Name"].ToString();
                    departmentName = empdt.Rows[0]["DepartmentName"].ToString();
                }

                leavebll.ApplyLeave(leave);
               
                // Emails of the managers and HR
                List<string> selectedEmails = new List<string>();

                foreach (ListItem item in cblCCEmail.Items)
                {
                    if (item.Selected)
                    {
                        selectedEmails.Add(item.Value);
                    }
                }

                string ccEmail = string.Join(",", selectedEmails);

                string subject = txtSubject.Text;

                string body = "A new leave request has been submitted.<br/><br/>" +
                    "Employee ID: " + leave.EmployeeId + "<br/>" +
                    "Employee Name: "+ employeeName +"<br/>"+
                    "Employee Department: "+ departmentName +"<br/>"+ 
                    "Leave type:" + ddlLeaveType.SelectedItem.Text+"<br/>"+
                    "From Date: "+leave.FromDate+"<br/>"+
                    "To Date:"+leave.ToDate+"<br/>"+
                    "Reason: "+leave.Reason;

                string employeeEmail = Session["Email"].ToString();

                string error;
                bool sent= EmailHelper.SendLeaveApplicationEmail(employeeEmail, ccEmail,subject,body,out error);

                if(sent)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "success",
"window.onload=function(){Swal.fire('Success','Leave applied and email sent successfully','success');};",
true);
                }
                else
               {
                    ClientScript.RegisterStartupScript(this.GetType(), "error",
"window.onload=function(){Swal.fire('Warning','Leave applied but email failed: " + error + "','warning');};",
true);
                }
            }
        }

        public int GetManagerId(int employeeId)
        {
            int managerId = 0;

            try
            {
                LeaveApplicationBLL leavebll = new LeaveApplicationBLL();

                DataTable dt = leavebll.GetManagerByEmployee(employeeId);

                if (dt.Rows.Count > 0 && dt.Rows[0]["ManagerId"] != DBNull.Value)
                {
                    managerId = Convert.ToInt32(dt.Rows[0]["ManagerId"]);
                }
            }
            catch(Exception)
            {
                throw;
            }
            return managerId;
        }
    }
}
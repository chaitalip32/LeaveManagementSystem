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

                string body = @"
                <!DOCTYPE html>
                <html>
                <head>
                <meta name='viewport' content='width=device-width, initial-scale=1.0'/>
                </head>

                <body style='margin:0;padding:0;background-color:#f4f6f8;font-family:Segoe UI,Arial,sans-serif;'>

                <table width='100%' cellpadding='0' cellspacing='0' style='background-color:#f4f6f8;padding:20px;'>
                <tr>
                <td align='center'>

                    <!-- MAIN CARD -->
                    <table width='100%' cellpadding='0' cellspacing='0' style='max-width:600px;background:#ffffff;border-radius:8px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,0.05);'>

                        <!-- HEADER -->
                        <tr>
                            <td style='background:#7E72FA;color:#ffffff;padding:16px 20px;font-size:18px;font-weight:600;'>
                                Leave Management System
                            </td>
                        </tr>

                        <!-- TITLE -->
                        <tr>
                            <td style='padding:20px 20px 10px 20px;'>
                                <h2 style='margin:0;color:#111827;font-size:20px;'>New Leave Request</h2>
                            </td>
                        </tr>

                        <!-- MESSAGE -->
                        <tr>
                            <td style='padding:0 20px 20px 20px;color:#4b5563;font-size:14px;line-height:1.5;'>
                                A new leave request has been submitted. Below are the details:
                            </td>
                        </tr>

                        <!-- DETAILS TABLE -->
                        <tr>
                            <td style='padding:0 20px 20px 20px;'>
                                <table width='100%' cellpadding='0' cellspacing='0' style='border-collapse:collapse;font-size:14px;'>

                                    <tr>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;color:#6b7280;'>Employee ID</td>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;font-weight:500;'>" + leave.EmployeeId + @"</td>
                                    </tr>

                                    <tr>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;color:#6b7280;'>Employee Name</td>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;font-weight:500;'>" + employeeName + @"</td>
                                    </tr>

                                    <tr>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;color:#6b7280;'>Department</td>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;font-weight:500;'>" + departmentName + @"</td>
                                    </tr>

                                    <tr>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;color:#6b7280;'>Leave Type</td>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;font-weight:500;'>" + ddlLeaveType.SelectedItem.Text + @"</td>
                                    </tr>

                                    <tr>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;color:#6b7280;'>From Date</td>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;font-weight:500;'>" + leave.FromDate.ToString("dd MMM yyyy") + @"</td>
                                    </tr>

                                    <tr>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;color:#6b7280;'>To Date</td>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;font-weight:500;'>" + leave.ToDate.ToString("dd MMM yyyy") + @"</td>
                                    </tr>

                                    <tr>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;color:#6b7280;'>Total Days</td>
                                        <td style='padding:10px;border-bottom:1px solid #e5e7eb;font-weight:500;'>" + leave.TotalDays + @"</td>
                                    </tr>

                                    <tr>
                                        <td style='padding:10px;vertical-align:top;color:#6b7280;'>Reason</td>
                                        <td style='padding:10px;font-weight:500;'>" + HttpUtility.HtmlEncode(leave.Reason) + @"</td>
                                    </tr>

                                </table>
                            </td>
                        </tr>

                        <!-- STATUS -->
                        <tr>
                            <td style='padding:0 20px 20px 20px;'>
                                <span style='display:inline-block;padding:6px 12px;background:#fef3c7;color:#92400e;border-radius:20px;font-size:12px;font-weight:600;'>
                                    Pending Approval
                                </span>
                            </td>
                        </tr>

                        <!-- FOOTER -->
                        <tr>
                            <td style='background:#f9fafb;padding:15px 20px;font-size:12px;color:#9ca3af;text-align:center;'>
                                This is an automated email. Please do not reply.<br/>
                                © Leave Management System
                            </td>
                        </tr>

                    </table>

                </td>
                </tr>
                </table>

                </body>
                </html>";

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
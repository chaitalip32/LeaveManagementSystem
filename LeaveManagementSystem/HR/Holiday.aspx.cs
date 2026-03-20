using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.Models;
using LeaveManagementSystem.BLL;
using System.Data;

namespace LeaveManagementSystem.HR
{
    public partial class Holiday : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {          
            if(!IsPostBack)
            {
                if(Request.QueryString["Id"]!=null)
                {
                    DateTime today = DateTime.Today;
                    calHolidayDate.StartDate = today;

                    int id = Convert.ToInt32(Request.QueryString["Id"]);
                    LoadHolidayById(id);

                    btnSubmit.Text = "Update";
                }
            }
        }

        protected void LoadHolidayById(int id)
        {
            HolidayBLL bll = new HolidayBLL();
            DataTable dt = bll.GetHolidayById(id);

            if(dt.Rows.Count>0)
            {
                txtHolidayName.Text = dt.Rows[0]["HolidayName"].ToString();
                txtHolidayDate.Text = Convert.ToDateTime(dt.Rows[0]["HolidayDate"]).ToString("yyyy-MM-dd");
                txtDescription.Text = dt.Rows[0]["Description"].ToString();

                rblStatus.SelectedValue = dt.Rows[0]["IsActive"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            HolidayBLL bll = new HolidayBLL();

            if (Request.QueryString["Id"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["Id"]);

                string name = txtHolidayName.Text.Trim();
                string desc = txtDescription.Text.Trim();
                DateTime date = Convert.ToDateTime(txtHolidayDate.Text);
                int status= Convert.ToInt32(rblStatus.SelectedValue);

                bll.UpdateHoliday(id,name,date,desc,status);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "success",
                    "alert('Holiday updated successfully');", true);
            }
            else
            {
                Holidays hl = new Holidays
                {
                    HolidayName = txtHolidayName.Text.Trim(),
                    HolidayDate = Convert.ToDateTime(txtHolidayDate.Text),
                    Description = txtDescription.Text.Trim(),
                    IsActive = rblStatus.SelectedValue == "1",
                    CreatedBy = userId
                };


                bll.AddHoliday(hl);

                ScriptManager.RegisterStartupScript(this, this.GetType(),
            "success", "alert('Holiday added successfully');", true);

                txtHolidayName.Text = "";
                txtHolidayDate.Text = "";
                txtDescription.Text = "";
            }
            
        }
    }
}
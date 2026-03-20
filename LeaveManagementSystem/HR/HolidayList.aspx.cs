using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LeaveManagementSystem.BLL;
using System.Data;

namespace LeaveManagementSystem.HR
{
    public partial class HolidayList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                LoadHolidayList();
            }
        }

        private void LoadHolidayList()
        {
            HolidayBLL bll = new HolidayBLL();
            DataTable dt = bll.getHolidayList();

            gvHolidayList.DataSource = dt;
            gvHolidayList.DataBind();
        }

        protected void gvHolidayList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName=="EditHoliday")
            {
                int holidayId = Convert.ToInt32(e.CommandArgument);

                Response.Redirect("Holiday.aspx?Id=" + holidayId);
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using LeaveManagementSystem.BLL;

namespace LeaveManagementSystem.Admin
{
    public partial class EmployeeList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                BinEmployeeList();
            }
        }

        protected void BinEmployeeList()
        {
            EmployeeBLL bll = new EmployeeBLL();

            DataTable dt = bll.GetEmployeeList();

            gvEmployeeList.DataSource = dt;
            gvEmployeeList.DataBind();
        }
    }
}
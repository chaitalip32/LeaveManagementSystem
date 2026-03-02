using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LeaveManagementSystem.Admin
{
    public partial class Add_Employee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                LoadStates();
            }
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
    }
}
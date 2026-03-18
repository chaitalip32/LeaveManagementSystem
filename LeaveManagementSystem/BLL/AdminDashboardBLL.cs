using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using LeaveManagementSystem.DAL;

namespace LeaveManagementSystem.BLL
{
    public class AdminDashboardBLL
    {
        AdminDashboardDAL dal = new AdminDashboardDAL();

        public DataTable GetDashboardCounts()
        {
            return dal.GetDashboardCounts();
        }
    }
}
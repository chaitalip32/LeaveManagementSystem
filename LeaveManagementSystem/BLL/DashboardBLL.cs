using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LeaveManagementSystem.DAL;
using System.Data;

namespace LeaveManagementSystem.BLL
{
    public class DashboardBLL
    {
        DashboardDAL dal = new DashboardDAL();

        public DataTable GetDashboardData(int employeeId)
        {
            return dal.GetDashboardData(employeeId);
        }

        public DataTable GetLeaveTypeChart(int employeeId)
        {
            return dal.GetLeaveTypeChart(employeeId);
        }

    }
}
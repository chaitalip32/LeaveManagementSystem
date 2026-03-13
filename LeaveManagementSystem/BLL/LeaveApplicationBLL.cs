using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LeaveManagementSystem.Models;
using LeaveManagementSystem.DAL;
using System.Data;

namespace LeaveManagementSystem.BLL
{
    public class LeaveApplicationBLL
    {
        LeaveApplicationDAL dal = new LeaveApplicationDAL();

        public void ApplyLeave(LeaveApplication leave)
        {
            dal.InsertLeaveApplication(leave);
        }

        public DataTable GetManagerByEmployee(int employeeId)
        {
            return dal.GetManagerByEmployee(employeeId);
        }

        public DataTable GetEmployeeDetails(int employeeId)
        {
            return dal.GetEmployeeDetails(employeeId); 
        }

        public DataTable GetManagerLeaveRequests(int managerId)
        {
            return dal.GetManagerLeaveRequests(managerId);
        }
    }
}
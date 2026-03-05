using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using LeaveManagementSystem.DAL;
using LeaveManagementSystem.Models;

namespace LeaveManagementSystem.BLL
{
    public class LeaveTypeBLL
    {

        LeaveTypeDAL dal = new LeaveTypeDAL();

        public DataTable GetLeaveTypes(string search="")
        {
            return dal.GetLeaveTypes(search);
        }

        public void AddLeaveType(LeaveType model)
        {
            dal.InsertLeaveTypes(model);
        }
    }
}
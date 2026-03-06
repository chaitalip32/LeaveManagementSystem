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

        public LeaveType GetLeaveTypeById(int id)
        {
            return dal.GetLeaveTypeById(id);
        }

        public void AddLeaveType(LeaveType model)
        {
            dal.InsertLeaveTypes(model);
        }

        public int UpdateLeaveType(LeaveType model)
        {
            return dal.UpdateLeaveType(model);
        }

        public int DeleteLeaveType(int id)
        {
            return dal.DeleteLeaveType(id);
        }
    }
}
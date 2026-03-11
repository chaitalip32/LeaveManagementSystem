using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using LeaveManagementSystem.DAL;
using LeaveManagementSystem.Models;

namespace LeaveManagementSystem.BLL
{
    public class EmployeeBLL
    {
        EmployeeDAL dal = new EmployeeDAL();

        public int AddEmployee(EmployeeModel emp)
        {
            return dal.AddEmployee(emp);
        }

        public DataTable GetManagersAndHR()
        {
            try
            {
                return dal.GetManagersAndHR();
            }
            catch(Exception ex)
            {
                throw new Exception("BLL Error while fetching Managers and HR", ex);
            }
        }

        public DataTable GetLeaveTypes()
        {
            try
            {
                return dal.GetLeaveTypes();
            }
            catch(Exception ex)
            {
                throw new Exception("BLL Error while fetching leave types"+ex.Message);
            }
        }
    }
}
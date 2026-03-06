using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
    }
}
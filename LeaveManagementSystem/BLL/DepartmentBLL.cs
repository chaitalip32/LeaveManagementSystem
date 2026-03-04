using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LeaveManagementSystem.DAL;
using LeaveManagementSystem.Models;
using System.Data;

namespace LeaveManagementSystem.BLL
{
    public class DepartmentBLL
    {
        private DepartmentDAL dal = new DepartmentDAL();

        public DataTable GetAllDepartments()
        {
            return dal.GetAllDepartments();
        }

        public void AddDepartments(Department dept)
        {
            dal.InsertDepartment(dept);
        }

        public void EditDepartments(Department dept)
        {
            dal.UpdateDepartment(dept);
        }

        public void DeleteDepartment(int id)
        {
            dal.DeleteDepartment(id);
        }

        public int GetDepartmentCount()
        {
            return dal.getDepartmentCount();
        }
    }
}
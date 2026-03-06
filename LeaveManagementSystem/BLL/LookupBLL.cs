using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using LeaveManagementSystem.DAL;

namespace LeaveManagementSystem.BLL
{
    public class LookupBLL
    {
        LookupDAL dal = new LookupDAL();

        public DataTable GetRoles()
        {
            return dal.GetRoles();
        }

        public DataTable GetDepartments()
        {
            return dal.GetDepartments();
        }

        public DataTable GetManagers()
        {
            return dal.GetManagers();
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using LeaveManagementSystem.DAL;
using LeaveManagementSystem.Models;

namespace LeaveManagementSystem.BLL
{
    public class HolidayBLL
    {
        HolidayDAL dal = new HolidayDAL();

        public int AddHoliday(Holidays hl)
        {
            return dal.AddHoliday(hl);
        }

        public DataTable getHolidayList()
        {
            return dal.getHolidayList();
        }

        public DataTable GetHolidayById(int id)
        {
            return dal.GetHolidayById(id);
        }

        public void UpdateHoliday(int id, string name, DateTime date, String desc, int status)
        {
            dal.UpdateHoliday(id, name, date, desc, status);
        }
    }
}
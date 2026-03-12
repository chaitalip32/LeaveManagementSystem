using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LeaveManagementSystem.Models
{
    public class LeaveApplication
    {
        public int EmployeeId { get; set; }
        public int LeaveTypeId { get; set; }

        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }

        public decimal TotalDays { get; set; }

        public string DayType { get; set; }//this is for half day or full day

        public string Reason { get; set; }

        public int ManagerId { get; set; }
    }
}
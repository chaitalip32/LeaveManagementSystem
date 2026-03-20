using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LeaveManagementSystem.Models
{
    public class Holidays
    {
        public int HolidayId { get; set; }

        public DateTime HolidayDate { get; set; }

        public string HolidayName { get; set; }

        public string Description { get; set; }

        public bool IsActive;

        public DateTime CreatedDate { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? UpdatedDate { get; set; }
        public int? UpdatedBy { get; set; }
    }
}
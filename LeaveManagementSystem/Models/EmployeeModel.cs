using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LeaveManagementSystem.Models
{
    public class EmployeeModel
    {
        public int UserId { get; set; }

        public string Email { get; set; }
        public int RoleId { get; set; }

        public int DepartmentId { get; set; }
        public int? ManagerId { get; set; }

        public string EmployeeCode { get; set; }

        public DateTime DateOfJoining { get; set; }

        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Gender { get; set; }

        public DateTime DateOfBirth { get; set; }

        public string PhoneNumber { get; set; }
        public string Address { get; set; }

        public string State { get; set; }
        public string City { get; set; }

        public string ProfileImagePath { get; set; }

        public string PasswordToken { get; set; }
        public DateTime TokenExpiry { get; set; }

        //public int CreatedBy { get; set; }

    }
}
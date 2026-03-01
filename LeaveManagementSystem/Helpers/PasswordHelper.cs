using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BCrypt.Net;

namespace LeaveManagementSystem.Helpers
{
    public class PasswordHelper
    {
        public static string HashPassword(string password)
        {
            return BCrypt.Net.BCrypt.HashPassword(password);
        }

        public static bool VerifyPassword(string enteredpassword, string storedHash)
        {
            return BCrypt.Net.BCrypt.Verify(enteredpassword, storedHash); // will return true or false
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LeaveManagementSystem.DAL;
using LeaveManagementSystem.Models;
using LeaveManagementSystem.Helpers;
namespace LeaveManagementSystem.BLL
{
    public class UserBLL
    {
        UserDAL dal = new UserDAL();

        public UserModel ValidateUsers(string email, string password)
        {
            UserModel user = dal.GetUsersByEmail(email);

            if (user == null)
                return null;

            if (!user.IsActive)
                return null;

            bool isValid = PasswordHelper.VerifyPassword(password, user.PasswordHash);

            if (!isValid)
                return null;

            dal.UpdateLastLogin(user.UserId);

            return user;
        }
    }
}
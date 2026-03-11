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

        public bool ResetPassword(string token, string password)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(password))
                    throw new Exception("Password cannot be empty");

                if (password.Length < 6)
                    throw new Exception("Password must be at lease 6 characters.");

                //Bcrypt hashing
                string hashedPassword = BCrypt.Net.BCrypt.HashPassword(password);
                return dal.ResetPassword(token, hashedPassword);
            }
            catch(Exception ex)
            {
                throw;
            }
        }

        public bool GeneratePasswordResetToken(string email)
        {
            var user = dal.GetUsersByEmail(email);

            if (user == null)
                return false;

            string token = Guid.NewGuid().ToString();

            DateTime expiry = DateTime.Now.AddMinutes(30);

            dal.SaveResetToken(user.UserId, token, expiry);

            string error;

            EmailHelper.SendPasswordSetupEmail(email, token, out error);

            return true;
        }      
    }
}
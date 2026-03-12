using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using LeaveManagementSystem.Models;
namespace LeaveManagementSystem.DAL
{
    public class UserDAL
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        public UserModel GetUsersByEmail(string email)
        {
            UserModel user = null;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Users WHERE Email=@Email";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if(dr.Read())
                {
                    user = new UserModel
                    {
                        UserId = Convert.ToInt32(dr["UserId"]),
                        Email = dr["Email"].ToString(),
                        PasswordHash = dr["PasswordHash"].ToString(),
                        RoleId = Convert.ToInt32(dr["RoleId"]),
                        IsActive = Convert.ToBoolean(dr["IsActive"]),
                        IsFirstLogin = Convert.ToBoolean(dr["IsFirstLogin"])
                    };
                }
            }

            return user;
        }

        // for session storage getting employee id
        public int GetEmployeeIdByUserId(int userId)
        {
            int employeeId = 0;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT EmployeeId FROM Employees WHERE UserId=@UserId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    employeeId = Convert.ToInt32(result);
                }
            }

            return employeeId;
        }

        public void SaveResetToken(int userId,string token,DateTime expiry)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"UPDATE Users
                                   SET PasswordSetupToken=@Token,
                                       TokenExpiry=@Expiry
                                   WHERE UserId=@UserId";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@Token", token);
                    cmd.Parameters.AddWithValue("@Expiry", expiry);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void UpdateLastLogin(int userId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "Update Users SET LastLoginDate=GETDATE() WHERE UserId=@UserId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public bool ResetPassword(string token, string passwordHash)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"UPDATE Users
                                   SET PasswordHash=@PasswordHash,
                                       PasswordSetupToken=NULL,
                                       TokenExpiry=NULL,
                                       IsFirstLogin=0,
                                       UpdatedDate=GETDATE()
                                   WHERE PasswordSetupToken=@Token
                                   AND TokenExpiry > GETDATE()
                                   AND IsActive=1";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add("@PasswordHash", System.Data.SqlDbType.VarChar, 255).Value= passwordHash;
                        cmd.Parameters.Add("@Token", System.Data.SqlDbType.VarChar, 100).Value = token;

                        con.Open();

                        int rows = cmd.ExecuteNonQuery();

                        return rows > 0;
                    }
                }
            }
            catch(SqlException ex)
            {
                throw new Exception("Database error while resetting password.", ex);
            }
            catch(Exception ex)
            {
                throw new Exception("Unexpected error in ResetPassword DAL.", ex);
            }
        }

    }
}
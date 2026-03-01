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

    }
}
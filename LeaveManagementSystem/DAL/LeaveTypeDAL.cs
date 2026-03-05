using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using LeaveManagementSystem.Models;

namespace LeaveManagementSystem.DAL
{
    public class LeaveTypeDAL
    {

        string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString; 

        public DataTable GetLeaveTypes(string search="")
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT * FROM LeaveTypes
                                WHERE LeaveTypeName LIKE @search
                                ORDER BY CreatedDate DESC";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error fetching leave types: "+ ex.Message);
            }

            return dt;
        }

        public void InsertLeaveTypes(LeaveType model)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO LeaveTypes
                                (LeaveTypeName, DefaultDays, Description, IsActive, CreatedBy)
                                VALUES
                                (@Name, @Days, @Desc, @Status, @CreatedBy)";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@Name", model.LeaveTypeName);
                    cmd.Parameters.AddWithValue("@Days", model.DefaultDays);
                    cmd.Parameters.AddWithValue("@Desc", model.Description);
                    cmd.Parameters.AddWithValue("@Status", model.IsActive);
                    cmd.Parameters.AddWithValue("@CreatedBy", model.CreatedBy);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch(SqlException ex)
            {
                if (ex.Number == 2627) //error for unique constraint
                    throw new Exception("Leave type already exists.");
                else
                    throw new Exception("database error while adding leave types.");
            }
            catch(Exception)
            {
                throw;
            }
        }
    }
}
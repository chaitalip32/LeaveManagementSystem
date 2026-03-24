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

        // For searching
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

        // To fetch Data in gridView of all records
        public LeaveType GetLeaveTypeById(int id)
        {
            LeaveType leave = new LeaveType();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT * FROM LeaveTypes
                                WHERE LeaveTypeId=@LeaveTypeId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@LeaveTypeId", id);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if(dr.Read())
                {
                    leave.LeaveTypeId = Convert.ToInt32(dr["LeaveTypeId"]);
                    leave.LeaveTypeName = dr["LeaveTypeName"].ToString();
                    leave.DefaultDays = Convert.ToInt32(dr["DefaultDays"]);
                    leave.Description = dr["Description"].ToString();
                    leave.IsActive = Convert.ToBoolean(dr["IsActive"]);
                }
            }
            return leave;
        }


        public void InsertLeaveTypes(LeaveType leave)
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

                    cmd.Parameters.AddWithValue("@Name", leave.LeaveTypeName);
                    cmd.Parameters.AddWithValue("@Days", leave.DefaultDays);
                    cmd.Parameters.AddWithValue("@Desc", leave.Description);
                    cmd.Parameters.AddWithValue("@Status", leave.IsActive);
                    cmd.Parameters.AddWithValue("@CreatedBy", leave.CreatedBy);

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

        public int UpdateLeaveType(LeaveType leave)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"UPDATE LeaveTypes
                                   SET LeavetypeName = @LeaveTypeName,
                                        DefaultDays=@DefaultDays,
                                        Description=@Desc,
                                        IsActive=@IsActive
                                    WHERE LeaveTypeId=@LeaveTypeId";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@LeaveTypeName", leave.LeaveTypeName);
                    cmd.Parameters.AddWithValue("@DefaultDays", leave.DefaultDays);
                    cmd.Parameters.AddWithValue("@Desc", leave.Description);
                    cmd.Parameters.AddWithValue("@IsActive", leave.IsActive);
                    cmd.Parameters.AddWithValue("@LeaveTypeId", leave.LeaveTypeId);

                    con.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error updating leave type: " + ex.Message);
            }
        }

        public int DeleteLeaveType(int id)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {

                    string query = @"DELETE FROM LeaveTypes WHERE LeaveTypeId=@LeaveTypeId";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@LeaveTypeId", id);

                    con.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error Deleting leave type: " + ex.Message);
            }
        }
    }
}
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
    public class HolidayDAL
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        public int AddHoliday(Holidays hl)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"insert into Holidays
                                    (HolidayDate, HolidayName, Description, IsActive, CreatedBy)
                                    VALUES
                                    (@HolidayDate,@HolidayName,@Description, @IsActive, @CreatedBy)";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@HolidayDate",hl.HolidayDate);
                        cmd.Parameters.AddWithValue("@HolidayName",hl.HolidayName);
                        cmd.Parameters.AddWithValue("@Description",hl.Description);
                        cmd.Parameters.AddWithValue("@IsActive",hl.IsActive);
                        cmd.Parameters.AddWithValue("@CreatedBy",hl.CreatedBy);

                        con.Open();
                        return cmd.ExecuteNonQuery();
                    }
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error adding holiday: "+ex.Message);
            }
        }

        public DataTable getHolidayList()
        {
            try
            {
                DataTable dt = new DataTable();

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT 
                    HolidayId, HolidayDate, HolidayName, Description, 
                    CASE WHEN IsActive= 1 THEN 'Active'
                         ELSE 'Inactive'
                    END AS Status 
                    FROM Holidays";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                    }
                }
                return dt;
            }
            catch(Exception ex)
            {
                throw new Exception("Error in fetching holiday list: "+ex);
            }
        }

        // data to update the holiday 
        public DataTable GetHolidayById(int id)
        {
            try
            {
                DataTable dt = new DataTable();
                using (SqlConnection con = new SqlConnection(cs))
                {
                        string query = @"SELECT HolidayId, HolidayName, HolidayDate, Description, IsActive 
                                        FROM Holidays 
                                        WHERE HolidayId=@Id";

                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@Id", id);

                            SqlDataAdapter da = new SqlDataAdapter(cmd);
                            da.Fill(dt);
                        }
                }
                
                return dt;
            }
            catch(Exception ex)
            {
                throw new Exception("Error in fetching holiday records by id: " + ex.Message);
            }
        }

        public void UpdateHoliday(int id, string name, DateTime date, string desc, int status)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"UPDATE Holidays
                                SET HolidayName=@Name, HolidayDate=@Date, Description=@Desc,IsActive=@Status
                                WHERE HolidayId=@Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Date", date);
                    cmd.Parameters.AddWithValue("@Desc", desc);
                    cmd.Parameters.AddWithValue("@Status", status);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}
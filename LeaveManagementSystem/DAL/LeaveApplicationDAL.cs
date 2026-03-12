using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LeaveManagementSystem.Models;
using LeaveManagementSystem.DAL;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace LeaveManagementSystem.DAL
{
    public class LeaveApplicationDAL
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        public void InsertLeaveApplication(LeaveApplication leave)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO LeaveApplications
                            (EmployeeId, LeaveTypeId, FromDate, ToDate, 
                            TotalDays, DayType, Reason, ManagerId)
                            VALUES 
                            (@EmployeeId,@LeaveTypeId,@FromDate,@ToDate,
                            @TotalDays,@DayType,@Reason,@ManagerId)";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@EmployeeId", leave.EmployeeId);
                    cmd.Parameters.AddWithValue("@LeaveTypeId", leave.LeaveTypeId);
                    cmd.Parameters.AddWithValue("@FromDate", leave.FromDate);
                    cmd.Parameters.AddWithValue("@ToDate", leave.ToDate);
                    cmd.Parameters.AddWithValue("@TotalDays", leave.TotalDays);
                    cmd.Parameters.AddWithValue("@DayType", string.IsNullOrEmpty(leave.DayType)?(object)DBNull.Value : leave.DayType);
                    cmd.Parameters.AddWithValue("@Reason", leave.Reason);
                    cmd.Parameters.AddWithValue("@ManagerId", leave.ManagerId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }     
            catch(Exception ex)
            {
                throw new Exception("Error while inserting leave application record"+ex.Message);
            }
        }

        public DataTable GetManagerByEmployee(int employeeId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT ManagerId from Employees WHERE EmployeeId=@EmployeeId";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@EmployeeId", employeeId);

                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    return dt;
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error fetching ManagerId"+ ex.Message);
            }
        }
    }
}
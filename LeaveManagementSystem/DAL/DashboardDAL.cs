using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace LeaveManagementSystem.DAL
{
    public class DashboardDAL
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        public DataTable GetDashboardData(int employeeId)
        {
            try
            {
                DataTable dt = new DataTable();
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"
                                    SELECT 

                                    -- Total allocated days
                                    (SELECT ISNULL(SUM(AllocatedDays),0)
                                     FROM LeaveBalance 
                                     WHERE EmployeeId=@EmployeeId) AS TotalAllocated,

                                    -- Total used days (Approved leaves)
                                    (SELECT ISNULL(SUM(TotalDays),0)
                                     FROM LeaveApplications 
                                     WHERE EmployeeId=@EmployeeId 
                                     AND Status='Approved') AS TotalUsed,

                                    -- Remaining balance (Allocated - Used)
                                    (
                                        (SELECT ISNULL(SUM(AllocatedDays),0)
                                         FROM LeaveBalance 
                                         WHERE EmployeeId=@EmployeeId)

                                        -

                                        (SELECT ISNULL(SUM(TotalDays),0)
                                         FROM LeaveApplications 
                                         WHERE EmployeeId=@EmployeeId 
                                         AND Status='Approved')
                                    ) AS RemainingBalance,

                                    -- Pending request count
                                    (SELECT COUNT(*) 
                                     FROM LeaveApplications 
                                     WHERE EmployeeId=@EmployeeId
                                     AND Status LIKE 'Pending%') AS PendingCount,

                                    -- Approved request count
                                    (SELECT COUNT(*)
                                     FROM LeaveApplications
                                     WHERE EmployeeId=@EmployeeId
                                     AND Status='Approved') AS ApprovedCount
                                    ";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@EmployeeId", employeeId);

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                    }
                }
                return dt;
            }
                   
            catch(Exception ex)
            {
                throw new Exception("Error in fetching total count of leave balance:" + ex.Message);
            }
      
        }

        public DataTable GetLeaveTypeChart(int employeeId)
        {
            try
            {
                DataTable dt = new DataTable();
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"
                                    SELECT 
                                    lt.LeaveTypeName,
                                    lb.AllocatedDays,
                                    lb.UsedDays,
                                    lb.RemainingDays
                                    FROM LeaveBalance lb
                                    INNER JOIN LeaveTypes lt
                                        ON lb.LeaveTypeId=lt.LeaveTypeId
                                    WHERE lb.EmployeeId=@EmployeeId
                                    AND lb.IsActive=1
                                    AND lt.IsActive=1";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@EmployeeId", employeeId);

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                    }
                }
                return dt;
            }
            catch(Exception ex)
            {
                throw new Exception("Error in fetching chart data from database" + ex.Message);
            }
        }
    }
}
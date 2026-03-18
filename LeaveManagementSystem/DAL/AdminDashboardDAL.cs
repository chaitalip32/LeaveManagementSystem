using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using LeaveManagementSystem;

namespace LeaveManagementSystem.DAL
{
    public class AdminDashboardDAL
    {
        String cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        public DataTable GetDashboardCounts()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT
        (SELECT COUNT(*) FROM Departments WHERE IsActive = 1) AS TotalDepartments,
        (SELECT COUNT(*) FROM Employees) AS TotalEmployees,
        (SELECT COUNT(*) FROM Employees WHERE IsActive = 1) AS ActiveEmployees,
        (SELECT COUNT(*) FROM LeaveTypes WHERE IsActive = 1) AS TotalLeaveTypes,
        (SELECT COUNT(*) FROM LeaveApplications) AS TotalRequests,
        (SELECT COUNT(*) FROM LeaveApplications WHERE Status LIKE 'Pending%') AS PendingRequests,
        (SELECT COUNT(*) FROM LeaveApplications WHERE Status = 'Approved') AS ApprovedRequests,
        (SELECT COUNT(*) FROM LeaveApplications WHERE Status = 'Rejected') AS RejectedRequests";

                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    return dt;
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error in getting counts from the database.");
            }
        }

    }
}
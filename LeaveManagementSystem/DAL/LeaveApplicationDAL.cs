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

        public DataTable GetEmployeeDetails(int employeeId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @" Select CONCAT(e.FirstName,' ',e.LastName) As Name,
                                    d.DepartmentName
                                    FROM Employees e
                                    LEFT JOIN Departments d
                                    ON e.DepartmentId=d.DepartmentId
                                    Where e.EmployeeId=@EmployeeId";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@EmployeeId", employeeId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    return dt;
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error while fetching name and department of employee" + ex.Message);   
            }
        }

        // Function to get all leave applications data in datatable
        public DataTable GetManagerLeaveRequests(int managerId)
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT 
            LA.LeaveApplicationId,
            CONCAT(E.FirstName,' ',E.LastName) AS EmployeeName,
            D.DepartmentName,
            LT.LeaveTypeName,
            LA.FromDate,
            LA.ToDate,
            LA.TotalDays,
            CASE
                WHEN LA.DayType IS NULL THEN 'Full Day'
                ELSE 'Half Day (' + LA.DayType + ')'
            END AS DayType,
            LA.Reason,
            LA.Status
            FROM LeaveApplications LA
            INNER JOIN Employees E ON LA.EmployeeId = E.EmployeeId
            INNER JOIN Departments D ON E.DepartmentId = D.DepartmentId
            INNER JOIN LeaveTypes LT ON LA.LeaveTypeId = LT.LeaveTypeId
            WHERE LA.ManagerId = @ManagerId
            AND LA.Status = 'Pending_Manager'
            ORDER BY LA.AppliedDate DESC";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@ManagerId", managerId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }
            catch (Exception)
            {
                throw;
            }

            return dt;
        }

        public void UpdateManagerLeaveStatus(int leaveId,string status, string comment, int managerId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"Update LeaveApplications 
                                        SET Status=@Status,
                                        ManagerRemarks= @Remarks,
                                        ManagerActiondate=GETDATE(),
                                        LastUpdatedDate=GETDATE()
                                    WHERE LeaveApplicationId=@LeaveId
                                    AND ManagerId=@ManagerID";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@Status",status);
                    cmd.Parameters.AddWithValue("@Remarks", comment);
                    cmd.Parameters.AddWithValue("@LeaveId", leaveId);
                    cmd.Parameters.AddWithValue("@ManagerId", managerId);

                    con.Open();
                    cmd.ExecuteNonQuery();                                 
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error updating leave request "+ex.Message);
            }
        }

        public DataTable GetEmployeeLeaveHistory(int employeeId)
        {
            try
            {
                DataTable dt = new DataTable();

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"Select 
                                    LT.LeaveTypeName,
                                    LA.FromDate,
                                    LA.ToDate,
                                    LA.TotalDays,
                                    LA.Status,
                                    LA.ManagerRemarks,
                                    LA.HRRemarks
                                    FROM LeaveApplications LA
                                    Inner Join LeaveTypes LT
                                    ON LA.LeaveTypeId=LT.LeaveTypeId
                                    WHERE LA.EmployeeId=@EmployeeId
                                    ORDER BY LA.AppliedDate DESC";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@EmployeeId", employeeId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
                return dt;
            }

            catch(Exception ex)
            {
                throw new Exception("Error in loading leave records " + ex.Message);
            }
        }

        public DataTable GetEmployeeLeaveBalance(int employeeId)
        {
            try
            {
                DataTable dt = new DataTable();

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT     
                                    LT.LeaveTypeName,
                                    LB.AllocatedDays,
                                    LB.UsedDays,
                                    LB.RemainingDays
                                    FROM LeaveBalance LB
                                    INNER JOIN LeaveTypes LT
                                        ON LB.LeaveTypeId=LT.LeaveTypeId
                                    WHERE LB.EmployeeId=@EmployeeId
                                    ORDER BY LT.LeaveTypeName";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@EmployeeId", employeeId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
                return dt;
            }
            catch(Exception ex)
            {
                throw new Exception("Error in fetching leave balance " + ex.Message);
            }
        }
    }
}
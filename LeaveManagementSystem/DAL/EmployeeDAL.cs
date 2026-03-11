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
    public class EmployeeDAL
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        public int AddEmployee(EmployeeModel emp)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlTransaction tran = con.BeginTransaction();

                try
                {
                    // Insert in Users table
                    string queryUser = @"INSERT INTO Users
                                    (Username,Email,RoleId,PasswordSetupToken,TokenExpiry)
                                    OUTPUT INSERTED.UserId
                                    VALUES
                                    (@Username,@Email,@RoleId,@Token,@Expiry)";

                    SqlCommand cmdUser = new SqlCommand(queryUser, con, tran);

                    cmdUser.Parameters.AddWithValue("@Username", emp.Email);
                    cmdUser.Parameters.AddWithValue("@Email", emp.Email);
                    cmdUser.Parameters.AddWithValue("@RoleId", emp.RoleId);
                    cmdUser.Parameters.AddWithValue("@Token", emp.PasswordToken);
                    cmdUser.Parameters.AddWithValue("@Expiry", emp.TokenExpiry);

                    int userId = Convert.ToInt32(cmdUser.ExecuteScalar());

                    //Insert in Employees table
                    string queryEmp = @"INSERT INTO Employees
                                        (UserId,DepartmentId,ManagerId,EmployeeCode,
                                        FirstName,LastName,Gender,
                                        DateOfBirth,DateOfJoining,
                                        PhoneNumber,Address,State,City,ProfileImagePath)
                                        VALUES
                                        (@UserId,@DepartmentId,@ManagerId,@EmployeeCode,
                                        @FirstName,@LastName,@Gender,
                                        @DOB,@DOJ,@PhoneNumber,@Address,@State,@City,@Image)";

                    SqlCommand cmdEmp = new SqlCommand(queryEmp,con,tran);

                    cmdEmp.Parameters.AddWithValue("@UserId", userId);
                    cmdEmp.Parameters.AddWithValue("@DepartmentId", emp.DepartmentId);
                    cmdEmp.Parameters.AddWithValue("@ManagerId",emp.ManagerId ?? (object)DBNull.Value);

                    cmdEmp.Parameters.AddWithValue("@EmployeeCode",emp.EmployeeCode);
                    cmdEmp.Parameters.AddWithValue("@FirstName",emp.FirstName);
                    cmdEmp.Parameters.AddWithValue("@LastName",emp.LastName);
                    cmdEmp.Parameters.AddWithValue("@Gender",emp.Gender);

                    cmdEmp.Parameters.AddWithValue("@DOB",emp.DateOfBirth);
                    cmdEmp.Parameters.AddWithValue("@DOJ",emp.DateOfJoining);

                    cmdEmp.Parameters.AddWithValue("@PhoneNumber",emp.PhoneNumber);
                    cmdEmp.Parameters.AddWithValue("@Address",emp.Address);

                    cmdEmp.Parameters.AddWithValue("@State",emp.State);
                    cmdEmp.Parameters.AddWithValue("@City",emp.City);
                    cmdEmp.Parameters.AddWithValue("@Image",emp.ProfileImagePath);

                    cmdEmp.ExecuteNonQuery();

                    tran.Commit();

                    return userId;
                }
                catch(SqlException ex)
                {
                    tran.Rollback();

                    if (ex.Number == 2627)
                        throw new Exception("Employee already exists.");

                    throw new Exception("Database error while adding employee."+ex.Message);
                }
            }
        }

        // Manager and HR List in CC Email field for leave application
        public DataTable GetManagersAndHR()
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT E.EmployeeId, 
                                    CONCAT(E.FirstName, ' ',E.LastName) AS Name,
                                    U.Email
                                    FROM Employees E
                                    INNER JOIN USERS U ON E.UserId=U.UserId
                                    WHERE U.RoleId IN (2,3)
                                    AND E.IsActive=1";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                    }
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error fetching Managers and HR", ex);
            }

            return dt;
        }

        public DataTable GetLeaveTypes()
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT LeaveTypeName,
                                    LeaveTypeId FROM LeaveTypes Where IsActive=1
                                    Order by LeaveTypeName";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                    }
                }
            }
            catch(Exception ex)
            {
                throw new Exception("BLL Error fetching leave types: ", ex);
            }

            return dt;
        }
    }
}
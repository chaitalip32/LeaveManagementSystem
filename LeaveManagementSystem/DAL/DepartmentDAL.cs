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
    public class DepartmentDAL
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        // Get All departments
        public DataTable GetAllDepartments()
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query= "SELECT * FROM Departments WHERE IsActive=1 ORDER BY CreatedDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error fetching Departments: " + ex.Message);
            }

            return dt;
        }

        public void InsertDepartment(Department dept)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO Departments
                                    (DepartmentName, Description, IsActive, CreatedBy)
                                    VALUES (@Name, @Desc, @IsActive, @CreatedBy)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name",dept.DepartmentName);
                        cmd.Parameters.AddWithValue("@Desc",(Object)dept.Description ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@IsActive",dept.IsActive);
                        cmd.Parameters.AddWithValue("@CreatedBy",dept.CreatedBy);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch(SqlException ex)
            {
                if (ex.Number == 2627) //Unique constraint error
                    throw new Exception("Department name already exists.");
                else
                    throw new Exception("Database error while adding departments.");
            }
            catch(Exception)
            {
                throw;
            }
        }

        public void UpdateDepartment(Department dept)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE Departments
                                    SET DepartmentName=@Name,
                                        Description=@Desc,
                                        IsActive=@IsActive,
                                        Updateddate=GETDATE(),
                                        UpdatedBy=@UpdatedBy
                                    WHERE DepartmentId=@Id";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", dept.DepartmentId);
                        cmd.Parameters.AddWithValue("@Name", dept.DepartmentName);
                        cmd.Parameters.AddWithValue("@Desc", (Object)dept.Description ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@IsActive",dept.IsActive);
                        cmd.Parameters.AddWithValue("@UpdatedBy",(Object)dept.UpdatedBy ?? DBNull.Value);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error updating department: " + ex.Message);
            }
        }

        // Delete department code
        public void DeleteDepartment(int departmentId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Departments SET IsActive=0 WHERE DepartmentId=@Id";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", departmentId);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error deleting department: " + ex.Message);
            }
        }

        public int getDepartmentCount()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT count(*) from Departments WHERE IsActive=1";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        con.Open();
                        return (int)cmd.ExecuteScalar();
                    }
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error getting department count: " + ex.Message);
            }
        }

        public DataTable GetDepartmentById(int departmentId)
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT * FROM Departments WHERE DepartmentId = @Id";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", departmentId);

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error fetching department by ID: " + ex.Message);
            }

            return dt;
        }
    }
}
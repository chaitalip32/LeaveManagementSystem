using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace LeaveManagementSystem.DAL
{
    public class LookupDAL
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        public DataTable GetRoles()
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT RoleId, RoleName
                                  FROM Roles 
                                  WHERE IsActive=1
                                  ORDER BY RoleName";

                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    da.Fill(dt);
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error fetching Roles: "+ ex.Message);
            }
            return dt;
        }

        public DataTable GetDepartments()
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT DepartmentId, DepartmentName
                              FROM Departments
                              WHERE IsActive=1
                              ORDER BY DepartmentName";

                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    da.Fill(dt);
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error fetching Departments: " + ex.Message);
            }
            return dt;
        }

        public DataTable GetManagers()
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT 
                                        E.EmployeeId,
                                        CONCAT(E.FirstName,' ',E.LastName) AS ManagerName
                                   FROM Employees E
                                   INNER JOIN Users U
                                        ON E.UserId = U.UserId
                                   WHERE 
                                        U.RoleId =3
                                        AND E.IsActive=1
                                   ORDER BY ManagerName";

                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    da.Fill(dt);
                }
            }
            catch(Exception ex)
            {
                throw new Exception("Error fetching Managers: " + ex.Message);
            }

            return dt;
        }
    }
}
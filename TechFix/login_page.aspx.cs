using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TechFix
{
    public partial class login_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Visible = false; // Hide error label on page load
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblError.Visible = true;
                lblError.Text = "Please enter both username and password.";
                return;
            }

            // Retrieve the connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();
                    // Update the query to select UserID, Role, and SupplierID
                    string query = "SELECT UserID, Role, SupplierID FROM Users WHERE Username = @Username AND Password = @Password";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        int userId = Convert.ToInt32(reader["UserID"]);
                        string role = reader["Role"].ToString();
                        int supplierId = reader["SupplierID"] != DBNull.Value ? Convert.ToInt32(reader["SupplierID"]) : 0;

                        // Store UserID, Role, and SupplierID in session
                        Session["UserID"] = userId;
                        Session["UserRole"] = role;
                        Session["SupplierID"] = supplierId; // Store SupplierID in session

                        // Redirect based on role
                        if (role == "Supplier1")
                        {
                            Response.Redirect("Supplier1Dashboard.aspx");
                        }
                        else if (role == "Supplier2")
                        {
                            Response.Redirect("Supplier2Dashboard.aspx");
                        }
                        else if (role == "TechFix")
                        {
                            Response.Redirect("TechFixDashboard.aspx");
                        }
                    }
                    else
                    {
                        lblError.Visible = true;
                        lblError.Text = "Invalid username or password.";
                    }
                }
                catch (Exception ex)
                {
                    lblError.Visible = true;
                    lblError.Text = "Error: " + ex.Message;
                }
            }
        }
    }
}

using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace TechFix
{
    public partial class ViewSuppliers : System.Web.UI.Page
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSuppliers();
            }
        }

        private void LoadSuppliers()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT UserID, ProfileName, Email, Bio FROM SupplierProfiles";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            rptSuppliers.DataSource = reader;
                            rptSuppliers.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception
                Response.Write($"<script>alert('Error loading suppliers: {ex.Message}')</script>");
            }
        }
    }
}

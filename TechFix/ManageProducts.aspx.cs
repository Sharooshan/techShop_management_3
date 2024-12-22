using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace TechFix
{
    public partial class ManageProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProductGrid();
            }
        }

        private void BindProductGrid()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;
            string query = "SELECT ProductID, ProductName, Category, Brand, RAM, ROM, Price, StockStatus, Description FROM Products";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    conn.Open();
                    da.Fill(dt);
                    gvProducts.DataSource = dt;
                    gvProducts.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                lblError.Text = "An error occurred while loading products: " + ex.Message;
                lblError.Visible = true;
            }
        }
    }
}

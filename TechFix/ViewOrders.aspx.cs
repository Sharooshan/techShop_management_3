using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace TechFix
{
    public partial class ViewOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrders();
            }
        }

        private void BindOrders()
        {
            // Get connection string from Web.config
            string connString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"]?.ConnectionString;

            if (string.IsNullOrEmpty(connString))
            {
                lblMessage.Text = "Database connection string is not configured.";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT OrderID, ProductID, Quantity, TotalPrice, OrderDate, Status
                                 FROM Orders
                                 ORDER BY OrderDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        GridViewOrders.DataSource = dt;
                        GridViewOrders.DataBind();
                    }
                    else
                    {
                        lblMessage.Text = "No orders found.";
                    }
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("TechFixDashboard.aspx");
        }
    }
}

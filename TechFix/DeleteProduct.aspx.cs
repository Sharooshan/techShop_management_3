using System;
using System.Data.SqlClient;
using System.Configuration;

namespace TechFix
{
    public partial class DeleteProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string productId = Request.QueryString["ProductID"];
                if (string.IsNullOrEmpty(productId))
                {
                    lblMessage.Text = "No product ID specified.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    lblMessage.Text = $"Are you sure you want to delete the product with ID: {productId}?";
                    ViewState["ProductID"] = productId;
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string productId = ViewState["ProductID"] as string;
            if (!string.IsNullOrEmpty(productId))
            {
                string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;
                string query = "DELETE FROM Products WHERE ProductID = @ProductID";

                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@ProductID", productId);

                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "Product deleted successfully.";
                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            btnDelete.Enabled = false;
                        }
                        else
                        {
                            lblMessage.Text = "Failed to delete product.";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = $"Error: {ex.Message}";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewProduct.aspx"); // Redirect back to the product list page
        }
    }
}

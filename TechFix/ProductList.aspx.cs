using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace TechFix
{
    public partial class ProductList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
            }
        }

        private void LoadProducts()
        {
            int userId;
            if (Session["UserID"] == null || !int.TryParse(Session["UserID"].ToString(), out userId))
            {
                Response.Write("<script>alert('User not logged in.'); window.location.href='Login.aspx';</script>");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;
            string query = "SELECT ProductID, ProductName, Category, Brand, RAM, ROM, Price, StockStatus, Description, ImagePath FROM Products WHERE UserID = @UserID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvProducts.DataSource = dt;
                gvProducts.DataBind();
            }
        }

        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteProduct")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                DeleteProduct(productId);
                LoadProducts();
            }
        }

        private void DeleteProduct(int productId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;
            string query = "DELETE FROM Products WHERE ProductID = @ProductID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProductID", productId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}

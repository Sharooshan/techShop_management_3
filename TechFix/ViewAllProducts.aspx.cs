using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace TechFix
{
    public partial class ViewAllProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadProducts();
            }
        }

        // Load all products
        private void LoadProducts(string productName = "", string brand = "", string category = "")
        {
            string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT 
                        p.ProductID, 
                        p.ProductName, 
                        p.Category, 
                        p.Brand, 
                        p.RAM, 
                        p.ROM, 
                        p.Description, 
                        p.ImagePath, 
                        p.StockStatus, 
                        p.UserID, 
                        p.Price,
                        MIN(p.Price) OVER (PARTITION BY p.ProductName, p.Category, p.RAM, p.ROM) AS MinPrice
                    FROM Products p
                    WHERE (p.ProductName LIKE '%' + @ProductName + '%' OR @ProductName = '') 
                    AND (p.Brand LIKE '%' + @Brand + '%' OR @Brand = '') 
                    AND (p.Category = @Category OR @Category = '')";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ProductName", productName);
                    cmd.Parameters.AddWithValue("@Brand", brand);
                    cmd.Parameters.AddWithValue("@Category", category);

                    conn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptProducts.DataSource = dt;
                        rptProducts.DataBind();
                    }
                }
            }
        }

        // Load categories into the dropdown list
        private void LoadCategories()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT DISTINCT Category FROM Products";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    categoryFilter.Items.Clear();
                    categoryFilter.Items.Add(new System.Web.UI.WebControls.ListItem("All", ""));
                    while (reader.Read())
                    {
                        categoryFilter.Items.Add(new System.Web.UI.WebControls.ListItem(reader["Category"].ToString()));
                    }
                }
            }
        }

        // Handle category selection change event
        protected void categoryFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCategory = categoryFilter.SelectedValue;
            string productName = txtProductName.Text.Trim();
            string brand = txtBrand.Text.Trim();
            LoadProducts(productName, brand, selectedCategory);
        }

        // Filter products based on name, brand, and category
        protected void txtProductName_TextChanged(object sender, EventArgs e)
        {
            string productName = txtProductName.Text.Trim();
            string brand = txtBrand.Text.Trim();
            string selectedCategory = categoryFilter.SelectedValue;
            LoadProducts(productName, brand, selectedCategory);
        }

        protected void txtBrand_TextChanged(object sender, EventArgs e)
        {
            string productName = txtProductName.Text.Trim();
            string brand = txtBrand.Text.Trim();
            string selectedCategory = categoryFilter.SelectedValue;
            LoadProducts(productName, brand, selectedCategory);
        }

        // Method to get the CSS class for stock status
        protected string GetStockStatusCssClass(string stockStatus)
        {
            switch (stockStatus.ToLower())
            {
                case "out of stock":
                    return "stock-status-out-of-stock";
                case "in stock":
                    return "stock-status-in-stock";
                case "low level":
                    return "stock-status-low-level";
                default:
                    return "";
            }
        }

        // Method to get price suggestion
        protected string GetPriceSuggestion(decimal price, decimal minPrice)
        {
            if (price == minPrice)
            {
                return "This is the best price available.";
            }
            return "";
        }
    }
}
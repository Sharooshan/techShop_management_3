using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TechFix
{
    public partial class OrderProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load product details here
                LoadProductDetails();
            }
        }

        private void LoadProductDetails()
        {
            try
            {
                // Get product ID from query string
                int productId;
                if (!int.TryParse(Request.QueryString["ProductID"], out productId))
                {
                    lblError.Text = "Invalid product ID.";
                    lblError.Visible = true;
                    return;
                }

                string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string query = "SELECT * FROM Products WHERE ProductID = @ProductID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ProductID", productId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblProductName.Text = reader["ProductName"].ToString();
                                lblCategory.Text = reader["Category"].ToString();
                                lblBrand.Text = reader["Brand"].ToString();
                                lblPrice.Text = reader["Price"].ToString();
                                lblStockStatus.Text = reader["StockStatus"].ToString();
                                imgProduct.ImageUrl = reader["ImagePath"].ToString();

                                // Store the price and SupplierID for later use
                                ViewState["ProductPrice"] = reader["Price"];
                                ViewState["SupplierID"] = reader["SupplierID"]; // Store the SupplierID
                            }
                            else
                            {
                                lblError.Text = "Product not found.";
                                lblError.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception (consider using a logging framework)
                lblError.Text = "An error occurred while loading product details.";
                lblError.Visible = true;
                // Optionally log the exception message
            }
        }

        protected void btnConfirmOrder_Click(object sender, EventArgs e)
        {
            try
            {
                int productId;
                if (!int.TryParse(Request.QueryString["ProductID"], out productId))
                {
                    lblError.Text = "Invalid product ID.";
                    lblError.Visible = true;
                    return;
                }

                int quantity;
                if (!int.TryParse(txtQuantity.Text, out quantity) || quantity <= 0)
                {
                    lblError.Text = "Please enter a valid quantity.";
                    lblError.Visible = true;
                    return;
                }

                decimal price;
                if (ViewState["ProductPrice"] == null || !decimal.TryParse(ViewState["ProductPrice"].ToString(), out price))
                {
                    lblError.Text = "Price not available.";
                    lblError.Visible = true;
                    return;
                }

                decimal totalPrice = price * quantity;

                string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // Check if enough stock is available
                    string stockQuery = "SELECT StockCount FROM Products WHERE ProductID = @ProductID";
                    int stockCount;
                    using (SqlCommand cmd = new SqlCommand(stockQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@ProductID", productId);
                        stockCount = (int)cmd.ExecuteScalar();

                        if (quantity > stockCount)
                        {
                            lblError.Text = "Insufficient stock.";
                            lblError.Visible = true;
                            return;
                        }
                    }

                    // Update the stock count
                    string updateQuery = "UPDATE Products SET StockCount = StockCount - @Quantity WHERE ProductID = @ProductID";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@Quantity", quantity);
                        cmd.Parameters.AddWithValue("@ProductID", productId);
                        cmd.ExecuteNonQuery();
                    }

                    // Update the stock status
                    string statusQuery = @"
                        DECLARE @NewStockCount INT;
                        SET @NewStockCount = (SELECT StockCount FROM Products WHERE ProductID = @ProductID);

                        UPDATE Products
                        SET StockStatus = CASE 
                            WHEN @NewStockCount <= 0 THEN 'Out of Stock'
                            WHEN @NewStockCount <= 20 THEN 'Low Stock'
                            ELSE 'In Stock'
                        END
                        WHERE ProductID = @ProductID";

                    using (SqlCommand cmd = new SqlCommand(statusQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@ProductID", productId);
                        cmd.ExecuteNonQuery();
                    }

                    // Get SupplierID from ViewState (loaded earlier from Products table)
                    int supplierID = (int)ViewState["SupplierID"];

                    // Insert order details into the Orders table, including SupplierID
                    string insertQuery = "INSERT INTO Orders (ProductID, UserID, OrderDate, Quantity, TotalPrice, SupplierID) VALUES (@ProductID, @UserID, @OrderDate, @Quantity, @TotalPrice, @SupplierID)";
                    using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                    {
                        // Example user ID, this should be dynamically determined based on the logged-in user
                        int userID = 1;

                        cmd.Parameters.AddWithValue("@ProductID", productId);
                        cmd.Parameters.AddWithValue("@UserID", userID);
                        cmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);
                        cmd.Parameters.AddWithValue("@Quantity", quantity);
                        cmd.Parameters.AddWithValue("@TotalPrice", totalPrice);
                        cmd.Parameters.AddWithValue("@SupplierID", supplierID); // Include SupplierID in the order

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // If order is saved successfully, redirect to confirmation page
                            Response.Redirect("~/OrderConfirmation.aspx?ProductID=" + productId + "&Quantity=" + quantity);
                        }
                        else
                        {
                            // Handle the error
                            lblError.Text = "Oops! Something went wrong while placing your order. Please try again.";
                            lblError.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception (consider using a logging framework)
                lblError.Text = "An error occurred while processing your order.";
                lblError.Visible = true;
                // Optionally log the exception message
            }
        }
    }
}

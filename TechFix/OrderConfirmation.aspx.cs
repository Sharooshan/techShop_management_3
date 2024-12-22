using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TechFix
{
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Fetch the order details and display a confirmation message
                DisplayConfirmation();
            }
        }

        private void DisplayConfirmation()
        {
            int productID;
            int quantity;
            decimal price = 0.00m;
            decimal totalPrice = 0.00m;

            // Retrieve ProductID from query string
            string productIDStr = Request.QueryString["ProductID"];
            if (string.IsNullOrEmpty(productIDStr) || !int.TryParse(productIDStr, out productID))
            {
                lblConfirmationMessage.Text = "Product ID parameter is missing or invalid. Please ensure that the Product ID is provided.";
                return;
            }

            // Retrieve quantity from query string
            string quantityStr = Request.QueryString["Quantity"];
            if (string.IsNullOrEmpty(quantityStr) || !int.TryParse(quantityStr, out quantity) || quantity <= 0)
            {
                lblConfirmationMessage.Text = "Invalid quantity. Please enter a valid number greater than zero.";
                return;
            }

            // Retrieve the price from the database
            string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    string priceQuery = "SELECT Price FROM Products WHERE ProductID = @ProductID";
                    using (SqlCommand cmd = new SqlCommand(priceQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@ProductID", productID);
                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            price = (decimal)result;
                        }
                        else
                        {
                            lblConfirmationMessage.Text = "Product not found.";
                            return;
                        }
                    }
                }

                // Calculate the total price
                totalPrice = price * quantity;

                // Display debugging information
                System.Diagnostics.Debug.WriteLine($"ProductID: {productID}");
                System.Diagnostics.Debug.WriteLine($"Quantity: {quantity}");
                System.Diagnostics.Debug.WriteLine($"Price: {price}");
                System.Diagnostics.Debug.WriteLine($"Total Price: {totalPrice}");

                // Display the confirmation message
                lblConfirmationMessage.Text = $"Thank you! Your order has been placed successfully. Your total bill is {totalPrice:C}.";
            }
            catch (Exception ex)
            {
                // Log the exception (consider using a logging framework)
                lblConfirmationMessage.Text = "An error occurred while processing your order.";
                // Optionally log the exception message
                // System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }
    }
}

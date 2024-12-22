using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace TechFix
{
    public partial class Supplier1ViewOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve the supplier ID from session
                int supplierId = Convert.ToInt32(Session["SupplierID"]);

                if (supplierId > 0)
                {
                    // If supplier ID is valid, bind the orders
                    BindOrders(supplierId);
                }
                else
                {
                    // If supplier ID is not found, show a message
                    lblMessage.Text = "You are not logged in. Please log in to view your orders.";
                }
            }
        }

        private void BindOrders(int supplierId)
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
                // SQL query to get the orders based on supplier ID
                string query = @"SELECT OrderID, ProductID, OrderDate, Quantity, TotalPrice, Status
                                 FROM Orders
                                 WHERE SupplierID = @SupplierId
                                 ORDER BY OrderDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add supplier ID as a parameter to the query
                    cmd.Parameters.AddWithValue("@SupplierId", supplierId);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        // Bind the orders to the GridView control
                        GridViewOrders.DataSource = dt;
                        GridViewOrders.DataBind();
                    }
                    else
                    {
                        // Show message if no orders are found
                        lblMessage.Text = "No orders found for this supplier.";
                    }
                }
            }
        }

        protected void GridViewOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                // Get the OrderID from CommandArgument
                int orderId = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = (GridViewRow)((Button)e.CommandSource).NamingContainer;
                DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");

                // Get the selected status from the dropdown
                string selectedStatus = ddlStatus.SelectedValue;

                // Update the order status in the database
                UpdateOrderStatus(orderId, selectedStatus);
            }
        }

        private void UpdateOrderStatus(int orderId, string status)
        {
            // Get connection string from Web.config
            string connString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"]?.ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"UPDATE Orders SET Status = @Status WHERE OrderID = @OrderID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@OrderID", orderId);

                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Order status updated successfully.";
                    }
                    else
                    {
                        lblMessage.Text = "Failed to update order status.";
                    }
                }
            }

            // Rebind the orders to reflect changes
            int supplierId = Convert.ToInt32(Session["SupplierID"]);
            BindOrders(supplierId);
        }
    }
}

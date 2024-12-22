using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;

namespace TechFix
{
    public partial class AddProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is authenticated
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/login_page.aspx"); // Redirect to login if not authenticated
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            // Get input values from form
            string productName = txtProductName.Text;
            string category = ddlCategory.SelectedValue;
            string brand = ddlBrand.SelectedValue;
            string ram = ddlRAM.SelectedValue;
            string rom = ddlROM.SelectedValue;
            string stockStatus = ddlStockStatus.SelectedValue;
            string description = txtDescription.Text;

            // Validate and parse the price
            decimal price;
            if (!decimal.TryParse(txtPrice.Text, out price))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please enter a valid price');", true);
                return;
            }

            // Validate and parse the stock count
            int stockCount;
            if (!int.TryParse(txtAvailableStock.Text, out stockCount))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please enter a valid stock count');", true);
                return;
            }

            // Validate and retrieve UserID from session
            int userId;
            if (!int.TryParse(Session["UserID"].ToString(), out userId))
            {
                Response.Redirect("~/login_page.aspx"); // Redirect if user ID is invalid
                return;
            }

            // Retrieve SupplierID from session
            int supplierId;
            if (!int.TryParse(Session["SupplierID"]?.ToString(), out supplierId))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Supplier ID is not available.');", true);
                return;
            }

            // Handle file upload for product image
            string imagePath = null;
            if (fileUploadImage.HasFile)
            {
                string fileName = Path.GetFileNameWithoutExtension(fileUploadImage.FileName);
                string fileExtension = Path.GetExtension(fileUploadImage.FileName).ToLower();

                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    string uniqueFileName = fileName + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + fileExtension;
                    string uploadPath = Server.MapPath("~/ProductImages/");

                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }

                    imagePath = "~/ProductImages/" + uniqueFileName;
                    fileUploadImage.SaveAs(Server.MapPath(imagePath));
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please upload a valid image file (.jpg, .jpeg, .png)');", true);
                    return;
                }
            }

            try
            {
                // Insert the product details into the database
                string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    string query = @"INSERT INTO Products 
                                     (UserId, SupplierId, ProductName, Category, Brand, RAM, ROM, Price, StockStatus, StockCount, Description, ImagePath) 
                                     VALUES 
                                     (@UserId, @SupplierId, @ProductName, @Category, @Brand, @RAM, @ROM, @Price, @StockStatus, @StockCount, @Description, @ImagePath)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        // Add parameters to the SQL command
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@SupplierId", supplierId);
                        cmd.Parameters.AddWithValue("@ProductName", productName);
                        cmd.Parameters.AddWithValue("@Category", category);
                        cmd.Parameters.AddWithValue("@Brand", brand);
                        cmd.Parameters.AddWithValue("@RAM", ram);
                        cmd.Parameters.AddWithValue("@ROM", rom);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@StockStatus", stockStatus);
                        cmd.Parameters.AddWithValue("@StockCount", stockCount);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@ImagePath", imagePath ?? (object)DBNull.Value);

                        // Execute the query
                        cmd.ExecuteNonQuery();
                    }
                }

                // Notify user of successful product addition
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product added successfully!');", true);
                // Optionally, redirect to another page after successful addition
                // Response.Redirect("~/Supplier1Products.aspx"); 
            }
            catch (Exception ex)
            {
                // Log the exception (optional) and notify the user of the error
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('An error occurred while adding the product: {ex.Message}');", true);
            }
        }
    }
}

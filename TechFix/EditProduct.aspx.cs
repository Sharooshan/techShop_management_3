using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace TechFix
{
    public partial class EditProduct : System.Web.UI.Page
    {
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;

            string productName = txtProductName.Text;
            string category = ddlCategory.SelectedValue; // Dropdown value for Category
            string brand = ddlBrand.SelectedValue; // Dropdown value for Brand
            string ram = ddlRAM.SelectedValue; // Dropdown value for RAM
            string rom = ddlROM.SelectedValue; // Dropdown value for ROM
            string price = txtPrice.Text;
            string stockStatus = ddlStockStatus.SelectedValue; // Dropdown value for Stock Status
            string description = txtDescription.Text;

            // Handle file upload for product image
            string imagePath = null;
            if (fileUploadImage.HasFile)
            {
                string fileExtension = Path.GetExtension(fileUploadImage.FileName).ToLower();

                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    // Generate a unique file name based on current time to avoid overwriting
                    string fileName = Path.GetFileNameWithoutExtension(fileUploadImage.FileName);
                    string uniqueFileName = fileName + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + fileExtension;
                    string uploadPath = Server.MapPath("~/ProductImages/");

                    // Ensure the directory exists
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }

                    // Set the image path for database and save the file
                    imagePath = "~/ProductImages/" + uniqueFileName;
                    fileUploadImage.SaveAs(Server.MapPath(imagePath));
                }
                else
                {
                    // Show error for invalid file types
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please upload a valid image file (.jpg, .jpeg, .png)');", true);
                    return;
                }
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // If a new image was uploaded, include the ImagePath in the query, otherwise keep the existing image
                string query = imagePath != null
                    ? "UPDATE Products SET ProductName = @ProductName, Category = @Category, Brand = @Brand, RAM = @RAM, ROM = @ROM, Price = @Price, StockStatus = @StockStatus, Description = @Description, ImagePath = @ImagePath WHERE ProductID = @ProductID"
                    : "UPDATE Products SET ProductName = @ProductName, Category = @Category, Brand = @Brand, RAM = @RAM, ROM = @ROM, Price = @Price, StockStatus = @StockStatus, Description = @Description WHERE ProductID = @ProductID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    // Add parameters to the SQL command
                    cmd.Parameters.AddWithValue("@ProductName", productName);
                    cmd.Parameters.AddWithValue("@Category", category);
                    cmd.Parameters.AddWithValue("@Brand", brand);
                    cmd.Parameters.AddWithValue("@RAM", ram);
                    cmd.Parameters.AddWithValue("@ROM", rom);
                    cmd.Parameters.AddWithValue("@Price", price);
                    cmd.Parameters.AddWithValue("@StockStatus", stockStatus);
                    cmd.Parameters.AddWithValue("@Description", description);

                    // Add the image path only if a new image was uploaded
                    if (imagePath != null)
                    {
                        cmd.Parameters.AddWithValue("@ImagePath", imagePath);
                    }

                    cmd.Parameters.AddWithValue("@ProductID", Request.QueryString["ProductID"]);

                    // Execute the query
                    cmd.ExecuteNonQuery();
                }
            }

            // Redirect to a confirmation page or display a success message
            Response.Redirect("~/ProductList.aspx");
        }
    }
}

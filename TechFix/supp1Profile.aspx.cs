using System;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;

namespace TechFix
{
    public partial class supp1Profile : System.Web.UI.Page
    {
        // Fetching connection string from Web.config
        string connectionString = ConfigurationManager.ConnectionStrings["TechFixDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProfileData(); // Load existing data if available
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Capture profile details
                string profileName = txtProfileName.Text;
                string email = txtEmail.Text;
                string bio = txtBio.Text;

                string profilePicPath = null;

                // Check if file is uploaded
                if (fileProfilePic.HasFile)
                {
                    string fileExtension = Path.GetExtension(fileProfilePic.FileName).ToLower();
                    string[] allowedExtensions = { ".jpg", ".png", ".jpeg", ".gif" };
                    if (Array.Exists(allowedExtensions, ext => ext == fileExtension))
                    {
                        // Ensure the directory exists or create it
                        string directoryPath = Server.MapPath("~/ProfilePics/");
                        if (!Directory.Exists(directoryPath))
                        {
                            Directory.CreateDirectory(directoryPath); // Create directory if it doesn't exist
                        }

                        // Save profile picture
                        string fileName = "ProfilePic_" + User.Identity.Name + fileExtension; // Unique file name
                        profilePicPath = "~/ProfilePics/" + fileName;
                        fileProfilePic.SaveAs(Path.Combine(directoryPath, fileName));
                    }
                    else
                    {
                        lblMessage.Text = "Invalid file type. Only images are allowed.";
                        return;
                    }
                }

                // Save data to the database
                SaveProfileData(profileName, email, bio, profilePicPath);
            }
        }

        private void SaveProfileData(string profileName, string email, string bio, string profilePicPath)
        {
            // Assume UserID is retrieved from the session or authentication context
            int userId = Convert.ToInt32(Session["UserID"]);

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Query to insert/update profile data
                    string query = @"IF EXISTS (SELECT 1 FROM SupplierProfiles WHERE UserID = @UserID)
                                     UPDATE SupplierProfiles
                                     SET ProfileName = @ProfileName, Email = @Email, Bio = @Bio, ProfilePicPath = @ProfilePicPath
                                     WHERE UserID = @UserID
                                     ELSE
                                     INSERT INTO SupplierProfiles (UserID, ProfileName, Email, Bio, ProfilePicPath)
                                     VALUES (@UserID, @ProfileName, @Email, @Bio, @ProfilePicPath)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@ProfileName", profileName);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Bio", bio);
                        cmd.Parameters.AddWithValue("@ProfilePicPath", profilePicPath ?? (object)DBNull.Value);

                        cmd.ExecuteNonQuery();
                    }

                    lblMessage.Text = "Profile saved successfully!";
                    LoadProfileData(); // Reload the profile data to reflect changes
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error saving profile: " + ex.Message;
            }
        }

        private void LoadProfileData()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT ProfileName, Email, Bio, ProfilePicPath FROM SupplierProfiles WHERE UserID = @UserID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtProfileName.Text = reader["ProfileName"].ToString();
                                txtEmail.Text = reader["Email"].ToString();
                                txtBio.Text = reader["Bio"].ToString();

                                // Load profile picture if available
                                string profilePicPath = reader["ProfilePicPath"].ToString();
                                if (!string.IsNullOrEmpty(profilePicPath))
                                {
                                    imgProfilePic.ImageUrl = profilePicPath; // Set image source
                                }
                                else
                                {
                                    imgProfilePic.ImageUrl = "~/Images/default-profile.png"; // Default image if none found
                                }
                            }
                            else
                            {
                                lblMessage.Text = "Profile not found.";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading profile: " + ex.Message;
            }
        }
    }
}

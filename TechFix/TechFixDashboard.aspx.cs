using System;

namespace TechFix
{
    public partial class TechFixDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // You can add any initialization code here if needed
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // End the user session and redirect to the login page
            Session.Clear();
            Session.Abandon();
            Response.Redirect("login_page.aspx");
        }
    }
}

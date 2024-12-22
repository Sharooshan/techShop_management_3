<%@ Page Language="C#" AutoEventWireup="true" CodeFile="supp1Profile.aspx.cs" Inherits="TechFix.supp1Profile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Supplier Profile</title>
    <style>

        
        /* Navbar styles */
        .navbar {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .navbar a {
            color: #ecf0f1;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            margin: 0 10px;
            transition: background-color 0.3s ease;
        }

        .navbar a:hover {
            background-color: #2980b9; /* Hover color */
        }

      /* General styles */
body {
    font-family: 'Roboto', sans-serif; /* Use Roboto font */
    background-color: #1b2631; /* Midnight Blue */
    color: #ecf0f1; /* Light text color */
    margin: 0;
    padding: 0;
    height: 100vh; /* Full viewport height */
    display: flex;
    justify-content: center; /* Center content horizontally */
    align-items: center; /* Center content vertically */
}

.container {
    max-width: 800px;
    background-color: #1c1f24; /* Dark background for container */
    border-radius: 10px; /* Rounded corners */
    padding: 40px; /* Padding inside container */
    box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.5); /* Shadow effect */
    text-align: center; /* Center text */
    transition: transform 0.5s ease-in-out, box-shadow 0.5s ease-in-out; /* Smooth transition */
}

.container:hover {
    transform: scale(1.05); /* Slightly enlarge on hover */
    box-shadow: 0px 15px 45px rgba(0, 0, 0, 0.75); /* Darker shadow on hover */
}

/* Heading styles */
h1 {
    color: #3498db; /* Royal Blue */
    font-size: 2.5em; /* Heading size */
    margin-bottom: 20px; /* Space below heading */
    position: relative; /* Positioning for animation */
    animation: glow 2s infinite alternate; /* Glow animation */
}

@keyframes glow {
    from {
        text-shadow: 0 0 10px #2980b9, 0 0 20px #2980b9, 0 0 30px #3498db, 0 0 40px #3498db;
    }
    to {
        text-shadow: 0 0 20px #2980b9, 0 0 30px #3498db, 0 0 40px #3498db, 0 0 50px #3498db;
    }
}

/* Input styles */
input[type="text"], 
input[type="email"], 
input[type="file"], 
textarea {
    width: 100%; /* Full width */
    padding: 10px; /* Padding inside inputs */
    margin: 10px 0 20px 0; /* Margin around inputs */
    border-radius: 5px; /* Rounded corners */
    border: 1px solid #ccc; /* Border style */
    background-color: #2c3e50; /* Dark input background */
    color: #ecf0f1; /* Light text color */
}

/* Submit button styles */
.submit-btn {
    padding: 10px 20px; /* Button padding */
    background-color: #3498db; /* Royal Blue */
    color: white; /* Button text color */
    border: none; /* No border */
    border-radius: 5px; /* Rounded corners */
    cursor: pointer; /* Pointer on hover */
    font-size: 16px; /* Button font size */
    transition: background-color 0.3s ease, transform 0.3s ease; /* Smooth transition */
    box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3); /* Shadow effect */
}

.submit-btn:hover {
    background-color: #2980b9; /* Darker blue on hover */
    transform: translateY(-3px); /* Lift effect on hover */
}

/* Responsive design */
@media (max-width: 768px) {
    .container {
        padding: 20px; /* Reduce padding on smaller screens */
    }
    
    .submit-btn {
        width: 100%; /* Full width on small screens */
    }
}

    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="container">
            

         
             <div class="navbar">
    <a href="Supplier1Dashboard.aspx">Home</a>
                 <a href="Supplier1AddProduct.aspx">Add Product</a>
    <a href="ViewProduct.aspx">View Products</a>
    <a href="supp1Profile.aspx">My Profile</a>
    <a href="Supplier1ViewOrders.aspx">View Orders</a>
</div>
            <h1>Supplier Profile</h1>
            <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
            
            <asp:Image ID="imgProfilePic" runat="server" CssClass="profile-pic" ImageUrl="~/Images/default-profile.png" />
            <asp:FileUpload ID="fileProfilePic" runat="server" />

            <label for="profileName">Profile Name:</label>
            <asp:TextBox ID="txtProfileName" runat="server" placeholder="Enter Profile Name"></asp:TextBox>

            <label for="email">Email:</label>
            <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter Email"></asp:TextBox>

            <label for="bio">Bio/Description:</label>
            <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine" placeholder="Enter bio or description"></asp:TextBox>

            <asp:Button ID="btnSave" runat="server" Text="Save Profile" CssClass="submit-btn" OnClick="btnSave_Click" />
        </div>
    </form>
</body>
</html>

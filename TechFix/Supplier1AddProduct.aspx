<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Supplier1AddProduct.aspx.cs" Inherits="TechFix.AddProduct" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Product - Supplier 1</title>
    <style>
  /* General styles */
body {
    font-family: 'Roboto', sans-serif;
    background-color: #1b2631; /* Midnight Blue */
    color: #ecf0f1;
    margin: 0;
    padding: 0;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}.container {
    max-width: 1000px; /* Significantly increased width */
    width: 100%; /* Ensure it takes up all available space */
    background-color: #2c3e50; /* Slightly lighter background */
    border-radius: 15px; /* Softer edges */
    padding: 50px;
    box-shadow: 0px 10px 25px rgba(0, 0, 0, 0.4);
    text-align: center;
    transition: transform 0.4s ease-in-out, box-shadow 0.4s ease-in-out;
    position: relative;
}



.container:hover {
    transform: scale(1.03);
    box-shadow: 0px 20px 45px rgba(0, 0, 0, 0.75);
}

/* Heading styles */
h1 {
    color: #3498db; /* Royal Blue */
    font-size: 2.2em;
    margin-bottom: 30px;
    position: relative;
    letter-spacing: 1px;
    animation: glow 2s infinite alternate;
}

/* Adding a subtle glow effect to headings */
@keyframes glow {
    from {
        text-shadow: 0 0 8px #2980b9, 0 0 12px #3498db, 0 0 15px #3498db;
    }
    to {
        text-shadow: 0 0 20px #3498db, 0 0 30px #3498db, 0 0 40px #3498db;
    }
}

/* Form styles */
.form-group {
    margin-bottom: 20px;
    text-align: left;
}

label {
    font-weight: bold;
    font-size: 1em;
    display: block;
    margin-bottom: 8px;
}

input[type="text"],
input[type="number"],
textarea,
select {
    width: 100%;
    padding: 12px;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #34495e; /* Dark background for inputs */
    color: #fff;
    font-size: 1em;
    transition: border-color 0.3s ease;
}

input:focus,
textarea:focus,
select:focus {
    border-color: #3498db; /* Focus color for input fields */
    outline: none;
}

/* Submit button styles */
.btn-submit {
    background-color: #e74c3c; /* Burgundy Red */
    color: white;
    padding: 12px 25px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 1em;
    transition: background-color 0.3s, transform 0.3s ease;
    box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
    margin-top: 20px;
    letter-spacing: 1px;
}

.btn-submit:hover {
    background-color: #c0392b;
    transform: translateY(-5px);
}

/* File upload */
.file-upload {
    margin-top: 15px;
}

/* Responsive design */
@media (max-width: 768px) {
    .container {
        padding: 30px;
        width: 100%;
        max-width: 100%;
    }

    h1 {
        font-size: 1.8em;
    }

    .btn-submit {
        width: 100%;
        padding: 15px;
        margin-top: 20px;
    }

    input[type="text"],
    input[type="number"],
    textarea,
    select {
        padding: 10px;
    }
}

/* Additional improvements */
.container::before {
    content: "";
    position: absolute;
    top: -10px;
    left: -10px;
    right: -10px;
    bottom: -10px;
    background: linear-gradient(45deg, rgba(52, 152, 219, 0.3), rgba(231, 76, 60, 0.3));
    z-index: -1;
    filter: blur(10px);
    border-radius: 15px;
}


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

            <h1>Add Product</h1>

            <!-- Product Name -->
            <div class="form-group">
                <label for="txtProductName">Product Name:</label>
                <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            
            <!-- Category Dropdown -->
            <div class="form-group">
                <label for="ddlCategory">Category:</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                    <asp:ListItem Value="PC">PC</asp:ListItem>
                    <asp:ListItem Value="Laptop">Laptop</asp:ListItem>
                    <asp:ListItem Value="Mobile">Mobile</asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Brand Dropdown -->
            <div class="form-group">
                <label for="ddlBrand">Brand:</label>
                <asp:DropDownList ID="ddlBrand" runat="server" CssClass="form-control">
                    <asp:ListItem Value="Asus">Asus</asp:ListItem>
                    <asp:ListItem Value="Dell">Dell</asp:ListItem>
                    <asp:ListItem Value="MSI">MSI</asp:ListItem>
                    <asp:ListItem Value="HP">HP</asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- RAM Dropdown -->
            <div class="form-group">
                <label for="ddlRAM">RAM:</label>
                <asp:DropDownList ID="ddlRAM" runat="server" CssClass="form-control">
                    <asp:ListItem Value="4GB">4GB</asp:ListItem>
                    <asp:ListItem Value="8GB">8GB</asp:ListItem>
                    <asp:ListItem Value="16GB">16GB</asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- ROM Dropdown -->
            <div class="form-group">
                <label for="ddlROM">ROM:</label>
                <asp:DropDownList ID="ddlROM" runat="server" CssClass="form-control">
                    <asp:ListItem Value="256GB">256GB</asp:ListItem>
                    <asp:ListItem Value="512GB">512GB</asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Price -->
            <div class="form-group">
                <label for="txtPrice">Price:</label>
                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
            </div>

            <!-- Stock Status Dropdown -->
            <div class="form-group">
                <label for="ddlStockStatus">Stock Status:</label>
                <asp:DropDownList ID="ddlStockStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Value="In Stock">In Stock</asp:ListItem>
                    <asp:ListItem Value="Low Stock">Low Stock</asp:ListItem>
                    <asp:ListItem Value="Out of Stock">Out of Stock</asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Available Stock Count -->
            <div class="form-group">
                <label for="txtAvailableStock">Available Stock:</label>
                <asp:TextBox ID="txtAvailableStock" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
            </div>

            <!-- Description -->
            <div class="form-group">
                <label for="txtDescription">Description:</label>
                <asp:TextBox ID="txtDescription" TextMode="MultiLine" Rows="4" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            
            <!-- Image Upload -->
            <div class="form-group file-upload">
                <label for="fileUploadImage">Product Image:</label>
                <asp:FileUpload ID="fileUploadImage" runat="server" CssClass="form-control" />
            </div>
            
            <!-- Submit Button -->
            <asp:Button ID="btnAddProduct" runat="server" Text="Add Product" CssClass="btn-submit" OnClick="btnAddProduct_Click" />
        </div>
    </form>
</body>
</html>

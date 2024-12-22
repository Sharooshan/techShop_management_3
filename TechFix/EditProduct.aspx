<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditProduct.aspx.cs" Inherits="TechFix.EditProduct" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Product - Supplier 1</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        header {
            background-color: #2e86c1;
            color: white;
            padding: 10px 0;
            text-align: center;
        }
        header h1 {
            margin: 0;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"], input[type="number"], input[type="file"], select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        button {
            padding: 10px 20px;
            color: white;
            background-color: #3498db;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #2980b9;
        }
        .product-image {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }
        .error-message {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="container">
            <header>
                <h1>Edit Product</h1>
            </header>
            <main>
                <asp:Label ID="lblError" runat="server" CssClass="error-message" Visible="False" />

                <!-- Product Name -->
                <asp:TextBox ID="txtProductName" runat="server" placeholder="Product Name" />

                <!-- Category Dropdown -->
                <asp:DropDownList ID="ddlCategory" runat="server">
                    <asp:ListItem Text="Select Category" Value="" />
                    <asp:ListItem Text="PC" Value="PC" />
                    <asp:ListItem Text="Laptop" Value="Laptop" />
                    <asp:ListItem Text="Mobile" Value="Mobile" />
                </asp:DropDownList>

                <!-- Brand Dropdown -->
                <asp:DropDownList ID="ddlBrand" runat="server">
                    <asp:ListItem Text="Select Brand" Value="" />
                    <asp:ListItem Text="Asus" Value="Asus" />
                    <asp:ListItem Text="Dell" Value="Dell" />
                    <asp:ListItem Text="MSI" Value="MSI" />
                    <asp:ListItem Text="HP" Value="HP" />
                </asp:DropDownList>

                <!-- RAM Dropdown -->
                <asp:DropDownList ID="ddlRAM" runat="server">
                    <asp:ListItem Text="Select RAM" Value="" />
                    <asp:ListItem Text="4GB" Value="4GB" />
                    <asp:ListItem Text="8GB" Value="8GB" />
                    <asp:ListItem Text="16GB" Value="16GB" />
                </asp:DropDownList>

                <!-- ROM Dropdown -->
                <asp:DropDownList ID="ddlROM" runat="server">
                    <asp:ListItem Text="Select ROM" Value="" />
                    <asp:ListItem Text="256GB" Value="256GB" />
                    <asp:ListItem Text="512GB" Value="512GB" />
                </asp:DropDownList>

                <!-- Stock Status Dropdown -->
                <asp:DropDownList ID="ddlStockStatus" runat="server">
                    <asp:ListItem Text="Select Stock Status" Value="" />
                    <asp:ListItem Text="In Stock" Value="In Stock" />
                    <asp:ListItem Text="Low Stock" Value="Low Stock" />
                    <asp:ListItem Text="Out of Stock" Value="Out of Stock" />
                </asp:DropDownList>

                <!-- Price -->
                <asp:TextBox ID="txtPrice" runat="server" placeholder="Price" />

                <!-- Description -->
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" placeholder="Description" />

                <!-- Image upload control -->
                <asp:FileUpload ID="fileUploadImage" runat="server" />

                <!-- Display current image -->
                <asp:Image ID="imgCurrentProductImage" runat="server" CssClass="product-image" />

                <!-- Update Button -->
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
            </main>
        </div>
    </form>
</body>
</html>

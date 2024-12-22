<%@ Page Title="Manage Products" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="ManageProducts.aspx.cs" Inherits="TechFix.ManageProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
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
        .dashboard-btn {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            background-color: #3498db;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            font-size: 18px;
        }
        .dashboard-btn:hover {
            background-color: #2980b9;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .actions {
            display: flex;
            gap: 10px;
        }
        .action-btn {
            padding: 5px 10px;
            text-decoration: none;
            color: #fff;
            border-radius: 3px;
            font-size: 0.9em;
        }
        .action-btn.edit {
            background-color: #007bff;
        }
        .action-btn.edit:hover {
            background-color: #0056b3;
        }
        .action-btn.delete {
            background-color: #dc3545;
        }
        .action-btn.delete:hover {
            background-color: #c82333;
        }
        .error-message {
            color: #dc3545;
            font-weight: bold;
            margin-bottom: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <header>
            <h1>Manage Products</h1>
            <a href="Supplier1Dashboard.aspx" class="dashboard-btn">Back to Dashboard</a>
        </header>
        <asp:Label ID="lblError" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" CssClass="table">
            <Columns>
                <asp:BoundField DataField="ProductID" HeaderText="Product ID" />
                <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                <asp:BoundField DataField="Category" HeaderText="Category" />
                <asp:BoundField DataField="Brand" HeaderText="Brand" />
                <asp:BoundField DataField="RAM" HeaderText="RAM" />
                <asp:BoundField DataField="ROM" HeaderText="ROM" />
                <asp:BoundField DataField="Price" HeaderText="Price" />
                <asp:BoundField DataField="StockStatus" HeaderText="Stock Status" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <div class="actions">
                            <a href="EditProduct.aspx?ProductID=<%# Eval("ProductID") %>" class="action-btn edit">Edit</a>
                            <a href="DeleteProduct.aspx?ProductID=<%# Eval("ProductID") %>" class="action-btn delete">Delete</a>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

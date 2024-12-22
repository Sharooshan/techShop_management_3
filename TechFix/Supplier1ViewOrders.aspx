<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="Supplier1ViewOrders.aspx.cs" Inherits="TechFix.Supplier1ViewOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
      /* General styles */
        body {
            font-family: 'Roboto', sans-serif; /* Font family */
            background-color: #1b2631; /* Midnight Blue */
            color: #ecf0f1; /* Light text color */
            margin: 0;
            padding: 0;
        }

        /* General styling for the GridView */
        .table {
            width: 100%; /* Full width */
            border-collapse: collapse; /* No spacing between borders */
            margin-bottom: 20px; /* Space below table */
        }

        .table th, .table td {
            border: 1px solid #ddd; /* Border style */
            padding: 8px; /* Padding inside cells */
            text-align: left; /* Left align text */
        }

        .table th {
            background-color: #2c3e50; /* Darker background for header */
            color: #ecf0f1; /* Light text color for header */
            font-weight: bold; /* Bold font */
        }

        .table tr:nth-child(even) {
            background-color: #34495e; /* Darker background for even rows */
        }

        .table tr:hover {
            background-color: #1abc9c; /* Light green on hover */
        }

        /* Button styles */
        .btnUpdate {
            background-color: #e74c3c; /* Burgundy Red */
            color: white; /* White text */
            border: none; /* No border */
            padding: 10px 20px; /* Padding for buttons */
            text-align: center; /* Center text */
            text-decoration: none; /* No underline */
            display: inline-block; /* Inline block element */
            font-size: 14px; /* Font size */
            cursor: pointer; /* Pointer cursor */
            border-radius: 5px; /* Rounded corners */
            transition: background-color 0.3s, transform 0.3s; /* Transition effects */
            box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3); /* Shadow effect */
        }

        .btnUpdate:hover {
            background-color: #c0392b; /* Darker red on hover */
            transform: translateY(-3px); /* Lift effect on hover */
        }

        /* Label message styles */
        .label-message {
            font-size: 16px; /* Font size */
            font-weight: bold; /* Bold font */
            color: red; /* Red color for error messages */
            margin-bottom: 20px; /* Space below */
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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    

         
             <div class="navbar">
    <a href="Supplier1Dashboard.aspx">Home</a>
                 <a href="Supplier1AddProduct.aspx">Add Product</a>
    <a href="ViewProduct.aspx">View Products</a>
    <a href="supp1Profile.aspx">My Profile</a>
    <a href="Supplier1ViewOrders.aspx">View Orders</a>
</div>
    <h2>Your Product Orders</h2>

    <asp:Label ID="lblMessage" runat="server" CssClass="label-message" ForeColor="Red" />

    <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="False" CssClass="table" OnRowCommand="GridViewOrders_RowCommand">
        <Columns>
            <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
            <asp:BoundField DataField="ProductID" HeaderText="Product ID" />
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
            <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" DataFormatString="{0:C}" />
            <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlStatus" runat="server" SelectedValue='<%# Eval("Status") %>'>
                        <asp:ListItem Text="Pending" Value="Pending" />
                        <asp:ListItem Text="Accepted" Value="Accepted" />
                        <asp:ListItem Text="Rejected" Value="Rejected" />
                        <asp:ListItem Text="Delivered" Value="Delivered" />
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update Status" CommandName="UpdateStatus" CommandArgument='<%# Eval("OrderID") %>' CssClass="btnUpdate" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

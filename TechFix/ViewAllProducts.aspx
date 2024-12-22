<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewAllProducts.aspx.cs" Inherits="TechFix.ViewAllProducts" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View All Products</title>
 <style>
     /* General styles */
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #1b2631; /* Midnight Blue */
            color: #ecf0f1;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            position: relative;
        }

        /* Rolls-Royce stars effect */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, #1b2631, #2c3e50, #34495e, #1c2833);
            background-size: 400% 400%;
            animation: gradientAnimation 10s ease infinite;
            z-index: -2;
        }

        /* Rolls-Royce stars (small white dots) */
        body::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: transparent;
            z-index: -1;
            background-image: radial-gradient(2px 2px at 10% 20%, white, transparent),
                              radial-gradient(2px 2px at 30% 60%, white, transparent),
                              radial-gradient(2px 2px at 70% 80%, white, transparent),
                              radial-gradient(2px 2px at 40% 90%, white, transparent),
                              radial-gradient(2px 2px at 50% 30%, white, transparent),
                              radial-gradient(2px 2px at 80% 50%, white, transparent),
                              radial-gradient(2px 2px at 90% 40%, white, transparent),
                              radial-gradient(2px 2px at 20% 70%, white, transparent),
                              radial-gradient(2px 2px at 60% 10%, white, transparent);
            animation: twinkle 3s infinite ease-in-out;
        }

        /* Rolls-Royce starry animation */
        @keyframes twinkle {
            0%, 100% {
                opacity: 0.5;
                transform: translateY(0) scale(1);
            }
            50% {
                opacity: 1;
                transform: translateY(-5px) scale(1.2);
            }
        }

        /* Gradient Background Animation */
        @keyframes gradientAnimation {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        /* Container styles */
       /* Container styles */
.container {
    max-width: 1200px;
    max-height: 80vh; /* Limit height to 80% of the viewport height */
    background-color: #1c1f24;
    border-radius: 10px;
    padding: 40px;
    box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.5);
    text-align: center;
    transition: transform 0.5s ease-in-out, box-shadow 0.5s ease-in-out;
    z-index: 2;
    overflow-y: auto; /* Enable vertical scroll */
}

/* Optional scrollbar styling */
.container::-webkit-scrollbar {
    width: 10px;
}

.container::-webkit-scrollbar-thumb {
    background-color: #3498db; /* Royal blue scrollbar */
    border-radius: 10px;
}

.container::-webkit-scrollbar-track {
    background-color: #1b2631;
}

/* Keep the hover effect */
.container:hover {
    transform: scale(1.05);
    box-shadow: 0px 15px 45px rgba(0, 0, 0, 0.75);
}


        /* Heading styles */
        h1 {
            color: #3498db; /* Royal Blue */
            font-size: 2.5em;
            margin-bottom: 20px;
            position: relative;
            animation: glow 2s infinite alternate;
        }

        @keyframes glow {
            from {
                text-shadow: 0 0 10px #2980b9, 0 0 20px #2980b9, 0 0 30px #3498db, 0 0 40px #3498db;
            }
            to {
                text-shadow: 0 0 20px #2980b9, 0 0 30px #3498db, 0 0 40px #3498db, 0 0 50px #3498db;
            }
        }

        /* Filter styles */
        .filter-container input, .filter-container select {
            padding: 10px;
            margin-right: 15px;
            margin-bottom: 10px;
            border: 1px solid #888;
            border-radius: 6px;
            background-color: #2e2e2e;
            color: #fff;
            font-size: 16px;
            transition: all 0.3s;
        }

        .filter-container input:focus, .filter-container select:focus {
            border-color: #ffcc00;
            outline: none;
            box-shadow: 0 0 5px rgba(255, 204, 0, 0.5);
        }

        /* Product card styles */
        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
        }

        .product-card {
            background-color: #2a2a2a;
            border-radius: 10px;
            width: calc(33.333% - 20px);
            padding: 20px;
            box-sizing: border-box;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.5);
        }

        .product-card img {
            max-width: 100%;
            height: auto;
            border-bottom: 2px solid #ffcc00;
            margin-bottom: 15px;
            border-radius: 8px;
        }

        .product-card h3 {
            font-size: 20px;
            margin: 10px 0;
            color: #ffcc00;
        }

        .product-card p {
            color: #ccc;
            margin: 6px 0;
        }

        /* Updated button styles */
        .btn-order {
            display: inline-block;
            background-color: #e74c3c; /* Burgundy Red */
            color: #fff;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.3s ease;
            box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
        }

        .btn-order:hover {
            background-color: #c0392b;
            transform: translateY(-3px);
        }

        /* Stock status styles */
        .stock-status-out-of-stock {
            color: #ff4d4d; /* Bright red for out of stock */
        }

        .stock-status-in-stock {
            color: #4dff4d; /* Bright green for in stock */
        }

        .stock-status-low-level {
            color: #ffcc00; /* Rolls-Royce yellow for low stock */
        }

        /* Add responsive design */
        @media (max-width: 992px) {
            .product-card {
                width: calc(50% - 20px);
            }
        }

        @media (max-width: 600px) {
            .product-card {
                width: 100%;
            }

            .filter-container input, .filter-container select {
                width: 100%;
                margin-bottom: 15px;
            }
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
    <form id="form1" runat="server">
        <div class="container">
             <div class="navbar">
    <a href="TechFixDashboard.aspx">Home</a>
    <a href="ViewAllProducts.aspx">View Products</a>
    <a href="ViewOrders.aspx">My Orders</a>
    <a href="ViewSuppliers.aspx">Supplier Information</a>
</div>

            <h1>View All Products</h1>
         <div class="filter-container">
    <asp:TextBox ID="txtProductName" runat="server" CssClass="filter-textbox" Placeholder="Search by product name" />
    <asp:TextBox ID="txtBrand" runat="server" CssClass="filter-textbox" Placeholder="Search by brand" />
    <asp:DropDownList ID="categoryFilter" runat="server" CssClass="filter-dropdown" AutoPostBack="True" OnSelectedIndexChanged="categoryFilter_SelectedIndexChanged">
    </asp:DropDownList>
</div>

            <asp:Label ID="lblError" runat="server" CssClass="error" Visible="false"></asp:Label>

            <div class="product-container">
                <asp:Repeater ID="rptProducts" runat="server">
                    <ItemTemplate>
                        <div class="product-card">
                            <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' alt="Product Image" />
                            <h3><%# Eval("ProductName") %></h3>
                            <p><strong>Supplier:</strong> <%# Eval("UserID") %></p> <!-- Display supplier -->
                            <p><strong>Category:</strong> <%# Eval("Category") %></p>
                            <p><strong>Brand:</strong> <%# Eval("Brand") %></p>
                            <p><strong>RAM:</strong> <%# Eval("RAM") %></p>
                            <p><strong>ROM:</strong> <%# Eval("ROM") %></p>
                            <p>
                                <strong>Price:</strong>
                                <%# Eval("Price") %> 
                                <%# Convert.ToDecimal(Eval("Price")) == Convert.ToDecimal(Eval("MinPrice")) ? "<span>(Best Price)</span>" : "" %>
                            </p>
                            <p>
                                <strong>Price Suggestion:</strong>
                                <%# GetPriceSuggestion(Convert.ToDecimal(Eval("Price")), Convert.ToDecimal(Eval("MinPrice"))) %>
                            </p>
                            <p><strong>Stock Status:</strong>
                                <span class='<%# GetStockStatusCssClass(Eval("StockStatus").ToString()) %>'>
                                    <%# Eval("StockStatus") %>
                                </span>
                            </p>
                            <p><strong>Description:</strong> <%# Eval("Description") %></p>
                            <a href='<%# ResolveUrl("~/OrderProduct.aspx?ProductID=" + Eval("ProductID")) %>' class="btn-order">Order Now</a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
</body>
</html>
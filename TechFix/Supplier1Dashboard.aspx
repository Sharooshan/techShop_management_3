<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Supplier1Dashboard.aspx.cs" Inherits="TechFix.Supplier1Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Supplier 1 Dashboard</title>
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
        }

        .container {
            max-width: 800px;
            background-color: #1c1f24;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.5);
            text-align: center;
            transition: transform 0.5s ease-in-out, box-shadow 0.5s ease-in-out;
        }

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

        /* Button styles */
        .dashboard-btn {
            display: inline-block;
            margin: 10px;
            padding: 15px 30px;
            background-color: #e74c3c; /* Burgundy Red */
            color: #fff;
            text-decoration: none;
            border-radius: 50px;
            font-size: 18px;
            transition: background-color 0.3s ease, transform 0.3s ease;
            position: relative;
            overflow: hidden;
            box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
        }

        .dashboard-btn:hover {
            background-color: #c0392b;
            transform: translateY(-5px);
        }

        .dashboard-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(255,255,255,0.2), rgba(255,255,255,0) 60%);
            opacity: 0;
            transition: opacity 0.4s;
        }

        .dashboard-btn:hover:before {
            opacity: 1;
            animation: pulse 1s infinite;
        }

        @keyframes pulse {
            0% {
                transform: scale(0.95);
            }
            70% {
                transform: scale(1);
                box-shadow: 0 0 30px rgba(255, 255, 255, 0.5);
            }
            100% {
                transform: scale(0.95);
            }
        }

        /* Logout button */
        input[type="submit"], 
        button {
            background-color: #3498db; /* Royal Blue */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s, transform 0.3s ease;
            box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
        }

        input[type="submit"]:hover, 
        button:hover {
            background-color: #2980b9;
            transform: translateY(-3px);
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .dashboard-btn {
                width: 100%;
                margin: 10px 0;
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
    <a href="Supplier1Dashboard.aspx">Home</a>
    <a href="Supplier1AddProduct.aspx">Add Product</a>
    <a href="ViewProduct.aspx">View Products</a>
    <a href="supp1Profile.aspx">My Profile</a>
    <a href="Supplier1ViewOrders.aspx">View Orders</a>
</div>

            <h1>Welcome to Supplier 1 Dashboard</h1>
            <p>Manage your products, orders, and inventory here.</p>

            <a href="Supplier1AddProduct.aspx" class="dashboard-btn">Add Product</a>
            <a href="ViewProduct.aspx" class="dashboard-btn">View Product</a>
            <a href="supp1Profile.aspx" class="dashboard-btn">My Profile</a>
            <a href="Supplier1ViewOrders.aspx" class="dashboard-btn">View Orders</a>

            <br /><br />
            <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" />
        </div>
    </form>
</body>
</html>

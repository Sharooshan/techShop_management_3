<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewSuppliers.aspx.cs" Inherits="TechFix.ViewSuppliers" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Suppliers</title>
    <style>
   /* General styles */
body {
    font-family: 'Roboto', sans-serif;
    background-color: #2c3e50; /* Dark Blue */
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

/* Starry background effect */
body::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(45deg, #2c3e50, #34495e, #2c3e50);
    background-size: 300% 300%;
    animation: gradientShift 15s ease infinite;
    z-index: -2;
}

body::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: transparent;
    z-index: -1;
    background-image: radial-gradient(2px 2px at 20% 40%, white, transparent),
                      radial-gradient(2px 2px at 60% 30%, white, transparent),
                      radial-gradient(2px 2px at 70% 80%, white, transparent);
    animation: starTwinkle 4s infinite ease-in-out;
}

/* Gradient animation for smooth background transitions */
@keyframes gradientShift {
    0%, 100% {
        background-position: 0% 50%;
    }
    50% {
        background-position: 100% 50%;
    }
}

/* Star twinkling animation */
@keyframes starTwinkle {
    0%, 100% {
        opacity: 0.6;
    }
    50% {
        opacity: 1;
    }
}

/* Main container styles */
.container {
    max-width: 800px;
    background-color: #34495e; /* Dark Blue-Gray */
    padding: 40px;
    border-radius: 12px;
    text-align: center;
    box-shadow: 0px 15px 35px rgba(0, 0, 0, 0.5);
    z-index: 2;
    transition: all 0.5s ease;
}

.container:hover {
    transform: scale(1.05);
    box-shadow: 0px 20px 50px rgba(0, 0, 0, 0.7);
}

/* Header styles */
h1 {
    font-size: 2.5em;
    margin-bottom: 20px;
    color: #3498db; /* Royal Blue */
    text-shadow: 0px 0px 10px #2980b9;
    animation: glow 2s infinite alternate;
}

/* Glow animation for header */
@keyframes glow {
    from {
        text-shadow: 0 0 10px #2980b9, 0 0 20px #3498db, 0 0 30px #3498db;
    }
    to {
        text-shadow: 0 0 20px #3498db, 0 0 30px #2980b9, 0 0 40px #3498db;
    }
}

/* Supplier card styles */
.supplier-item {
    background-color: #2c3e50; /* Dark Card */
    padding: 20px;
    margin: 20px 0;
    border-radius: 10px;
    box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.3);
    transition: transform 0.4s ease;
}

.supplier-item:hover {
    transform: translateY(-5px);
    box-shadow: 0px 12px 24px rgba(0, 0, 0, 0.5);
}

/* Link styles */
.supplier-item a {
    text-decoration: none;
    color: #e74c3c; /* Red */
    font-weight: bold;
}

.supplier-item a:hover {
    text-decoration: underline;
    color: #c0392b;
}

/* Responsive design */
@media (max-width: 768px) {
    .container {
        padding: 20px;
    }

    .supplier-item {
        padding: 15px;
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

            <h1>Supplier List</h1>
            <asp:Repeater ID="rptSuppliers" runat="server">
                <ItemTemplate>
                    <div class="supplier-item">
                        <h3><%# Eval("ProfileName") %></h3>
                        <p>Email: <%# Eval("Email") %></p>
                        <p>Bio: <%# Eval("Bio") %></p>
                       
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>

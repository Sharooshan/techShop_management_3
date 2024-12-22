<%@ Page Title="View Orders" Language="C#" AutoEventWireup="true" CodeFile="ViewOrders.aspx.cs" Inherits="TechFix.ViewOrders" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Orders</title>
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
    position: relative;
    overflow: hidden;
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

/* Twinkle animation */
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

/* Gradient animation */
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

/* Container */
.container {
    max-width: 900px;
    background-color: #1c1f24;
    border-radius: 10px;
    padding: 40px;
    box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.5);
    text-align: center;
    transition: transform 0.5s ease-in-out, box-shadow 0.5s ease-in-out;
    z-index: 2;
}

.container:hover {
    transform: scale(1.05);
    box-shadow: 0px 15px 45px rgba(0, 0, 0, 0.75);
}

/* Heading styles */
h2 {
    color: #3498db; /* Royal Blue */
    font-size: 2.5em;
    margin-bottom: 20px;
    position: relative;
    animation: glow 2s infinite alternate;
}

/* Glow effect */
@keyframes glow {
    from {
        text-shadow: 0 0 10px #2980b9, 0 0 20px #2980b9, 0 0 30px #3498db, 0 0 40px #3498db;
    }
    to {
        text-shadow: 0 0 20px #2980b9, 0 0 30px #3498db, 0 0 40px #3498db, 0 0 50px #3498db;
    }
}

/* Table Row Styles */
table {
    width: 100%;
    border-collapse: collapse;
    margin: 25px 0;
    font-size: 18px;
    text-align: left;
}

table thead th {
    background-color: #1b2631; /* Midnight Blue */
    color: #ecf0f1;
    padding: 15px;
}

table tbody td {
    padding: 15px;
    background-color: #2c3e50;
    color: #ecf0f1;
    transition: background-color 0.3s ease, color 0.3s ease;
}

/* Row hover effect with better visibility */
table tbody tr:hover {
    background-color: #3498db; /* Brighter blue for contrast */
    color: #fff; /* Make text white for clear visibility */
    cursor: pointer;
}

/* Row hover effect for better text contrast */
table tbody td:hover {
    color: #ecf0f1; /* Ensure text remains clear */
}

/* Hover effect on specific cells (e.g., buttons, action cells) */
table tbody td.action-cell:hover {
    background-color: #e74c3c; /* Burgundy Red */
    color: #fff; /* Text stays white on hover */
    transform: scale(1.05); /* Subtle scale effect */
}

/* For mobile view (optional) */
@media (max-width: 768px) {
    table thead {
        display: none;
    }

    table, table tbody, table tr, table td {
        display: block;
        width: 100%;
    }

    table tr {
        margin-bottom: 15px;
    }

    table tbody td {
        text-align: right;
        padding-left: 50%;
        position: relative;
    }

    table tbody td::before {
        content: attr(data-label);
        position: absolute;
        left: 0;
        width: 50%;
        padding-left: 15px;
        font-weight: bold;
        text-align: left;
        color: #ecf0f1;
    }

    table tbody tr:hover {
        background-color: #3498db; /* Ensure hover color is applied */
        color: #fff;
    }
}


/* Button styles */
#btnBack {
    display: inline-block;
    margin-top: 20px;
    padding: 15px 30px;
    background-color: #e74c3c; /* Burgundy Red */
    color: white;
    text-decoration: none;
    border-radius: 50px;
    font-size: 18px;
    transition: background-color 0.3s ease, transform 0.3s ease;
    position: relative;
    overflow: hidden;
    box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
}

#btnBack:hover {
    background-color: #c0392b;
    transform: translateY(-5px);
}

#btnBack:before {
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

#btnBack:hover:before {
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

/* Responsive design */
@media (max-width: 768px) {
    .container {
        padding: 20px;
    }

    #btnBack {
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
        /* Scrollable table styles */
.scrollable-table {
    max-height: 400px; /* Adjust the height as per your requirement */
    overflow-y: scroll; /* Enables vertical scrolling */
    margin-top: 20px;
    border: 1px solid #34495e; /* Optional border for better visibility */
}

/* Adjust the table width to stay inside the scrollable container */
.scrollable-table .table {
    width: 100%;
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

            <h2>Your Orders</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="False" CssClass="table">
                <Columns>
                    <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                    <asp:BoundField DataField="ProductID" HeaderText="Product ID" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                    <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                </Columns>
            </asp:GridView>
            <br />
            <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" OnClick="btnBack_Click" />
        </div>
    </form>
</body>
</html>

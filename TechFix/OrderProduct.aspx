<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrderProduct.aspx.cs" Inherits="TechFix.OrderProduct" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Order Product</title>
    <style>
        /* General styles */
body {
    font-family: 'Roboto', sans-serif;
    background-color: #1b2631; /* Midnight Blue */
    color: #ecf0f1;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
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

/* Twinkle effect for stars */
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

/* Container styles */
.container {
    max-width: 600px;
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
h1 {
    color: #3498db; /* Royal Blue */
    font-size: 2.2em;
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

/* Product details */
.product-details img {
    max-width: 100%;
    height: auto;
    margin-bottom: 20px;
    border-radius: 5px;
    box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
}

.product-details p {
    font-size: 16px;
    margin: 10px 0;
    color: #ecf0f1;
}

/* Button styles */
.btn {
    display: inline-block;
    padding: 12px 25px;
    background-color: #e74c3c; /* Burgundy Red */
    color: #fff;
    text-decoration: none;
    border-radius: 50px;
    margin-top: 20px;
    font-size: 18px;
    transition: background-color 0.3s ease, transform 0.3s ease;
    box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
}

.btn:hover {
    background-color: #c0392b;
    transform: translateY(-5px);
}

.btn:before {
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

.btn:hover:before {
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

/* Quantity input styles */
input[type="text"], 
input[type="number"], 
asp\:TextBox {
    padding: 10px;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    width: 100px;
    margin-bottom: 20px;
    background-color: #34495e; /* Darker Background */
    color: white;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
}

/* Error message */
.error {
    color: #e74c3c; /* Burgundy Red */
    font-weight: bold;
    margin-top: 10px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .container {
        width: 90%;
        padding: 20px;
    }
    
    h1 {
        font-size: 1.8em;
    }

    .btn {
        width: 100%;
        margin-top: 15px;
    }
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="product-details">
                <h1>Order Product</h1>
                <asp:Label ID="lblError" runat="server" CssClass="error" Visible="false"></asp:Label>
                <asp:Image ID="imgProduct" runat="server" />
                <h2><asp:Label ID="lblProductName" runat="server"></asp:Label></h2>
                <p><strong>Category:</strong> <asp:Label ID="lblCategory" runat="server"></asp:Label></p>
                <p><strong>Brand:</strong> <asp:Label ID="lblBrand" runat="server"></asp:Label></p>
                <p><strong>Price:</strong> $<asp:Label ID="lblPrice" runat="server"></asp:Label></p>
                <p><strong>Stock Status:</strong> <asp:Label ID="lblStockStatus" runat="server"></asp:Label></p>
                
                <!-- Add quantity input -->
                <p><strong>Quantity:</strong> <asp:TextBox ID="txtQuantity" runat="server" Width="100px" /></p>
                
                <asp:Button ID="btnConfirmOrder" runat="server" CssClass="btn" Text="Confirm Order" OnClick="btnConfirmOrder_Click" />
            </div>
        </div>
    </form>
</body>
</html>

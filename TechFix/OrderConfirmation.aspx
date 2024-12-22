<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrderConfirmation.aspx.cs" Inherits="TechFix.OrderConfirmation" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Order Confirmation</title>
    <style>
         /* General Styles */
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

        /* Container Styles */
        .container {
            width: 50%;
            padding: 40px;
            background-color: #1c1f24; /* Dark background for contrast */
            border-radius: 10px;
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
            font-size: 2.5em;
            margin-bottom: 20px;
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

        /* Total Price */
        .total-price {
            font-size: large;
            margin-top: 20px;
            color: #ecf0f1;
        }

        /* Button Styles */
        .btn {
            display: inline-block;
            margin-top: 20px;
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                width: 80%;
                padding: 20px;
            }

            h1 {
                font-size: 2em;
            }

            .btn {
                padding: 10px 20px;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Order Confirmation</h1>
            <asp:Label ID="lblConfirmationMessage" runat="server" FontSize="Large" ForeColor="Green"></asp:Label>
            <br />
            <asp:Label ID="lblTotalPrice" runat="server" CssClass="total-price"></asp:Label>
            <br />
            <a href="TechFixDashboard.aspx" class="btn">Return to Home</a>
        </div>
    </form>
</body>
</html>

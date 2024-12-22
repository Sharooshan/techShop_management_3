<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="login_page.aspx.cs" Inherits="TechFix.login_page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

/* Login container styles */
.login-container {
    background-color: #1c1f24;
    border-radius: 10px;
    padding: 30px;
    max-width: 400px;
    width: 100%;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    text-align: center;
    position: relative;
    z-index: 2;
    transition: transform 0.5s ease-in-out, box-shadow 0.5s ease-in-out;
}

.login-container:hover {
    transform: scale(1.05);
    box-shadow: 0px 15px 45px rgba(0, 0, 0, 0.75);
}

/* Heading styles */
.login-container h2 {
    color: #3498db; /* Royal Blue */
    margin-bottom: 20px;
    font-size: 2em;
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

/* Input field styles */
.login-container input[type="text"], 
.login-container input[type="password"] {
    width: 100%;
    padding: 12px;
    border-radius: 6px;
    border: 1px solid #2c3e50;
    background-color: #2c3e50;
    color: #ecf0f1;
    box-sizing: border-box;
    font-size: 16px;
    transition: border 0.3s ease, box-shadow 0.3s ease;
}

.login-container input[type="text"]:focus, 
.login-container input[type="password"]:focus {
    border: 1px solid #3498db;
    box-shadow: 0 0 10px rgba(52, 152, 219, 0.5);
    outline: none;
}

/* Button styles */
.btnLogin {
    background-color: #e74c3c; /* Burgundy Red */
    color: white;
    padding: 12px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    width: 100%;
    font-size: 16px;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

.btnLogin:hover {
    background-color: #c0392b;
    transform: translateY(-3px);
    box-shadow: 0 8px 15px rgba(231, 76, 60, 0.5);
}

/* Error message */
.error-message {
    color: #e74c3c;
    font-size: 0.9em;
    margin-bottom: 10px;
}

/* Responsive design */
@media (max-width: 768px) {
    .login-container {
        padding: 20px;
    }
}

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-container">
        <h2>Login</h2>
        
        <asp:Label ID="lblError" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        
        <div>
            <label for="txtUsername">Username:</label>
            <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
        </div>
        
        <div>
            <label for="txtPassword">Password:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
        </div>
        
        <div>
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btnLogin" OnClick="btnLogin_Click" />
        </div>
    </div>
</asp:Content>
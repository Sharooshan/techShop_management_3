<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TechFixSidebar.ascx.cs" Inherits="TechFix.TechFixSidebar" %>


<div class="sidebar">
    <ul>
        <li><a href="TechFixDashboard.aspx">Dashboard</a></li>
        <li><a href="ViewAllProducts.aspx">View All Orders</a></li>
        <li><a href="ViewOrders.aspx">My Orders</a></li>
        <li><a href="ViewSuppliers.aspx">Supplier Information</a></li>
        <li><a href="ManageInventory.aspx">Manage Inventory</a></li>
    </ul>
</div>

<style>
    .sidebar {
        width: 250px;
        background-color: #2c3e50;
        padding: 20px;
        position: fixed;
        height: 100%;
        top: 0;
        left: 0;
        overflow: auto;
    }
    .sidebar ul {
        list-style-type: none;
        padding: 0;
    }
    .sidebar ul li {
        margin: 15px 0;
    }
    .sidebar ul li a {
        color: white;
        text-decoration: none;
        padding: 10px;
        background-color: #3498db;
        display: block;
        border-radius: 5px;
    }
    .sidebar ul li a:hover {
        background-color: #2980b9;
    }
</style>

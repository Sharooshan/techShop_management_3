<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductList.aspx.cs" Inherits="TechFix.ProductList" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product List - Supplier 1</title>
    <style>
       body {
            font-family: 'Roboto', sans-serif; /* Changed to Roboto */
            margin: 0;
            padding: 0;
            background-color: #1b2631; /* Dark Background */
            color: #ecf0f1; /* Light Text Color */
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #2c3e50; /* Darker Container Background */
            border-radius: 10px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.5);
        }
        header {
            background-color: #3498db; /* Light Blue Header */
            color: white;
            padding: 15px 0; /* Increased padding */
            text-align: center;
            border-radius: 10px 10px 0 0;
        }
        header h1 {
            margin: 0;
            font-size: 2.5em; /* Increased font size */
        }
        .dashboard-btn {
            display: inline-block;
            padding: 15px 30px; /* Increased padding */
            color: white;
            background-color: #e74c3c; /* Burgundy Red */
            text-decoration: none;
            border-radius: 50px; /* Rounded Button */
            margin-top: 10px;
            font-size: 18px; /* Increased font size */
            transition: background-color 0.3s ease, transform 0.3s ease;
            box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
        }
        .dashboard-btn:hover {
            background-color: #c0392b; /* Darker Burgundy on hover */
            transform: translateY(-5px); /* Slight lift on hover */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #34495e; /* Darker Header for Table */
            color: white; /* White Text for Header */
        }
        tr:hover {
            background-color: #2c3e50; /* Darker Row Hover Color */
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
            transition: background-color 0.3s ease;
        }
        .action-btn.edit {
            background-color: #007bff; /* Blue */
        }
        .action-btn.edit:hover {
            background-color: #0056b3; /* Darker Blue */
        }
        .action-btn.view-more {
            background-color: #28a745; /* Green */
        }
        .action-btn.view-more:hover {
            background-color: #218838; /* Darker Green */
        }
        .product-image {
            width: 100px;
            height: auto;
            border-radius: 5px;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #ecf0f1; /* Light Background for Modal */
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            border-radius: 8px; /* Rounded corners for modal */
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <header>
                <h1>Product List</h1>
                <a href="Supplier1AddProduct.aspx" class="dashboard-btn">Add New Product</a>
            </header>
            <main>
                <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" CssClass="table" OnRowCommand="gvProducts_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' alt="Product Image" class="product-image" onerror="this.src='/images/placeholder.jpg';" />
                            </ItemTemplate>
                        </asp:TemplateField>
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
                                    <a href="#" onclick='showModal({
                                        ImagePath: "<%# ResolveUrl(Eval("ImagePath").ToString()) %>",
                                        ProductName: "<%# Eval("ProductName") %>",
                                        Category: "<%# Eval("Category") %>",
                                        Brand: "<%# Eval("Brand") %>",
                                        RAM: "<%# Eval("RAM") %>",
                                        ROM: "<%# Eval("ROM") %>",
                                        Price: "<%# Eval("Price") %>",
                                        StockStatus: "<%# Eval("StockStatus") %>",
                                        Description: "<%# Eval("Description") %>"
                                    }); return false;' class="action-btn view-more">View More</a>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </main>
        </div>

        <!-- Modal structure -->
        <div id="productModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <div id="modal-body">
                    <!-- Product details will be injected here by JavaScript -->
                </div>
            </div>
        </div>

        <script>
            // Function to show modal with product details
            function showModal(productDetails) {
                var modal = document.getElementById("productModal");
                var modalBody = document.getElementById("modal-body");
                modalBody.innerHTML = `
                    <img src="${productDetails.ImagePath}" class="product-image" />
                    <h2>${productDetails.ProductName}</h2>
                    <p><strong>Category:</strong> ${productDetails.Category}</p>
                    <p><strong>Brand:</strong> ${productDetails.Brand}</p>
                    <p><strong>RAM:</strong> ${productDetails.RAM}</p>
                    <p><strong>ROM:</strong> ${productDetails.ROM}</p>
                    <p><strong>Price:</strong> ${productDetails.Price}</p>
                    <p><strong>Stock Status:</strong> ${productDetails.StockStatus}</p>
                    <p><strong>Description:</strong> ${productDetails.Description}</p>
                `;
                modal.style.display = "block";
            }

            // Function to close modal
            function closeModal() {
                var modal = document.getElementById("productModal");
                modal.style.display = "none";
            }

            // Event listener for closing the modal
            document.querySelector(".close").addEventListener("click", closeModal);

            // Event listener for clicking outside the modal to close it
            window.addEventListener("click", function (event) {
                var modal = document.getElementById("productModal");
                if (event.target == modal) {
                    closeModal();
                }
            });
        </script>
    </form>
</body>
</html>

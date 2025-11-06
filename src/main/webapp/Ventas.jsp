<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="Mapeos.Carrito"%>
<%@ page import="Mapeos.Producto"%>
<%@ page import="Mapeos.Cliente"%>
<%@ page import="java.util.List"%>
<%@ page import="Beans.ProductoDAO"%>
<%@ page import="Beans.ClienteDAO"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="var1" scope="page" class="Mapeos.Producto" />
<jsp:useBean id="var2" scope="page" class="Mapeos.Cliente" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css.css" title="style">
        <title>Comprar Productos - Abarrotes El Compi</title>
    </head>
    <body>
        <h1>Carrito de Compras</h1>
        <div id="menu">
            <ul>
                <li><a href="Conocenos.jsp" class="normalMenu">Conocenos</a></li>
                <li><a href="Productos.jsp" class="normalMenu">Productos</a></li>
                <li><a href="Contacto.jsp" class="normalMenu">Contacto</a></li>
                <li><a href="Acceso.jsp" class="normalMenu">Ingresar</a></li>
                <li><a href="registro.jsp" class="normalMenu">Registrate</a></li>
            </ul>
        </div>

        <%
            ProductoDAO productoDAO = new ProductoDAO();
            List<Producto> listaproductos = productoDAO.obtenListaProducto();
            Carrito carrito = null;
            ClienteDAO clienteDAO = new ClienteDAO();
            Cliente b = (Cliente) session.getAttribute("usuario");
            if (b.getCarrito() != null) {
                carrito = b.getCarrito();
            } else {
                carrito = new Carrito();
                b.setCarrito(carrito);
                session.setAttribute("usuario", b);
            }
        %>
        <form method="post">
            <div style="max-width: 1400px; margin: 0 auto; padding: 20px;">
                <div style="display: grid; grid-template-columns: 1fr 350px; gap: 30px;">
                    <!-- Tabla de productos -->
                    <div>
                        <div style="background: #FFC107; color: white; padding: 20px; border-radius: 8px 8px 0 0; margin-bottom: 0;">
                            <h2 style="margin: 0; font-size: 20px;">Bienvenido, <%= b.getNombre()%></h2>
                            <p style="margin: 5px 0 0 0; font-size: 14px;">Selecciona los productos que deseas comprar</p>
                        </div>
                        <table border="0" style="width: 100%; border-collapse: collapse;">
                            <thead>
                                <tr style="background: #FFC107; color: white;">
                                    <th style="padding: 14px; text-align: left; font-weight: 600;">Nombre</th>
                                    <th style="padding: 14px; text-align: left; font-weight: 600;">Presentacion</th>
                                    <th style="padding: 14px; text-align: left; font-weight: 600;">Precio</th>
                                    <th style="padding: 14px; text-align: center; font-weight: 600;">Stock</th>
                                    <th style="padding: 14px; text-align: center; font-weight: 600;">Cantidad</th>
                                    <th style="padding: 14px; text-align: center; font-weight: 600;">Accion</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Producto a : listaproductos) {%>
                                <tr style="border-bottom: 1px solid #e8e8e8; background: #f8f9fa;">
                                    <td style="padding: 12px 14px; color: #2C3E50; font-weight: 500;"><strong><%= a.getNombreProducto()%></strong></td>
                                    <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getPresentacion()%></td>
                                    <td style="padding: 12px 14px; color: #FFC107; font-weight: 600;">$<%= a.getPrecioUni()%></td>
                                    <td style="padding: 12px 14px; text-align: center; color: #555; font-size: 14px;"><%= a.getExistencias()%></td>
                                    <td style="padding: 12px 14px; text-align: center;">
                                        <% if (a.getExistencias() > 0) {%>
                                        <input id="item-<%=a.getIdProducto()%>" type="number" min="0" max="<%=a.getExistencias()%>" value="0" style="width: 60px; padding: 8px; border: 1px solid #ddd; border-radius: 4px; text-align: center;"/>
                                        <% } else { %>
                                        <span style="color: #999; font-weight: 600;">Agotado</span>
                                        <% } %>
                                    </td>
                                    <td style="padding: 12px 14px; text-align: center;">
                                        <% if (a.getExistencias() > 0) {%>
                                        <button type="button" onclick="addToCart(<%= a.getIdProducto()%>, '<%= a.getNombreProducto()%>', <%= a.getPrecioUni()%>, <%= a.getExistencias()%>)" style="background: #4caf50; color: white; padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; font-weight: 600; font-size: 12px;">Agregar</button>
                                        <% } %>
                                    </td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Carrito Lateral -->
                    <div id="cartContainer" style="background: white; border: 2px solid #FFC107; border-radius: 8px; padding: 20px; height: fit-content; position: sticky; top: 20px;">
                        <div style="background: #FFC107; color: white; padding: 15px; margin: -20px -20px 20px -20px; border-radius: 6px 6px 0 0; text-align: center;">
                            <h3 style="margin: 0; font-size: 18px;">Carrito</h3>
                        </div>
                        <div id="cartItems">
                            <ul id="cartList" style="list-style: none; margin: 0; padding: 0; max-height: 400px; overflow-y: auto;"></ul>
                            <div id="totalCost" style="background: #FFC107; color: white; padding: 12px; border-radius: 4px; margin-top: 15px; font-weight: 600; text-align: center; font-size: 16px;">Total: $0</div>
                        </div>
                        <button type="button" onclick="saveCart()" style="width: 100%; background: #4caf50; color: white; padding: 12px; border: none; border-radius: 4px; cursor: pointer; font-weight: 600; margin-top: 15px; font-size: 14px;">Confirmar Compra</button>
                        <a href="Acceso.jsp" style="display: block; text-align: center; margin-top: 10px; color: #FFC107; font-weight: 600; text-decoration: none;">Cerrar Sesion</a>
                    </div>
                </div>
            </div>
        </form>

        <script>
            const existingCart = JSON.parse(sessionStorage.getItem("cart"));
            const cart = existingCart ? existingCart : {};

            if (existingCart) {
                const cartList = document.getElementById('cartList');
                Object.entries(existingCart).forEach(([productId, productData]) => {
                    displayCartItem(productId, productData.name, productData.quantity, productData.price);
                });
                calculateTotals();
            }

            function addToCart(productId, productName, productPrice, productStock) {
                const inputElement = document.getElementById('item-' + productId);
                const quantityToAdd = parseInt(inputElement.value);

                // Validate the quantity
                if (isNaN(quantityToAdd) || quantityToAdd <= 0) {
                    alert('Por favor, ingrese una cantidad vlida.');
                    return;
                }

                // Check if we exceed stock
                if (!cart[productId]) {
                    cart[productId] = {name: productName, price: productPrice, quantity: 0};
                }
                const newQuantity = cart[productId].quantity + quantityToAdd;

                if (newQuantity > productStock) {
                    alert('No hay suficiente stock para esta cantidad!');
                    return;
                }

                // Update the cart with the new quantity
                cart[productId].quantity = newQuantity;

                // Display the updated cart item
                displayCartItem(productId, productName, cart[productId].quantity, productPrice);

                // Reset input field
                inputElement.value = '0';

                // Update sessionStorage and totals
                sessionStorage.setItem("cart", JSON.stringify(cart));
                calculateTotals();
            }

            function removeFromCart(productId) {
                if (cart[productId]) {
                    cart[productId].quantity -= 1;

                    // If quantity is zero, remove the item from the cart
                    if (cart[productId].quantity <= 0) {
                        delete cart[productId];
                        const listItem = document.querySelector("li[data-product-id='" + productId + "']");
                        if (listItem) {
                            listItem.remove();
                        }
                    } else {
                        // Update the display with the new quantity
                        displayCartItem(productId, cart[productId].name, cart[productId].quantity, cart[productId].price);
                    }

                    // Update sessionStorage and totals
                    sessionStorage.setItem("cart", JSON.stringify(cart));
                    calculateTotals();
                }
            }


            function displayCartItem(productId, productName, quantity, price) {
                const cartList = document.getElementById('cartList');
                let listItem = document.querySelector("li[data-product-id='" + productId + "']");

                if (!listItem) {
                    listItem = document.createElement('li');
                    listItem.setAttribute('data-product-id', productId);
                    listItem.style.cssText = 'display: flex; justify-content: space-between; align-items: center; padding: 12px; margin: 8px 0; background: #f8f9fa; border-radius: 4px; border-left: 4px solid #FFC107;';

                    // Create a span for the product details
                    const productText = document.createElement('span');
                    productText.className = 'productText';
                    productText.style.cssText = 'flex: 1; color: #2C3E50; font-size: 14px; font-weight: 500;';
                    listItem.appendChild(productText);

                    // Add a remove button
                    const removeButton = document.createElement('button');
                    removeButton.textContent = '-';
                    removeButton.style.cssText = 'background: #e53935; color: white; border: none; border-radius: 4px; cursor: pointer; width: 30px; height: 30px; font-size: 16px; font-weight: bold; margin-left: 10px;';
                    removeButton.onclick = () => removeFromCart(productId);
                    removeButton.onmouseover = function() { this.style.background = '#d32f2f'; };
                    removeButton.onmouseout = function() { this.style.background = '#e53935'; };
                    listItem.appendChild(removeButton);

                    cartList.appendChild(listItem);
                }

                // Update the text for the product details
                const total = (price * quantity).toFixed(2);
                const productText = listItem.querySelector('.productText');
                productText.textContent = productName + ' x' + quantity + ' = $' + total;
            }


            function calculateTotals() {
                let grandTotal = 0;
                Object.values(cart).forEach(product => {
                    grandTotal += product.price * product.quantity;
                });
                document.getElementById("totalCost").textContent = 'Total: $' + grandTotal.toFixed(2);
            }

            async function saveCart() {
                if (Object.entries(cart).length === 0) {
                    return;
                }
                const comprarData = Object.entries(cart).map(([id, product]) => '' + parseInt(id) + ',' + product.quantity);
                let tosend = '';
                console.log(comprarData)
                for (let i = 0; i < comprarData.length; i++) {
                    tosend += comprarData[i] + ",";
                }
                const url = "compra.jsp?comprar=" + tosend;
                console.log(url);

                try {
                    const response = await fetch(url, {method: 'GET'});
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    alert("Compra Registrada!");
                    sessionStorage.removeItem("cart");
                    location.reload();
                } catch (error) {
                    alert("Error saving cart!");
                    console.error('Error: (on fetch!)', error);
                }
            }
        </script>
    </body>
    <style>
        li {
            list-style: none;
        }
    </style>
</html>



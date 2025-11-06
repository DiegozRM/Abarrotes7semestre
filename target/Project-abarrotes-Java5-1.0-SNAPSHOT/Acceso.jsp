<%@page import="Beans.CompraDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Mapeos.Compra"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ClienteDAO"%>
<%@page import="Mapeos.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="uname" scope="page" class="Mapeos.Cliente" />

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css.css" title="style">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso del Cliente - Abarrotes El Compi</title>
</head>
<body>
    <div id="menu">
        <ul>
            <li><a href="Conocenos.jsp">Conocenos</a></li>
            <li><a href="Productos.jsp">Productos</a></li>
            <li><a href="Contacto.jsp">Contacto</a></li>
            <li><a href="Acceso.jsp">Ingresar</a></li>
            <li><a href="registro.jsp">Registrate</a></li>
        </ul>
    </div>

    <form method="post">
        <center>
            <h1>Acceso del Cliente</h1>
            <table border="0" width="450px" cellpadding="0" style="box-shadow: 0 2px 10px rgba(0,0,0,0.08);">
                <thead>
                    <tr>
                        <th colspan="2" style="background: #FFC107; color: #ffffff; padding: 20px; font-size: 18px; font-weight: 600;">Iniciar Sesin</th>
                    </tr>
                </thead>
                <tbody style="background: white;">
                    <tr>
                        <td style="padding: 15px; font-weight: 600; color: #2C3E50;">Usuario:</td>
                        <td style="padding: 15px;"><input type="text" name="usuario" value="" placeholder="Ingresa tu nombre de usuario" required style="width: 100%;"/></td>
                    </tr>
                    <tr>
                        <td style="padding: 15px; font-weight: 600; color: #2C3E50;">Contrasea:</td>
                        <td style="padding: 15px;"><input type="password" name="contrasenia" value="" placeholder="Ingresa tu contrasea" required style="width: 100%;"/></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding: 20px; text-align: center; background: #f8f9fa;">
                            <input type="submit" name="enviar" value=" Entrar" style="margin-right: 10px;"/>
                            <input type="reset" value=" Limpiar" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <p style="margin-top: 20px;">
                <a href="index.html" style="color: #FFC107; font-weight: 600; text-decoration: none; border: 2px solid #FFC107; padding: 10px 20px; border-radius: 6px; display: inline-block; transition: all 0.3s ease;"> Pgina Principal</a>
            </p>
        </center>
    </form>

        <% if (request.getParameter("enviar") != null) { %>
        <jsp:setProperty name="uname" property="*" />
        <%
            ClienteDAO empDAO = new ClienteDAO();
            List<Cliente> listaClientes = empDAO.obtenListaCliente();
            boolean us = false;

            String usuario = request.getParameter("usuario");
            String contrasenia = request.getParameter("contrasenia");

            for (Cliente cliente : listaClientes) {
                if (usuario.equals(cliente.getNombre()) && contrasenia.equals(cliente.getPassword())) {
                    us = true;
                    // Iniciar sesin
                    session.setAttribute("usuario", cliente);
                    int idCliente = cliente.getIdCliente();
                    List<List> compras = new ArrayList<List>();
                    CompraDAO compraDAO = new CompraDAO();
                    compras = compraDAO.compraPorCliente(cliente.getIdCliente());

                    break;
                }
            }
            if (us) {
        %>
    <center>
        <h3>Bienvenido <%= usuario%></h3>
        <input type="button" onclick="location.href = 'Productos.jsp'" value="Consultar los productos" name="boton" />
        <input type="button" onclick="location.href = 'Historial.jsp'" value="Mis Compras" name="my_purchases"/>
        <input type="button" onclick="location.href = 'Ventas.jsp'" value="Comprar" name="boton" />
    </center>
    <% } else { %>
    <center>
        <h3>Es posible que el usuario y/o contrasea sean incorrectos.</h3>
        <a href="Acceso.jsp">Intentar de nuevo</a>
    </center>
    <% } %>
    <% }%>
</body>
</html>



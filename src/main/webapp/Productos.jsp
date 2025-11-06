<%-- 
    Document   : Productos
    Created on : 2/11/2013, 03:30:21 PM
    Author     : USUARIO
--%>

<%@page import="Mapeos.Producto"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ProductoDAO"%>
<link rel="stylesheet" type="text/css" href="css.css" title="style">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Productos - Abarrotes El Compi</title>
    </head>
    <script type="text/javascript" src="XHR.js"></script>
    <script type="text/javascript">
        //Defino Variables Globales
        var peticion;
        peticion = obtenerXHR();
        function completapalabra(elemento) {
            peticion.open("POST", "servletAjax", true);
            peticion.onreadystatechange = procesarPeticion;
            peticion.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            var parametros = "nombre=" + elemento.value;
            peticion.send(parametros);
        }
        function procesarPeticion() {
            var div = document.getElementById("resultados");
            if (peticion.readyState == 1) {
                div.innerHTML = "<div style='text-align: center; padding: 20px;'><img src=\"loading.gif\" style='width: 40px;' /> Cargando...</div>";
            }
            if (peticion.readyState == 4) {
                if (peticion.status == 200) {
                    div.innerHTML = peticion.responseText;
                }
            }
        }
    </script> 
    <body>
        <div id="menu">
            <ul>
                <li><a href="Conocenos.jsp"> Conocenos</a></li>
                <li><a href="Productos.jsp"> Productos</a></li>
                <li><a href="Contacto.jsp"> Contacto</a></li>
                <li><a href="Acceso.jsp"> Ingresar</a></li>
                <li><a href="registro.jsp"> Registrate</a></li>
            </ul>
        </div>

        <h1> Catlogo de Productos</h1>
        
        <% ProductoDAO productoDAO = new ProductoDAO();
            List<Producto> listaproductos = productoDAO.obtenListaProducto();
        %>
        <form>
            <CENTER>
                <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 30px; border-left: 4px solid #FFC107;">
                    <p style="color: #2C3E50; font-size: 16px; line-height: 1.6;">
                         Para poder comprar un producto, es necesario tener una cuenta registrada.
                        <a href="index.html" style="color: #FFC107; font-weight: 600; text-decoration: none; margin-left: 10px;" onmouseover="this.textDecoration='underline'" onmouseout="this.textDecoration='none'"> Regresar al Inicio</a>
                    </p>
                </div>
                <table border="0" style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="background: #FFC107; color: white;">
                            <th style="padding: 16px; text-align: left; font-weight: 600;"> Nombre Producto</th>
                            <th style="padding: 16px; text-align: left; font-weight: 600;"> Presentacin</th>
                            <th style="padding: 16px; text-align: left; font-weight: 600;"> Caducidad</th>
                            <th style="padding: 16px; text-align: left; font-weight: 600; text-align: right;"> Precio Unitario</th>
                            <th style="padding: 16px; text-align: left; font-weight: 600;"> Fecha</th>
                            <th style="padding: 16px; text-align: left; font-weight: 600;"> Marca</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%  for (Producto a : listaproductos) {
                        %>
                        <tr style="border-bottom: 1px solid #e8e8e8; background: #f8f9fa;">
                            <td style="padding: 14px 16px; color: #2C3E50;">
                                <strong><%= a.getNombreProducto()%></strong>
                            </td>
                            <td style="padding: 14px 16px; color: #555;"><%= a.getPresentacion()%></td>
                            <td style="padding: 14px 16px; color: #555;"><%= a.getCaducidad()%></td>
                            <td style="padding: 14px 16px; color: #FFC107; font-weight: 600; text-align: right;">$<%= a.getPrecioUni()%></td>
                            <td style="padding: 14px 16px; color: #555;"><%= a.getFech()%></td>
                            <td style="padding: 14px 16px; color: #555;"><%= a.getMarca()%></td>
                        </tr>
                        <% }
                        %>
                    </tbody>
                </table>
                
                <div style="margin-top: 30px; display: flex; gap: 15px; justify-content: center; flex-wrap: wrap;">
                    <input type="button" onclick="location.href = 'registro.jsp'" value=" Registrarse" style="background: #FFC107; color: white; padding: 12px 28px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 14px;" />
                    <input type="button" onclick="location.href = 'buscador.jsp'" value=" Buscar" style="background: #e8e8e8; color: #2C3E50; padding: 12px 28px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 14px;" />
                </div>
            </CENTER>
        </form>
    </body>
</html>



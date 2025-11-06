<%-- 
    Document   : EliminarProducto
    Created on : 19/11/2013, 07:11:05 PM
    Author     : USUARIO
--%>

<%@page import="Mapeos.Producto"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ProductoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css.css" title="style">
        <title>Gestionar Productos - Abarrotes El Compi</title>
    </head>
    <body>
        <h1> Gestin de Productos</h1>
        <% ProductoDAO productoDAO = new ProductoDAO();
            List<Producto> listaproductos = productoDAO.obtenListaProducto();  
        %>
        <form>
            <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 30px; border-left: 4px solid #FFC107; max-width: 900px; margin-left: auto; margin-right: auto;">
                <p style="color: #2C3E50; font-size: 16px; line-height: 1.6;">
                     Para eliminar un producto, seleccionalo en la columna final.
                    <a href="AutentificarEmpleado.jsp" style="color: #FFC107; font-weight: 600; margin-left: 10px;" onmouseover="this.textDecoration='underline'" onmouseout="this.textDecoration='none'"> Cerrar Sesin</a>
                </p>
            </div>
            <table border="0" style="width: 100%; max-width: 900px; margin: 0 auto 30px;">
                <thead>
                <thead>
                    <tr style="background: #FFC107; color: white;">
                        <th style="padding: 14px; text-align: left; font-weight: 600;">#</th>
                        <th style="padding: 14px; text-align: left; font-weight: 600;"> Nombre</th>
                        <th style="padding: 14px; text-align: left; font-weight: 600;"> Presentacin</th>
                        <th style="padding: 14px; text-align: left; font-weight: 600;"> Caducidad</th>
                        <th style="padding: 14px; text-align: right; font-weight: 600;"> P. Proveedor</th>
                        <th style="padding: 14px; text-align: right; font-weight: 600;"> Unitario</th>
                        <th style="padding: 14px; text-align: center; font-weight: 600;"> Existencias</th>
                        <th style="padding: 14px; text-align: left; font-weight: 600;"> Fecha</th>
                        <th style="padding: 14px; text-align: left; font-weight: 600;"> Marca</th>
                        <th style="padding: 14px; text-align: center; font-weight: 600;"> Eliminar</th>
                    </tr>
                </thead>
                <tbody>
                    <%  for (Producto a : listaproductos) {
                    %>
                    <tr style="border-bottom: 1px solid #e8e8e8; background: #f8f9fa;">
                        <td style="padding: 12px 14px; color: #2C3E50; font-size: 14px;" align="center"><%= a.getIdProducto()%></td>
                        <td style="padding: 12px 14px; color: #2C3E50; font-weight: 500;"><strong><%= a.getNombreProducto()%></strong></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getPresentacion()%></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getCaducidad()%></td>
                        <td style="padding: 12px 14px; color: #2C3E50; text-align: right; font-size: 14px;">$<%= a.getPrecioProv()%></td>
                        <td style="padding: 12px 14px; color: #2C3E50; text-align: right; font-size: 14px; font-weight: 600;">$<%= a.getPrecioUni()%></td>
                        <td style="padding: 12px 14px; color: #555; text-align: center; font-size: 14px;"><%= a.getExistencias()%></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getFech()%></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getMarca()%></td>
                        <td style="padding: 12px 14px; text-align: center;"><input type="checkbox" name="cbactores" value="<%=a.getIdProducto()%>" style="width: 18px; height: 18px; cursor: pointer;"/></td>
                    </tr>
                    <% }
                    %>
                </tbody>
            </table>
            
            <div style="margin-top: 30px; display: flex; gap: 15px; justify-content: center; flex-wrap: wrap; max-width: 900px; margin-left: auto; margin-right: auto;">
                <input type="submit" value=" Eliminar Seleccionados" name="eliminar" style="background: #e53935; color: white; padding: 12px 28px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 14px;" />
                <input type="button" onclick="location.href = 'InsertarProducto.jsp'" value=" Nuevo Producto" style="background: #4caf50; color: white; padding: 12px 28px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 14px;" />
                <input type="button" onclick="location.href = 'ModificarProducto.jsp'" value=" Actualizar Producto" style="background: #2196F3; color: white; padding: 12px 28px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 14px;" />
            </div>
        </form>
        <%
            if (request.getParameter("eliminar") != null) {
                String[] chbproductos = request.getParameterValues("cbactores");
                if (chbproductos != null && chbproductos.length > 0) {
                    out.println("<div class='mensaje-exito' style='max-width: 900px; background: #e8f5e9; color: #2e7d32; padding: 20px; border-radius: 8px; border-left: 4px solid #4caf50; margin: 30px auto;'>");
                    out.println("<h3 style='color: #2e7d32; margin-bottom: 15px;'> Productos Eliminados Exitosamente</h3>");
                    for (int i = 0; i < chbproductos.length; i++) {
                        productoDAO.eliminaProducto(Short.valueOf(chbproductos[i]));
                        out.println("<p style='margin: 5px 0;'> Producto ID " + chbproductos[i] + " ha sido eliminado</p>");
                    }
                    out.println("</div>");
                }
            }
        %>
    </body>
</html>



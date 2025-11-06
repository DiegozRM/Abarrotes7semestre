<%-- 
    Document   : EliminarCliente
    Created on : 4/01/2014, 01:30:54 PM
    Author     : Search
--%>

    <%@page import="Beans.ClienteDAO"%> 
    <%@page import="java.util.List"%>
    <%@page import="Mapeos.Cliente"%> 
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css.css" title="style">
        <title>Gestion de Clientes - Abarrotes El Compi</title>
    </head>
    <body>
        <h1>Gestion de Clientes</h1>
        <% ClienteDAO clienteDAO = new ClienteDAO();
            List<Cliente> listaClientes = clienteDAO.obtenListaCliente();
        %>
        <form>
            <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 30px; border-left: 4px solid #FFC107; max-width: 1200px; margin-left: auto; margin-right: auto;">
                <p style="color: #2C3E50; font-size: 16px; line-height: 1.6;">
                    Para eliminar un cliente, seleccionalo en la columna final.
                    <a href="AutentificarEmpleado.jsp" style="color: #FFC107; font-weight: 600; margin-left: 10px;">Cerrar Sesion</a>
                </p>
            </div>
            <table border="0" style="width: 100%; max-width: 1200px; margin: 0 auto 30px;">
                <thead>
                <thead>
                    <tr style="background: #FFC107; color: white;">
                        <th style="padding: 14px; text-align: left; font-weight: 600;">#</th>
                        <th style="padding: 14px; text-align: left; font-weight: 600;">Nombre</th>
                        <th style="padding: 14px; text-align: left; font-weight: 600;">Apellido P.</th>
                        <th style="padding: 14px; text-align: left; font-weight: 600;">Apellido M.</th>
                        <th style="padding: 14px; text-align: left; font-weight: 600;">F. Nacimiento</th>
                        <th style="padding: 14px; text-align: left; font-weight: 600;">RFC</th>
                        <th style="padding: 14px; text-align: left; font-weight: 600;">Correo</th>
                        <th style="padding: 14px; text-align: left; font-weight: 600;">Direccion</th>
                        <th style="padding: 14px; text-align: center; font-weight: 600;">Telefono</th>
                        <th style="padding: 14px; text-align: center; font-weight: 600;">Eliminar</th>
                    </tr>
                </thead>
                <tbody>
                    <%  for (Cliente a : listaClientes) {
                    %>
                    <tr style="border-bottom: 1px solid #e8e8e8; background: #f8f9fa;">
                        <td style="padding: 12px 14px; color: #2C3E50; font-size: 14px;" align="center"><%= a.getIdCliente() %></td>
                        <td style="padding: 12px 14px; color: #2C3E50; font-weight: 500;"><strong><%= a.getNombre() %></strong></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getApellPat() %></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getApellMat() %></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getFechaNac() %></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getRfc() %></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getCorreo() %></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getDireccion() %></td>
                        <td style="padding: 12px 14px; color: #555; text-align: center; font-size: 14px;"><%= a.getTelefono() %></td>
                        <td style="padding: 12px 14px; text-align: center;"><input type="checkbox" name="cbactores" value="<%=a.getIdCliente()%>" style="width: 18px; height: 18px; cursor: pointer;"/></td>
                    </tr>
                    <% }
                    %>
                </tbody>
            </table>
            
            <div style="margin-top: 30px; display: flex; gap: 15px; justify-content: center; flex-wrap: wrap; max-width: 1200px; margin-left: auto; margin-right: auto;">
                <input type="submit" value="Eliminar Seleccionados" name="eliminar" style="background: #e53935; color: white; padding: 12px 28px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 14px;" />
                <input type="button" onclick="location.href='ModificarCliente.jsp'" value="Actualizar Cliente" style="background: #2196F3; color: white; padding: 12px 28px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 14px;" />
                <input type="button" onclick="location.href='InsertarCliente.jsp'" value="Nuevo Cliente" style="background: #4caf50; color: white; padding: 12px 28px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 14px;" />
            </div>
        </form>
        <%
            if (request.getParameter("eliminar") != null) {
                String[] chbClientes = request.getParameterValues("cbactores");
                if (chbClientes != null && chbClientes.length > 0) {
                    out.println("<div class='mensaje-exito' style='max-width: 900px; background: #e8f5e9; color: #2e7d32; padding: 20px; border-radius: 8px; border-left: 4px solid #4caf50; margin: 30px auto;'>");
                    out.println("<h3 style='color: #2e7d32; margin-bottom: 15px;'>Clientes Eliminados Exitosamente</h3>");
                    for (int i = 0; i < chbClientes.length; i++) {
                        clienteDAO.eliminaCliente(Short.valueOf(chbClientes[i]));
                        out.println("<p style='margin: 5px 0;'>Cliente ID " + chbClientes[i] + " ha sido eliminado</p>");
                    }
                    out.println("</div>");
                }
            }
        %>
    </body>
</html>



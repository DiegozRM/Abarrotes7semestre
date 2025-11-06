<%@page import="Mapeos.Empleado"%>
<%@page import="java.util.List"%>
<%@page import="Beans.EmpleadoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="uname" scope="session" class="Mapeos.Empleado" />

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css.css" title="style">
    <title>Gestion de Empleados - Abarrotes El Compi</title>
</head>
<body>
    <h1>Gestion de Empleados</h1>
    <% 
        // Verificar si el objeto de sesin uname es nulo o si el tipo de usuario no es "Administrador"
        if (uname == null || uname.getTipoUsuario() == null || !uname.getTipoUsuario().equals("Administrador")) {
            response.sendRedirect("AccesoDenegado.jsp");
            return; // Salir para evitar que el resto del cdigo se ejecute
        }
        
        EmpleadoDAO empleadoDAO = new EmpleadoDAO();
        List<Empleado> listaEmpleados = empleadoDAO.obtenListaEmpleado();
    %>
    
    <form method="POST">
        <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 30px; border-left: 4px solid #FFC107; max-width: 1200px; margin-left: auto; margin-right: auto;">
            <p style="color: #2C3E50; font-size: 16px; line-height: 1.6;">
                Para eliminar un empleado, seleccionalo en la columna final.
                <a href="AutentificarAdmon.jsp" style="color: #FFC107; font-weight: 600; margin-left: 10px;">Cerrar Sesion</a>
            </p>
        </div>
        <table border="0" style="width: 100%; max-width: 1200px; margin: 0 auto 30px;">
            <thead>
                <tr style="background: #FFC107; color: white;">
                    <th style="padding: 14px; text-align: left; font-weight: 600;">#</th>
                    <th style="padding: 14px; text-align: left; font-weight: 600;">Nombre</th>
                    <th style="padding: 14px; text-align: left; font-weight: 600;">Apellido P.</th>
                    <th style="padding: 14px; text-align: left; font-weight: 600;">Apellido M.</th>
                    <th style="padding: 14px; text-align: left; font-weight: 600;">F. Nacimiento</th>
                    <th style="padding: 14px; text-align: left; font-weight: 600;">RFC</th>
                    <th style="padding: 14px; text-align: right; font-weight: 600;">Salario</th>
                    <th style="padding: 14px; text-align: left; font-weight: 600;">Tipo Usuario</th>
                    <th style="padding: 14px; text-align: center; font-weight: 600;">Eliminar</th>
                </tr>
            </thead>
            <tbody>
                <% for (Empleado a : listaEmpleados) { %>
                    <tr style="border-bottom: 1px solid #e8e8e8; background: #f8f9fa;">
                        <td style="padding: 12px 14px; color: #2C3E50; font-size: 14px;" align="center"><%= a.getNoEmpleado() %></td>
                        <td style="padding: 12px 14px; color: #2C3E50; font-weight: 500;"><strong><%= a.getNombreEmpleado() %></strong></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getApellPatEmpleado() %></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getApellMatEmpleado() %></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getFechaNac() %></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getRfce() %></td>
                        <td style="padding: 12px 14px; color: #2C3E50; text-align: right; font-size: 14px; font-weight: 600;">$<%= a.getSalario() %></td>
                        <td style="padding: 12px 14px; color: #555; font-size: 14px;"><%= a.getTipoUsuario() %></td>
                        <td style="padding: 12px 14px; text-align: center;"><input type="checkbox" name="cbactores" value="<%= a.getNoEmpleado() %>" style="width: 18px; height: 18px; cursor: pointer;"/></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        
        <div style="margin-top: 30px; display: flex; gap: 15px; justify-content: center; flex-wrap: wrap; max-width: 1200px; margin-left: auto; margin-right: auto;">
            <input type="submit" value="Eliminar Seleccionados" name="eliminar" style="background: #e53935; color: white; padding: 12px 28px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 14px;" />
            <input type="button" onclick="location.href='InsertarEmpleado.jsp'" value="Nuevo Empleado" style="background: #4caf50; color: white; padding: 12px 28px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 14px;" />
            <input type="button" onclick="location.href='ModificarEmpleado.jsp'" value="Actualizar Empleado" style="background: #2196F3; color: white; padding: 12px 28px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 14px;" />
        </div>
    </form>

    <%
        if (request.getParameter("eliminar") != null) {
            String[] chbEmpleados = request.getParameterValues("cbactores");
            if (chbEmpleados == null || chbEmpleados.length == 0) {
                out.println("<div class='mensaje-error' style='max-width: 900px; background: #ffebee; color: #c62828; padding: 20px; border-radius: 8px; border-left: 4px solid #e53935; margin: 30px auto;'>");
                out.println("<h3 style='color: #c62828; margin-bottom: 10px;'>Advertencia</h3>");
                out.println("<p>Por favor, selecciona al menos un empleado para eliminar.</p>");
                out.println("</div>");
            } else {
                out.println("<div class='mensaje-exito' style='max-width: 900px; background: #e8f5e9; color: #2e7d32; padding: 20px; border-radius: 8px; border-left: 4px solid #4caf50; margin: 30px auto;'>");
                out.println("<h3 style='color: #2e7d32; margin-bottom: 15px;'>Empleados Eliminados Exitosamente</h3>");
                for (String empleadoId : chbEmpleados) {
                    empleadoDAO.eliminaEmpleado(Short.valueOf(empleadoId));
                    out.println("<p style='margin: 5px 0;'>Empleado ID " + empleadoId + " ha sido eliminado.</p>");
                }
                out.println("</div>");
            }
        }
    %>
</body>
</html>



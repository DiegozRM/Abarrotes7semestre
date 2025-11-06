<%-- 
    Document   : AutentificarEmpleado
    Created on : 19/11/2013, 07:13:08 PM
    Author     : USUARIO
--%>

<%@page import="java.util.List"%>
<%@page import="Beans.EmpleadoDAO"%>
<%@page import="Mapeos.Empleado"%>
<jsp:useBean id="uname" scope="page" class="Mapeos.Empleado" />
<link rel="stylesheet" type="text/css" href="css.css" title="style">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Acceso</title>
    </head>
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

        <form method="POST" style="margin-top: 50px;">
            <center>
                <h1> Acceso del Empleado</h1>
                <table border="0" width="400px" cellpadding="0" style="box-shadow: 0 2px 10px rgba(0,0,0,0.08);">
                    <thead>
                        <tr>
                            <th colspan="2" style="background: #FFC107; color: #ffffff; padding: 20px; font-size: 18px; font-weight: 600;">Iniciar Sesin</th>
                        </tr>
                    </thead>
                    <tbody style="background: white;">
                        <tr>
                            <td style="padding: 15px; font-weight: 600; color: #2C3E50;"> Usuario:</td>
                            <td style="padding: 15px;"><input type="text" name="usuario" value="" placeholder="Ingresa tu usuario" required style="width: 100%;"/></td>
                        </tr>
                        <tr>
                            <td style="padding: 15px; font-weight: 600; color: #2C3E50;"> Contrasea:</td>
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
        <% if (request.getParameter("enviar") != null) {
        %>
        <jsp:setProperty name="uname" property="*" />
        <%
            int i = 1;
            boolean us = false;
            EmpleadoDAO empDAO = new EmpleadoDAO();
            List<Empleado> listaEmpleados = empDAO.obtenListaEmpleado();
            for (i = 0; i < listaEmpleados.size(); i++) {
                uname.setNombreEmpleado(request.getParameter("usuario"));
                uname.setPassword(request.getParameter("contrasenia"));
                if ((uname.getNombreEmpleado().toString().equals(listaEmpleados.get(i).getNombreEmpleado().toString()))
                        && (uname.getPassword().toString().equals(listaEmpleados.get(i).getPassword().toString()))) {
                    if (listaEmpleados.get(i).getTipoUsuario().toString().equals("Empleado") || listaEmpleados.get(i).getTipoUsuario().toString().equals("Administrador")) {
                        us = true;
        %>
    <div class="admin-panel" style="max-width: 800px; margin: 30px auto; padding: 40px; background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08);">
        <center>
            <h2 style="color: #FFC107; background: #2C3E50; padding: 20px; border-radius: 8px; margin-bottom: 30px; font-size: 22px;">
                 Bienvenido, <strong><% out.println(uname.getNombreEmpleado().toString());%></strong>
            </h2>
            
            <div style="background: #f8f9fa; padding: 30px; border-radius: 8px; border-left: 4px solid #FFC107; margin-bottom: 20px;">
                <h3 style="color: #2C3E50; margin-bottom: 15px;"> Gestin de Productos</h3>
                <p style="color: #666; margin-bottom: 15px;">Administra el inventario y catlogo de productos</p>
                <input type="button" onclick="location.href = 'EliminarProducto.jsp'" value=" Ir a Productos" name="boton" style="font-size: 16px; padding: 15px 30px;" />
            </div>
            
            <div style="background: #f8f9fa; padding: 30px; border-radius: 8px; border-left: 4px solid #FFC107; margin-bottom: 20px;">
                <h3 style="color: #2C3E50; margin-bottom: 15px;"> Gestin de Clientes</h3>
                <p style="color: #666; margin-bottom: 15px;">Administra la base de datos de clientes</p>
                <input type="button" onclick="location.href = 'EliminarCliente.jsp'" value=" Ir a Clientes" name="boton" style="font-size: 16px; padding: 15px 30px;" />
            </div>
        </center>
    </div>
    <%  break;
    } else {
        us = true;
    %>
    <center>
        <div class="mensaje-error" style="max-width: 600px; background: #ffebee; color: #c62828; padding: 20px; border-radius: 8px; border-left: 4px solid #e53935; margin: 30px auto;">
            <h3 style="color: #c62828; margin-bottom: 10px;"> ACCESO DENEGADO</h3>
            <p>Solo personal autorizado puede acceder a esta rea</p>
            <a href="index.html" style="color: #c62828; text-decoration: underline; font-weight: 600;"> Volver a la Pgina Principal</a>
        </div>
    </center>
    <%   break;
                }
            }
        }
        if (us == false) {
    %>
    <center>
        <div class="mensaje-error" style="max-width: 600px; background: #ffebee; color: #c62828; padding: 20px; border-radius: 8px; border-left: 4px solid #e53935; margin: 30px auto;">
            <h3 style="color: #c62828; margin-bottom: 10px;"> Error de Autenticacin</h3>
            <p>El usuario y/o contrasea son incorrectos</p>
            <a href="AutentificarEmpleado.jsp" style="color: #c62828; text-decoration: underline; font-weight: 600;"> Intentar de nuevo</a>
        </div>
    </center>
    <%                }
        }

    %>
</body>
</html>


<%-- 
    Document   : AutentificarAdmon
    Created on : 19/11/2013, 07:12:35 PM
    Author     : USUARIO
--%>

<%@page import="java.util.List"%>
<%@page import="Beans.EmpleadoDAO"%>
<%@page import="Mapeos.Empleado"%>
<jsp:useBean id="uname" scope="session" class="Mapeos.Empleado" />
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
                <li><a href="Conocenos.jsp" class="normalMenu">Conocenos</a></li>
                <li><a href="Productos.jsp" class="normalMenu">Productos</a></li>
                <li><a href="Contacto.jsp" class="normalMenu">Contacto</a></li>
                <li><a href="Acceso.jsp" class="normalMenu">Ingresar</a></li>
                <li><a href="registro.jsp" class="normalMenu">Registrate_Aqu</a></li>
            </ul>
        </div>
        <form method="POST" style="margin-top: 50px;">
            <center>
                <h1> Acceso del Empleado</h1>
                <table border="0" width="400px" cellpadding="0" style="box-shadow: 0 4px 20px rgba(0,0,0,0.1);">
                    <thead>
                        <tr>
                            <th colspan="2" style="background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%); color: #2C2C2C; padding: 20px; font-size: 20px;">Iniciar Sesin</th>
                        </tr>
                    </thead>
                    <tbody style="background: white;">
                        <tr>
                            <td style="padding: 15px; font-weight: 600;">Usuario:</td>
                            <td style="padding: 15px;"><input type="text" name="usuario" value="" placeholder="Ingresa tu usuario" required style="width: 100%;"/></td>
                        </tr>
                        <tr>
                            <td style="padding: 15px; font-weight: 600;">Contrasea:</td>
                            <td style="padding: 15px;"><input type="password" name="contrasenia" value="" placeholder="Ingresa tu contrasea" required style="width: 100%;"/></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="padding: 20px; text-align: center; background: #f9f9f9;">
                                <input type="submit" name="enviar" value=" Entrar" style="margin-right: 10px;"/>
                                <input type="reset" value=" Limpiar" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p style="margin-top: 20px;">
                    <a href="index.html" style="color: #FFA500; font-weight: 600; text-decoration: none; border: 2px solid #FFD700; padding: 10px 20px; border-radius: 20px; display: inline-block; transition: all 0.3s ease;"> Pgina Principal</a>
                </p>
            </center>
        </form>
        
        <% 
        if (request.getParameter("enviar") != null) {
            String usuario = request.getParameter("usuario");
            String contrasenia = request.getParameter("contrasenia");
            boolean us = false;
            
            try {
                EmpleadoDAO empDAO = new EmpleadoDAO();
                List<Empleado> listaEmpleados = empDAO.obtenListaEmpleado();
                
                for (Empleado empleado : listaEmpleados) {
                    // Verificamos si el usuario y contrasea coinciden
                    if (empleado.getNombreEmpleado().equals(usuario) && empleado.getPassword().equals(contrasenia)) {
                        // Asignamos los valores al objeto uname de la sesin
                        uname.setNombreEmpleado(usuario);  
                        uname.setTipoUsuario(empleado.getTipoUsuario());  
                        us = true;
                        
                        // Verificamos el tipo de usuario y mostramos el contenido correspondiente
                        if (empleado.getTipoUsuario().equals("Empleado") || empleado.getTipoUsuario().equals("Administrador")) {
        %>
                        <div class="admin-panel" style="max-width: 800px; margin: 30px auto; padding: 40px; background: white; border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.1);">
                            <center>
                                <h2 style="color: #FFD700; background: #2C2C2C; padding: 20px; border-radius: 10px; margin-bottom: 30px;">
                                     Bienvenido, <strong><% out.println(uname.getNombreEmpleado()); %></strong>
                                    <br><span style="font-size: 18px; color: #FFD700;"> <%= uname.getTipoUsuario() %></span>
                                </h2>
                                
                                <div style="background: #FFF9E6; padding: 30px; border-radius: 10px; border: 2px solid #FFD700; margin-bottom: 20px;">
                                    <h3 style="color: #2C2C2C; margin-bottom: 15px;"> Gestin de Productos</h3>
                                    <p style="color: #666; margin-bottom: 15px;">Administra el inventario y catlogo de productos</p>
                                    <input type="button" onclick="location.href = 'EliminarProducto.jsp'" value=" Ir a Productos" name="boton" style="font-size: 16px; padding: 15px 30px;" />
                                </div>
                                
                                <div style="background: #FFF9E6; padding: 30px; border-radius: 10px; border: 2px solid #FFD700; margin-bottom: 20px;">
                                    <h3 style="color: #2C2C2C; margin-bottom: 15px;"> Gestin de Clientes</h3>
                                    <p style="color: #666; margin-bottom: 15px;">Administra la base de datos de clientes</p>
                                    <input type="button" onclick="location.href = 'EliminarCliente.jsp'" value=" Ir a Clientes" name="boton" style="font-size: 16px; padding: 15px 30px;" />
                                </div>
                                
                                <%  if (empleado.getTipoUsuario().equals("Administrador")) { %>
                                <div style="background: #FFF9E6; padding: 30px; border-radius: 10px; border: 2px solid #FFD700; margin-bottom: 20px;">
                                    <h3 style="color: #2C2C2C; margin-bottom: 15px;"> Gestin de Empleados</h3>
                                    <p style="color: #666; margin-bottom: 15px;">Administra usuarios y permisos del sistema</p>
                                    <input type="button" onclick="location.href = 'EliminarEmpleado.jsp'" value=" Ir a Empleados" name="boton" style="font-size: 16px; padding: 15px 30px;" />
                                </div>
                                <% } %>
                            </center>
                        </div>
        <%
                            break;
                        } else {
        %>
                        <center>
                            <div class="mensaje-error" style="max-width: 600px; background: #f8d7da; color: #721c24; padding: 20px; border-radius: 10px; border-left: 4px solid #dc3545; margin: 30px auto;">
                                <h3 style="color: #721c24; margin-bottom: 10px;"> ACCESO DENEGADO</h3>
                                <p>Solo personal autorizado puede acceder a esta rea</p>
                                <a href="index.html" style="color: #721c24; text-decoration: underline; font-weight: 600;"> Volver a la Pgina Principal</a>
                            </div>
                        </center>
        <%
                            break;
                        }
                    }
                }
                
                if (!us) {
        %>
                    <center>
                        <div class="mensaje-error" style="max-width: 600px; background: #f8d7da; color: #721c24; padding: 20px; border-radius: 10px; border-left: 4px solid #dc3545; margin: 30px auto;">
                            <h3 style="color: #721c24; margin-bottom: 10px;"> Error de Autenticacin</h3>
                            <p>El usuario y/o contrasea son incorrectos</p>
                            <a href="AutentificarAdmon.jsp" style="color: #721c24; text-decoration: underline; font-weight: 600;"> Intentar de nuevo</a>
                        </div>
                    </center>
        <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        }
        %>
    </body>
</html>


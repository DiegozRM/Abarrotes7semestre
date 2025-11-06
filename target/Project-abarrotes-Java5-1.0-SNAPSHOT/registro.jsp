<%-- 
    Document   : registro
    Created on : 3/01/2014, 11:04:00 AM
    Author     : Search
--%>

<%@page import="Beans.ClienteDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css.css" title="style">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clientes</title>
        <script type="text/javascript">
            function permite(elEvento, permitidos) { // Variables que definen los caracteres permitidos 
                var numeros = "0123456789";
                var caracteres = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
                var numeros_caracteres = numeros + caracteres;
                var teclas_especiales = [8, 37, 39, 46];
                // 8 = BackSpace, 46 = Supr, 37 = flecha izquierda, 39 = flecha derecha 
                // Seleccionar los caracteres a partir del parmetro de la funcin 
                switch (permitidos) {
                    case 'num':
                        permitidos = numeros;
                        break;
                    case 'car':
                        permitidos = caracteres;
                        break;
                    case 'num_car':
                        permitidos = numeros_caracteres;
                        break;
                }
                // Obtener la tecla pulsada
                var evento = elEvento || window.event;
                var codigoCaracter = evento.charCode || evento.keyCode;
                var caracter = String.fromCharCode(codigoCaracter);
                // Comprobar si la tecla pulsada es alguna de las teclas especiales
                // (teclas de borrado y flechas horizontales)
                var tecla_especial = false;
                for (var i in teclas_especiales) {
                    if (codigoCaracter == teclas_especiales[i]) {
                        tecla_especial = true;
                        break;
                    }
                }
                // Comprobar si la tecla pulsada se encuentra en los caracteres permitidos
                // o si es una tecla especial
                return permitidos.indexOf(caracter) != -1 || tecla_especial;
            }

            function limita(maximoCaracteres) {
                var elemento = document.getElementById("texto");
                if (elemento.value.length >= maximoCaracteres) {
                    return false;
                }
                else {
                    return true;
                }
            }
            function validacion() {

                //validamos campo1
                valor1 = document.getElementById("Nombre").value;
                if (valor1 == null || valor1.length == 0 || /^\s+$/.test(valor1))
                {
                    alert("*Falta ingresar nombre");
                    //return false; 
                }
                //validamos campo2
                valor2 = document.getElementById("Apell_pat").value;

                if (isNaN(valor2)) {
                    alert("*Ingresa Apellido");
                    //return false; 
                }

                valor3 = document.getElementById("Apell_pat").value;

                if (isNaN(valor3)) {
                    alert("*Ingresa Apellido");
                    //return false; 
                }

                valor4 = document.getElementById("Fecha_nac").value;

                if (isNaN(valor4)) {
                    alert("*Ingresa Fecha de nacimiento");
                    //return false; 
                }

                valor5 = document.getElementById("RFC").value;

                if (isNaN(valor5)) {
                    alert("*Ingresa RFC");
                    //return false; 
                }
                valor6 = document.getElementById("correo").value;

                if (isNaN(valor6)) {
                    alert("*Ingresa e-mail");
                    //return false; 
                }


                valor7 = document.getElementById("password").value;

                if (isNaN(valor7)) {
                    alert("*Ingresa Contrasea");
                    //return false; 
                }

                valor8 = document.getElementById("direccion").value;

                if (isNaN(valor8)) {
                    alert("*Ingresa Direccion");
                    //return false; 
                }
                valor9 = document.getElementById("telefono").value;

                if (isNaN(valor9)) {
                    alert("*Ingresa Teefono");
                    //return false; 
                }

                //validar email
                email = document.getElementById("correo").value;
                if (!(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)/.test(email))) {
                    alert("*Email incorrecto");
                    //return false;
                }


                //validar numero de telefono
                telefono = document.getElementById("telefono").value;
                if (!(/^\d{9}$/.test(telefono))) {
                    alert("*Telefono no valido");
                    //return false; 
                }

            }
        </script>
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
        <h1> Portal de Creacin de Cuenta</h1>
        <%
            if (request.getParameter("submit") == null) {
        %> 
        <form onsubmit="return validacion()" style="max-width: 600px;">
            <CENTER>
                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                    <tr>
                        <td colspan="2" style="background: #FFC107; color: white; padding: 15px; border-radius: 8px 8px 0 0; text-align: center; font-weight: 600; font-size: 18px;"> Crear Cuenta Cliente</td>
                    </tr>
                    <tr>
                        <td style="padding: 15px; background: #f8f9fa;">
                            <label style="font-weight: 600; color: #2C3E50; display: block; margin-bottom: 8px;"> Nombre:</label>
                            <input id="Nombre" name="nombre" placeholder="Tu nombre completo"
                                   title="Nombre del cliente" type="text" value="" required style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px; font-size: 14px;"
                                   onkeypress="return permite(event, 'car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 15px;">
                            <label style="font-weight: 600; color: #2C3E50; display: block; margin-bottom: 8px;"> Apellido Paterno:</label>
                            <input id="Apell_pat" name="apellPat" placeholder="Tu apellido paterno"
                                   title="Apellido Paterno" type="text" value="" required style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px; font-size: 14px;"
                                   onkeypress="return permite(event, 'car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 15px; background: #f8f9fa;">
                            <label style="font-weight: 600; color: #2C3E50; display: block; margin-bottom: 8px;"> Apellido Materno:</label>
                            <input id="Apell_mat" name="apellMat" placeholder="Tu apellido materno"
                                   title="Apellido materno" type="text" value="" required style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px; font-size: 14px;"
                                   onkeypress="return permite(event, 'car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 15px;">
                            <label style="font-weight: 600; color: #2C3E50; display: block; margin-bottom: 8px;"> Fecha de Nacimiento:</label>
                            <input id="Fecha_nac" name="fechaNac" placeholder="DD/MM/YYYY"
                                   title="Fecha de nacimiento" type="text" value="" required style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px; font-size: 14px;"
                                   onkeypress="return permite(event, 'num_car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 15px; background: #f8f9fa;">
                            <label style="font-weight: 600; color: #2C3E50; display: block; margin-bottom: 8px;"> RFC:</label>
                            <input id="RFC" name="rfc" placeholder="Tu RFC"
                                   title="RFC cliente" type="text" value="" required style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px; font-size: 14px; text-transform: uppercase;"
                                   onkeypress="return permite(event, 'num_car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 15px;">
                            <label style="font-weight: 600; color: #2C3E50; display: block; margin-bottom: 8px;"> Correo Electrnico:</label>
                            <input id="Correo" name="correo" placeholder="tu@email.com"
                                   title="Correo electronico" type="email" value="" required style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px; font-size: 14px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 15px; background: #f8f9fa;">
                            <label style="font-weight: 600; color: #2C3E50; display: block; margin-bottom: 8px;"> Contrasea:</label>
                            <input id="Password" name="password" placeholder="Tu contrasea segura"
                                   title="Contrasea" type="password" value="" required style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px; font-size: 14px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 15px;">
                            <label style="font-weight: 600; color: #2C3E50; display: block; margin-bottom: 8px;"> Direccin:</label>
                            <input id="direccion" name="direccion" placeholder="Tu direccin completa"
                                   title="Direccin" type="text" value="" style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px; font-size: 14px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 15px; background: #f8f9fa;">
                            <label style="font-weight: 600; color: #2C3E50; display: block; margin-bottom: 8px;"> Telfono:</label>
                            <input id="telefono" name="telefono" placeholder="10 dgitos"
                                   title="Telefono" type="text" value="" style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px; font-size: 14px;" onkeypress="return limita(10);"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 20px; text-align: center; background: #ffffff; border-radius: 0 0 8px 8px;">
                            <input id="submit" name="submit" type="submit" value=" Crear Cuenta" style="background: #FFC107; color: white; padding: 12px 30px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; margin-right: 10px; font-size: 14px;">
                            <input id="limpiar" name="limpiar" type="reset" value="\udd Limpiar" style="background: #e8e8e8; color: #2C3E50; padding: 12px 30px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 14px;">
                        </td>
                    </tr>
                </table>
                <p style="margin-top: 20px;">
                    <a href="index.html" style="color: #FFC107; font-weight: 600; text-decoration: none; border: 2px solid #FFC107; padding: 10px 20px; border-radius: 6px; display: inline-block; transition: all 0.3s ease;"> Pgina Principal</a>
                </p>
            </CENTER>
        </form> 
        <%        } else {%>
        <jsp:useBean id="cliente" scope="page" class="Mapeos.Cliente" />
        <jsp:setProperty name="cliente" property="*" />
        <%
            ClienteDAO registro = new ClienteDAO();
            int id_cliente = registro.guardarCliente(cliente);
            if (id_cliente > 0) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>ID del cliente</th>
                    <th>Nombre cliente</th>
                    <th>Apellido paterno</th>
                    <th>Apellido materno</th>
                    <th>Fecha de nacimiento</th>
                    <th>RFC</th>
                    <th>Email</th>
                    <th>Contrasea</th>
                    <%--<th>Direccin</th>
                    <th>Telefono</th>--%>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= cliente.getIdCliente()%></td>
                    <td><%= cliente.getNombre()%></td>
                    <td><%= cliente.getApellPat()%></td>
                    <td><%= cliente.getApellMat()%></td>
                    <td><%= cliente.getFechaNac()%></td>
                    <td><%= cliente.getRfc()%></td>
                    <td><%= cliente.getCorreo()%></td>
                    <td><%= cliente.getPassword()%></td>
                    <%--<td><%= cliente.getDireccion()%></td>
                    <td><%= cliente.getTelefono()%></td>--%>
                </tr>
            </tbody>
        </table>
        <div class="mensaje-exito" style="max-width: 700px; background: #e8f5e9; color: #2e7d32; padding: 20px; border-radius: 8px; border-left: 4px solid #4caf50; margin: 30px auto; text-align: center;">
            <h2 style="color: #2e7d32; margin-bottom: 15px; font-size: 24px;"> Registro Completado</h2>
            <p style="font-size: 16px;">Tu cuenta se ha creado exitosamente. Ya puedes iniciar sesin.</p>
            <a href="Acceso.jsp" style="color: #2e7d32; font-weight: 600; text-decoration: underline; display: inline-block; margin-top: 10px;"> Ir a Iniciar Sesin</a>
        </div>
    <% } else {%>
    <div class="mensaje-error" style="max-width: 600px; background: #ffebee; color: #c62828; padding: 20px; border-radius: 8px; border-left: 4px solid #e53935; margin: 30px auto; text-align: center;">
        <h2 style="color: #c62828; margin-bottom: 10px;"> Error en el Registro</h2>
        <p>Lo sentimos, no se pudo crear la cuenta. Intntalo nuevamente.</p>
        <a href="registro.jsp" style="color: #c62828; font-weight: 600; text-decoration: underline; display: inline-block; margin-top: 10px;"> Intentar de nuevo</a>
    </div>
    <%}
        }
    %>
</body>
</html>



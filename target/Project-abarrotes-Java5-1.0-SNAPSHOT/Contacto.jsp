<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css.css" title="style">
        <title>Contacto</title>
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
                    alert("*Campo vacio...Ingresa Nombre");
                    //return false; 
                }
                //validamos campo2
                valor2 = document.getElementById("mensaje").value;

                if (isNaN(valor2)) {
                    alert("*Campo vacio...escribe tu mensaje");
                    //return false; 
                }

                valor3 = document.getElementById("email").value;

                if (isNaN(valor3)) {
                    alert("*Campo vacio...e-mail");
                    //return false; 
                }

                //validar email
                email = document.getElementById("email").value;
                if (!(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)/.test(email))) {
                    alert("*Email incorrecto");
                    //return false;
                }


            }
        </script>
    </head>
    <body>
        <div id="menu">
            <ul>
                <li><a href="Conocenos.jsp"> Concenos</a></li>
                <li><a href="Productos.jsp"> Productos</a></li>
                <li><a href="Contacto.jsp"> Contacto</a></li>
                <li><a href="Acceso.jsp"> Ingresar</a></li>
                <li><a href="registro.jsp"> Registrate</a></li>
            </ul>
        </div>

        <div style="max-width: 900px; margin: 40px auto; padding: 0 20px;">
            <h1> Contctanos</h1>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-top: 40px;">
                <!-- Formulario -->
                <div>
                    <h2 style="color: #FFC107; margin-bottom: 20px; font-size: 22px;"> Enva tu Mensaje</h2>
                    <p style="color: #666; margin-bottom: 20px; line-height: 1.6;">
                        Si tienes alguna duda, comentario o sugerencia sobre alguna de nuestras tiendas, no dudes en escribirnos. Tu respuesta llegar prontamente.
                    </p>
                    
                    <form method="post" action="Contacto.jsp" id="contactform" onsubmit="return validacion()">
                        <div style="margin-bottom: 18px;">
                            <label style="font-weight: 600; color: #2C3E50; display: block; margin-bottom: 8px;"> Tu Nombre *</label>
                            <input name="Nombre" type="text" id="Nombre" value="" placeholder="Tu nombre completo" style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px;" required onkeypress="return permite(event, 'car')"/>
                        </div>
                        
                        <div style="margin-bottom: 18px;">
                            <label style="font-weight: 600; color: #2C3E50; display: block; margin-bottom: 8px;"> Tu Email *</label>
                            <input name="correo" type="email" id="email" value="" placeholder="tu@email.com" style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px;" required/>
                        </div>
                        
                        <div style="margin-bottom: 18px;">
                            <label style="font-weight: 600; color: #2C3E50; display: block; margin-bottom: 8px;"> Tu Mensaje *</label>
                            <textarea name="mensaje" rows="8" id="mensaje" placeholder="Escribe tu mensaje aqu" style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 6px; resize: none; font-family: inherit;" required onkeypress="return limita(500);"></textarea>
                        </div>
                        
                        <div style="display: flex; gap: 10px;">
                            <input type="submit" value=" Enviar" style="background: #FFC107; color: white; padding: 12px 24px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; flex: 1;">
                            <input type="reset" value="\udd Limpiar" style="background: #e8e8e8; color: #2C3E50; padding: 12px 24px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; flex: 1;">
                        </div>
                    </form>
                </div>
                
                <!-- Informacin de contacto -->
                <div>
                    <h2 style="color: #FFC107; margin-bottom: 20px; font-size: 22px;"> Informacin de Contacto</h2>
                    
                    <div style="background: #ffffff; padding: 25px; border-radius: 10px; border-left: 4px solid #FFC107; border: 1px solid #e0e0e0;">
                        <p style="margin-bottom: 20px; color: #2C3E50; line-height: 1.8;">
                            <strong>Email:</strong><br>
                            <a href="mailto:abarrotes@elcompi.com.mx" style="color: #FFC107; text-decoration: none; font-weight: 600;">abarrotes@elcompi.com.mx</a>
                        </p>
                        
                        <p style="margin-bottom: 20px; color: #2C3E50; line-height: 1.8;">
                            <strong> Direccin:</strong><br>
                            Sucursales en los 32 estados de Mxico
                        </p>
                        
                        <p style="margin-bottom: 20px; color: #2C3E50; line-height: 1.8;">
                            <strong>Horario de Atencin:</strong><br>
Lunes a Viernes: 8:00 AM - 8:00 PM<br>
Sbados: 9:00 AM - 6:00 PM<br>
Domingos: 10:00 AM - 4:00 PM
                        </p>
                        
                        <p style="margin-top: 25px; padding-top: 20px; border-top: 2px solid #e0e0e0;">
                            <strong style="color: #FFC107;"> Sguenos en Redes Sociales:</strong><br>
                            <a href="http://www.facebook.com" target="_blank" style="color: #FFC107; text-decoration: none; font-weight: 600; display: inline-block; margin-top: 10px;">Facebook</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>



# Script para ejecutar la aplicación con un servidor embebido
$env:Path += ";C:\maven\apache-maven-3.9.9\bin"

# Verificar que el WAR existe
$warFile = ".\target\Project-abarrotes-Java5.war"
if (-Not (Test-Path $warFile)) {
    Write-Host "El archivo WAR no existe. Compilando primero..."
    mvn clean package -DskipTests
}

Write-Host "Iniciando servidor en http://localhost:8080"
Write-Host "Presiona Ctrl+C para detener el servidor"

# Descargar y ejecutar con Jetty si no está instalado
# O usar la herramienta que proporcionamos
$jarUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-runner/9.4.53.v20231009/jetty-runner-9.4.53.v20231009.jar"
$jarFile = ".\jetty-runner.jar"

if (-Not (Test-Path $jarFile)) {
    Write-Host "Descargando Jetty Runner..."
    Invoke-WebRequest -Uri $jarUrl -OutFile $jarFile
}

java -jar $jarFile --port 8080 $warFile

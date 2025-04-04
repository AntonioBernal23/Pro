# Usa una imagen base de Tomcat
FROM tomcat:9.0

# Elimina las apps por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia el archivo WAR generado por Ant al directorio webapps de Tomcat
COPY dist/Proyecto_final.war /usr/local/tomcat/webapps/ROOT.war

# Exponer el puerto 8080
EXPOSE 8080

# Ejecutar Tomcat cuando inicie el contenedor
CMD ["catalina.sh", "run"]

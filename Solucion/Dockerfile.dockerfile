# Crea una nueva imagen a partir de Ubuntu
FROM httpd:latest

# Información sobre la imagen
LABEL \
    authors="DEAW" \
    version="2.0" \
    description="Apache2 + nano + index.html" \
    creationDate="25-11-2024"

    RUN apt-get update && \
    apt-get install -y apache2 apache2-utils openssl
# Copiar los archivos de configuración del sitio y los archivos HTML
COPY html/ /var/www/html/
COPY conf/virtualhost.conf /etc/apache2/sites-available/virtualhost.conf
COPY conf/passwd /etc/apache2/htpasswd
COPY conf/certs/ /etc/ssl/


# Habilitar módulos y sitios
RUN a2enmod ssl
RUN a2ensite virtualhost.conf

# Exponer puertos HTTP y HTTPS
EXPOSE 80
EXPOSE 443

# Comando para iniciar Apache en primer plano cuando se ejecute el contenedor
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
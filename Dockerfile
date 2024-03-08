FROM debian:bookworm
RUN apt-get update && apt-get upgrade -y && apt-get install apache2 libapache2-mod-php php php-mysql mariadb-client -y && apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /var/www/html
COPY src ./
COPY script.sh /opt/
COPY src/database.sql /opt
ENV DB_USER josema
ENV DB_PASSWORD josema
ENV DB_NAME biblioteca
ENV DB_HOST mariadb
RUN chmod +x /opt/script.sh && rm /var/www/html/index.html 
CMD /opt/script.sh
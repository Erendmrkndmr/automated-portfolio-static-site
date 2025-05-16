FROM nginx:alpine

# Gerekli paketler: git ve apache2-utils (htpasswd icin)
RUN apk add --no-cache git apache2-utils

# Github portfolyo sitesini klonla
RUN git clone https://github.com/Erendmrkndmr/Erendmrkndmr.github.io.git /tmp/portfolio && \
    rm -rf /usr/share/nginx/html/* && \
    cp -r /tmp/portfolio/* /usr/share/nginx/html

# Basic Auth kullanicisi (username ve password build arg olarak alinabilir)
ARG USERNAME
ARG PASSWORD
RUN htpasswd -cb /etc/nginx/.htpasswd $USERNAME $PASSWORD

# Nginx konfigurasyonunu kopyala
COPY default.conf /etc/nginx/conf.d/default.conf

RUN echo -e "User-agent: *\nDisallow: /" > /usr/share/nginx/html/robots.txt


# Port ac
EXPOSE 80

# Nginx'i baslat
CMD ["nginx", "-g", "daemon off;"]

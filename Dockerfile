FROM httpd:latest
ENV dir=/usr/local/apache2
WORKDIR $dir
COPY passwords conf/
RUN sed -i '/ServerName www.example.com:80/cServerName localhost:80' conf/httpd.conf
RUN sed -i '/#Include conf\/extra\/httpd-vhosts.conf/cInclude conf\/extra\/httpd-vhosts.conf' conf/httpd.conf
RUN sed -i '/DirectoryIndex index.html/cDirectoryIndex login.cgi' conf/httpd.conf
COPY httpd-vhosts.conf ./conf/extra/
COPY login.cgi ./cgi-bin/
RUN chmod 777 ./cgi-bin/login.cgi
COPY fail.cgi ./cgi-bin/
RUN chmod 777 ./cgi-bin/fail.cgi
EXPOSE 80
CMD ["httpd","-DFOREGROUND"]

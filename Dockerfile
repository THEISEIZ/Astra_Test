#Dockerfile для сборки веб-сервера Apache выводящего собственную веб-страницу
FROM httpd:2.4

#Загрузка веб-страницы в контейнер
ADD https://raw.githubusercontent.com/THEISEIZ/Astra_Test/Other/index.html /usr/local/apache2/htdocs/

#Изменение прав для исправления ошибки с доступом
RUN chmod 644 /usr/local/apache2/htdocs/index.html

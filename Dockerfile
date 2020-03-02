FROM swift:latest

RUN apt-get install git

WORKDIR /root

COPY . .

COPY docker-entrypoint.sh /bin/docker-entrypoint.sh

RUN chmod +x /bin/docker-entrypoint.sh

RUN swift build --configuration release

RUN rm -rf Sources && rm -rf Tests ** rm /root/*.*

ENTRYPOINT ["/bin/docker-entrypoint.sh"]
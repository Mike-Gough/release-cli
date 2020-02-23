FROM swift:latest

RUN apt-get install git

WORKDIR /root

COPY . .

RUN swift build --configuration release

RUN rm -rf Sources && rm -rf Tests ** rm /root/*.*

ENTRYPOINT ["/root/.build/release/ReleaseCli"]
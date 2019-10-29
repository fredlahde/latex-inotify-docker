FROM blang/latex:ubuntu

RUN apt-get update && apt-get install -y inotify-tools
COPY ./watch_files.sh /watch_files.sh

WORKDIR /source
CMD bash /watch_files.sh

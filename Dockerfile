FROM ghcr.io/gramps-project/grampsweb:latest

# copy config file
COPY config.cfg /app/config/

ENV HOME /app

# build full-text search index
# fails with: SECRET_KEY must be specified
# RUN python3 -m gramps_webapi  --config /app/config/config.cfg search index-full

# init a db
RUN gramps -C Pelenitsyns -i pelenitsyns.gramps --config=database.backend:sqlite

# the $PORT variable is needed for Heroku
CMD gunicorn -w 2 -b 0.0.0.0:$PORT --timeout 120 --limit-request-line 8190


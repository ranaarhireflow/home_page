FROM nginx:1.27-alpine

# Static site
COPY index.html /usr/share/nginx/html/index.html

# Config template — substituted with the actual $PORT at container start
COPY nginx.conf.template /etc/nginx/nginx-site.conf.template

# Railway injects $PORT at runtime; 8080 is just the local-dev fallback
ENV PORT=8080
EXPOSE 8080

# Render the config with the live PORT, log everything for Railway debugging,
# then exec nginx in foreground.
CMD : ${PORT:=8080} && \
    envsubst '${PORT}' < /etc/nginx/nginx-site.conf.template > /etc/nginx/conf.d/default.conf && \
    echo "[boot] PORT=$PORT" && \
    echo "[boot] rendered /etc/nginx/conf.d/default.conf:" && \
    cat /etc/nginx/conf.d/default.conf && \
    nginx -t && \
    exec nginx -g 'daemon off;'

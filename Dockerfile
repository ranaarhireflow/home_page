FROM nginx:1.27-alpine

# nginx:alpine auto-processes templates in /etc/nginx/templates/*.template
# via envsubst at container start — perfect for Railway's dynamic $PORT.
COPY nginx.conf.template /etc/nginx/templates/default.conf.template
COPY index.html /usr/share/nginx/html/index.html

# Railway injects $PORT; this is just a local-dev fallback.
ENV PORT=8080
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:${PORT}/ || exit 1

CMD ["nginx", "-g", "daemon off;"]

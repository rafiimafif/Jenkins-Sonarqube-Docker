# ── Dockerfile ──
# 1) Start FROM a specific nginx version
FROM nginx:1.25.2

# 2) Create a system group & user ‘appuser’
RUN addgroup --system appgroup \
 && adduser  --system --ingroup appgroup appuser \
 # 3) Give that user ownership of web files & nginx runtime dirs
 && chown -R appuser:appgroup /usr/share/nginx/html \
 && chown -R appuser:appgroup /var/cache/nginx /var/log/nginx /var/run

# 4) Switch to unprivileged user
USER appuser

# 5) Copy your site into nginx’s html folder
COPY ./website/ /usr/share/nginx/html

# 6) Expose an unprivileged port (≥1024)
EXPOSE 8080

# 7) Launch nginx in foreground
CMD ["nginx", "-g", "daemon off;"]

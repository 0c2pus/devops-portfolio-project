FROM node:20-bullseye-slim AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev && npm cache clean --force

COPY . .

RUN npm run build

FROM nginx:alpine AS production

COPY --from=builder /app/dist /usr/share/nginx/html

RUN apk add --no-cache tini && \
    sed -i 's/worker_processes  1;/worker_processes auto;/' /etc/nginx/nginx.conf && \
    sed -i 's/keepalive_timeout  65;/keepalive_timeout  15;/' /etc/nginx/nginx.conf

EXPOSE 80

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["nginx", "-g", "daemon off;"]
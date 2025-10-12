FROM node:20-alpine AS builder

RUN apk update && apk upgrade && rm -rf /var/cache/apk/*
WORKDIR /app

COPY package*.json ./
RUN npm ci && npm cache clean --force

COPY . .
RUN npm run build

FROM nginx:alpine

RUN apk add --no-cache tini && \
    sed -i 's/worker_processes  1;/worker_processes auto;/' /etc/nginx/nginx.conf && \
    sed -i 's/keepalive_timeout  65;/keepalive_timeout  15;/' /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html

USER nginx
EXPOSE 80

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["nginx", "-g", "daemon off;"]
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci && npm cache clean --force

COPY . .
RUN npm run build

FROM nginx:alpine

RUN apk add --no-cache tini

COPY --from=builder /app/build /usr/share/nginx/html

COPY app/frontend/nginx.conf /etc/nginx/conf.d/default.conf

USER nginx

EXPOSE 80

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["nginx", "-g", "daemon off;"]
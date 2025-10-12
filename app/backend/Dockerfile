FROM node:20-alpine AS builder

RUN apk add --no-cache python3 make g++ git

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev && npm cache clean --force

COPY . .

FROM node:20-alpine

USER node
WORKDIR /app

COPY --from=builder /app /app

EXPOSE 8000

CMD ["node", "server.js"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8000/api/greeting || exit 1

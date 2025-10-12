FROM node:20-alpine AS builder

RUN apk add --no-cache python3 make g++ git

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev && npm cache clean --force

COPY . .

FROM node:20-alpine

ENV NODE_ENV=production

WORKDIR /app

RUN mkdir -p /app && chown -R node:node /app

USER node

COPY --from=builder --chown=node:node /app/node_modules ./node_modules
COPY --from=builder --chown=node:node /app/src ./src
COPY --from=builder --chown=node:node /app/package*.json ./

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:8000/api/greeting || exit 1

CMD ["node", "src/index.js"]
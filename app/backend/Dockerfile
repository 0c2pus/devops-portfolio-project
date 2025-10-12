FROM node:20-bullseye-slim AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential python3 git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package*.json ./

RUN npm ci --omit=dev && \
    npm rebuild sqlite3 --build-from-source && \
    npm cache clean --force

COPY . .

FROM node:20-bullseye-slim

ENV NODE_ENV=production
WORKDIR /app

RUN mkdir -p /app && chown -R node:node /app
USER node

COPY --from=builder /app/node_modules ./node_modules
COPY --chown=node:node . .

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node healthcheck.js || exit 1

CMD ["node", "server.js"]
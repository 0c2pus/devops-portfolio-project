FROM node:20-bullseye-slim AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential python3 git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev && \
    npm rebuild sqlite3 --build-from-source --verbose && \
    npm cache clean --force

FROM node:20-bullseye-slim

ENV NODE_ENV=production
USER node
WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --chown=node:node . .

EXPOSE 8000

CMD ["node", "server.js"]
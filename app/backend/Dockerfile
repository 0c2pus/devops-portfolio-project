FROM node:20-bullseye-slim AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential python3 git curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev && \
    npm rebuild sqlite3 --build-from-source && \
    npm cache clean --force

COPY . .

RUN addgroup --gid 1001 nodejs && adduser --uid 1001 --ingroup nodejs --disabled-password nodejs
RUN chown -R nodejs:nodejs /app
USER nodejs

FROM node:20-bullseye-slim AS production

WORKDIR /app

COPY --from=builder /app /app

RUN npm ci --omit=dev && npm cache clean --force

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node healthcheck.js || exit 1

CMD ["npm", "start"]
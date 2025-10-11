FROM node:20-bullseye-slim AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential python3 git curl && \
    rm -rf /var/lib/apt/lists/*

RUN addgroup --gid 1001 nodejs && \
    adduser --uid 1001 --ingroup nodejs --disabled-password nodejs

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev && \
    npm rebuild sqlite3 --build-from-source && \
    npm cache clean --force

COPY . .

RUN chown -R nodejs:nodejs /app

FROM node:20-slim AS runtime

RUN apt-get update && \
    apt-get install -y --no-install-recommends dumb-init && \
    rm -rf /var/lib/apt/lists/*

RUN addgroup --gid 1001 nodejs && \
    adduser --uid 1001 --ingroup nodejs --disabled-password nodejs

WORKDIR /app

COPY --from=builder /app /app

USER nodejs

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node healthcheck.js || exit 1

ENTRYPOINT ["dumb-init", "--"]

CMD ["npm", "start"]

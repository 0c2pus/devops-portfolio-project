FROM --platform=linux/arm64 node:20-bullseye-slim AS builder

RUN apt-get update && apt-get install -y build-essential python3 git curl && rm -rf /var/lib/apt/lists/*

RUN addgroup --gid 1001 nodejs && adduser --uid 1001 --ingroup nodejs --disabled-password nodejs

WORKDIR /app

COPY package*.json ./

RUN npm ci

RUN npm rebuild sqlite3 --build-from-source

COPY . .

RUN chown -R nodejs:nodejs /app
USER nodejs

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node healthcheck.js || exit 1

CMD ["npm", "start"]
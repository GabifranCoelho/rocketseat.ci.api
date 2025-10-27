# ======= Build Stage =======
FROM node:20-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# ======= Production Stage =======
FROM node:20-alpine
WORKDIR /app

COPY --from=build /app/dist ./dist
COPY package*.json ./

RUN npm ci --omit=dev

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["node", "dist/main.js"]




# FROM node:18-alpine
# WORKDIR /usr/src/app

# COPY package*.json ./
# RUN npm ci

# COPY . .
# EXPOSE 3000
# CMD ["npm","run","start:dev"]

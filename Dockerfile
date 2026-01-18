# Build
FROM node:18-alpine AS build

RUN apk add --no-cache git

WORKDIR /app
RUN git clone https://github.com/Bakalhau/Gelrss.git .

RUN npm install --production

# Runtime
FROM node:18-alpine

# Set working directory
WORKDIR /home/node/app

# Copy application files
COPY --from=build /app/package.json /app/package-lock.json* /app/server.js ./
COPY --from=build /app/node_modules ./node_modules

# Create configs and cache directory
RUN mkdir -p configs cache && chown -R node:node .

USER node

EXPOSE 24454

CMD ["npm", "start"]

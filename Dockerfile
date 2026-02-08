# Build
FROM node:18-alpine AS build

WORKDIR /app
RUN apk add --no-cache git && \
    git clone https://github.com/dav-idka-j/Gelrss.git -b feature/persist-cache . && \
    apk del git

RUN npm install --omit=dev && npm cache clean --force

# Runtime
FROM node:18-alpine

WORKDIR /home/node/app

COPY --from=build /app .

# Create configs and data directory and set ownership
RUN mkdir -p configs && mkdir -p data && chown node:node .
USER node

EXPOSE 24454

CMD ["npm", "start"]

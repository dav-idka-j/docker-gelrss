# Build
FROM node:18-alpine AS build

RUN apk add --no-cache git

WORKDIR /app
RUN git clone https://github.com/dav-idka-j/Gelrss.git -b feature/persist-cache .

RUN npm install --omit=dev

# Runtime
FROM node:18-alpine

# Set working directory
WORKDIR /home/node/app

# Copy application files
COPY --from=build /app .

# Create configs and data directory and set ownership
RUN mkdir -p configs && mkdir -p data && chown node:node .
USER node

EXPOSE 24454

CMD ["npm", "start"]

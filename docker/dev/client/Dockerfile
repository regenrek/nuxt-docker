FROM node:12.20.2-buster-slim

WORKDIR /var/www/client

# Configure host
ENV HOST 0.0.0.0

# Init command
CMD ["sh", "-c", "yarn install && yarn build && yarn start"]
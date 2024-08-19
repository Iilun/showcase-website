FROM node:20.16.0 as build

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build
RUN yarn lint

FROM node:20.16.0-slim

WORKDIR /app
COPY --from=build /app/.output ./

EXPOSE 3000
CMD [ "node", "server/index.mjs" ]
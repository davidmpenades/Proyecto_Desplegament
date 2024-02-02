# Stage 1: install dependencies
FROM node:19-alpine AS install
WORKDIR /usr/src/app
COPY package.json .
RUN npm install

# Stage 2: start
FROM node:19-alpine AS start
WORKDIR /usr/src/app
RUN apk update && apk add bash
COPY --from=install /usr/src/app/package.json .
COPY ./wait-for-it.sh .
COPY src ./src
COPY --from=install /usr/src/app/node_modules/ ./node_modules/
EXPOSE 3000

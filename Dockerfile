# Dockerfile

FROM node:16-alpine as base
RUN mkdir -p /usr/src
WORKDIR /usr/src
COPY . .
RUN yarn
RUN yarn build


# base image
FROM node:16-alpine as main

# create & set working directory
RUN mkdir -p /usr/src
WORKDIR /usr/src


# copy source files
COPY --from=base /usr/src/.next/standalone .
COPY --from=base /usr/src/public ./public
COPY --from=base /usr/src/.next/static ./.next/static

EXPOSE 3000
CMD node server.js

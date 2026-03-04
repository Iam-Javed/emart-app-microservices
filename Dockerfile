FROM node:14 AS BUILD_IMAGE_UI
WORKDIR /usr/src/app
COPY client/ ./client/
RUN cd client && npm install && npm run build

FROM node:14 AS SERVER_BUILD
WORKDIR /usr/src/app
COPY nodeapi/ ./nodeapi/
RUN cd nodeapi && npm install

FROM node:14
WORKDIR /usr/src/app/
COPY --from=SERVER_BUILD /usr/src/app/nodeapi/ ./
COPY --from=BUILD_IMAGE_UI /usr/src/app/client/dist ./client/dist
RUN ls
EXPOSE 4200
EXPOSE 5000
CMD ["/bin/sh", "-c", "cd /usr/src/app/ && npm start"]

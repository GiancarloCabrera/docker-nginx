# PHASE 1: BUILD REACT APP
#INSTALL DEPENDENCIES AND RUN BUILD COMMAND
FROM node:21-alpine3.18 as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# PHASE 2: DEPLOY REACT APP
#COPY BUILD FILES TO NGINX IMAGE
# /app/build --> has the build files from the previous phase
FROM nginx as deploy
# COPY from builder phase from /app/build to /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
# No need to specify CMD as the default CMD for nginx is to start the server

#Steps to build and run the container
#docker build -t react-app .
#docker run -p 8080:80 image-id --> 80 is the default port for nginx
# the visit localhost:8080 in the browser to see the app
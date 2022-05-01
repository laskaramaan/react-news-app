# get the base node image
FROM node:latest AS dev

# set the working dir for container
WORKDIR /app

# copy all the files to container
COPY . . 

# install npm dependencies
RUN npm i && npm run build

# Handle Nginx
FROM nginx:latest

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=dev /app/build/ .

CMD ["nginx", "-g", "daemon off;"]
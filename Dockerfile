# FROM node:alpine as builder 
# WORKDIR '/app'
# COPY package.json .
# RUN npm install
# # optional with docker-compose, but still needed for docker run
# COPY . .
# RUN npm run build 
# # /app/build <- all the stuff we care about

# FROM nginx
# EXPOSE 80
# # I want to copy something from the builder phase
# COPY --from=builder /app/build /usr/share/nginx/html
# # don't need to run nginx since nginx's 
# # default command is running nginx

FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html
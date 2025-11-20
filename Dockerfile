# Stage 1: Build stage
FROM node:18 AS build
WORKDIR /app
COPY . .
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Nginx serve
FROM nginx:latest
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

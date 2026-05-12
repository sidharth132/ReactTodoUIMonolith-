# Build stage
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# # Build-time env (IMPORTANT)
# ARG REACT_APP_API_BASE_URL
# ENV REACT_APP_API_BASE_URL=$REACT_APP_API_BASE_URL

# # Debug (optional - hata sakte ho baad me)
# RUN echo "API URL: $REACT_APP_API_BASE_URL"


RUN npm run build

# Deploy stage
FROM nginx:stable-alpine AS deploy

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

FROM node:20.10.0 AS build

WORKDIR /app

COPY package*.json ./
COPY jest.config.js ./
COPY jsconfig.json ./

RUN npm install

COPY . .

ARG VUE_APP_AUTHORS_API_URL
ARG VUE_APP_BOOKS_API_URL
ENV VUE_APP_AUTHORS_API_URL=${VUE_APP_AUTHORS_API_URL}
ENV VUE_APP_BOOKS_API_URL=${VUE_APP_BOOKS_API_URL}

RUN npm run build

FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
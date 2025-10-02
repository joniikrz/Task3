FROM node:18-alpine

WORKDIR /user/src/app

COPY package*.json ./
COPY app.js ./

RUN npm install

EXPOSE 3000

CMD ["npm","start"]
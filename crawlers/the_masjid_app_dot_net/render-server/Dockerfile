FROM node:lts-slim

WORKDIR /render-server

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "render.js"]

FROM node:19-alpine3.16

WORKDIR /nodejs-app

COPY package.json .

COPY package-lock.json .

RUN npm i


COPY . .

EXPOSE 3000

CMD ["node", "app"]
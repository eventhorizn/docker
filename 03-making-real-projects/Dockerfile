FROM node:alpine

WORKDIR /usr/app

# Copy everything from local working directory to container's
COPY ./package.json ./
RUN npm install

COPY ./ ./

CMD ["npm", "start"]
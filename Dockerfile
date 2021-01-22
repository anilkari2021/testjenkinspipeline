FROM node:12

RUN adduser -D ubuntu
USER ubuntu

# To Create nodejsapp directory
WORKDIR /nodejsapp

# To Install All dependencies

COPY package*.json ./

# To copy all application packages 
COPY . .

# Expose port 3000 and Run the server.js file to start node js application
EXPOSE 3000
CMD [ "node", "index.js" ]

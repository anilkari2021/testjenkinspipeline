FROM node:12

#Add a user with userid 8877 and name nonroot
RUN useradd −u 8877 nonroot

#Run Container as nonroot
USER nonroot

# To Create nodejsapp directory
WORKDIR /nodejsapp

# To Install All dependencies

COPY package*.json ./

# To copy all application packages 
COPY . .

# Expose port 3000 and Run the server.js file to start node js application
EXPOSE 3000
CMD [ "node", "index.js" ]

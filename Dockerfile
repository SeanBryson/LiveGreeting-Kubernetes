# Use the official Node.js 16 image as a parent image
FROM node:16-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (or npm-shrinkwrap.json) to work directory
COPY package.json package-lock.json* ./

# Install dependencies
RUN npm install --production

# Copy the rest of your application's code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Command to run your app
CMD ["node", "server.js"]

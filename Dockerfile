FROM node:14-alpine

WORKDIR /app

# Install wait-for-it
RUN wget -O /usr/local/bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
RUN chmod +x /usr/local/bin/wait-for-it.sh

# Copy package.json and package-lock.json
COPY package*.json ./
RUN npm install

RUN apk update && apk add bash 

COPY . .

EXPOSE 3000

# CMD ["npm", "start"]

ENV DATABASE_URL="postgresql://myuser:mysecretpassword@localhost:5432/mydb?schema=public"
# Wait for database to be ready before running the app
CMD ["wait-for-it.sh", "db:5432", "--", "npm", "run", "start"]


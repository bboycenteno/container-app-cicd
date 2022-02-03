FROM node:16.3.0-alpine

WORKDIR /app

COPY package*.json ./

RUN npm ci --only=production

RUN npm install -g pm2

COPY . .

# Copy and configure the init file
COPY init.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/init.sh

EXPOSE 3000

ENTRYPOINT [ "/usr/local/bin/init.sh" ]
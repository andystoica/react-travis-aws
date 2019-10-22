# STAGE 1
# Build the react app
FROM node:alpine AS builder

# Copy the dependency requirements
WORKDIR /app
COPY package*.json ./

# Install all node dependencies
RUN npm install

# Copy all the source files
COPY ./ ./

# Trigger the build
RUN npm run build


# STAGE 2
# Build the nginx container
FROM nginx

# Make sure AWS exposes the correct port
EXPOSE 80

# Copy only the public files to nginx
COPY --from=builder /app/build /usr/share/nginx/html



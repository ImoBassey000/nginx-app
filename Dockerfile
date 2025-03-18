# Using the official Nginx image as a base
# Copy the custom index.html
# Expose to port 80
# Start the Nginx
FROM nginx:1.21-alpine

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
# Use lightweight NGINX image
FROM nginx:alpine

# Remove default NGINX static files
RUN rm -rf /usr/share/nginx/html/*

# Copy built frontend files
COPY dist/ /usr/share/nginx/html/

# Expose port 3000
EXPOSE 3000

# Change NGINX to listen on port 3000
RUN sed -i 's/80/3000/g' /etc/nginx/conf.d/default.conf

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]

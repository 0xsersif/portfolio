# Multi-stage build: Hugo builder + Caddy server
FROM klakegg/hugo:0.111.3-alpine AS builder

WORKDIR /site
COPY ./my-portfolio .

# Build static site with minification
RUN hugo --minify

# Production stage with Caddy
FROM caddy:2-alpine

# Copy built site from builder stage
COPY --from=builder /site/public /srv

# Copy Caddyfile configuration
COPY Caddyfile /etc/caddy/Caddyfile

# Expose HTTP port
EXPOSE 80

# Caddy runs automatically as entrypoint

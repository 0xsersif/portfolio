# Project Overview

This is a personal portfolio website for '0xSersif', a self-taught developer with a background in networks and telecommunications. The website is built using the [Hugo](https://gohugo.io/) static site generator and the [Congo](https://github.com/jpanther/congo) theme.

The website is configured to be deployed at https://0xmuler.github.io/.

## Building and Running

To work with this project, you need to have [Hugo](https://gohugo.io/getting-started/installing/), [Go](https://golang.org/doc/install) and [Node.js](https://nodejs.org/en/download/) installed.

To install the dependencies, run the following command in the `my-portfolio/themes/congo` directory:

```bash
npm install
```

To start the local development server, run the following command:

```bash
hugo server
```

This will start a local server, and you can view the website at http://localhost:1313/. The theme will be downloaded automatically.

To build the website for production, run:

```bash
hugo
```

This will generate the static files in the `public/` directory.

## Technologies Used

*   **Static Site Generator:** [Hugo](https://gohugo.io/)
*   **Theme:** [Congo](https://github.com/jpanther/congo)
*   **Styling:** [Tailwind CSS](https://tailwindcss.com/)
*   **Search:** [Fuse.js](https://fusejs.io/)
*   **Charts:** [Chart.js](https://www.chartjs.org/)
*   **Math Rendering:** [KaTeX](https://katex.org/)
*   **Diagrams:** [Mermaid](https://mermaid-js.github.io/mermaid/#/)
*   **Icons:** [Font Awesome](https://fontawesome.com/)

## Go Modules

The theme uses Go modules to manage its dependencies. The `go.mod` file is located in the `my-portfolio/themes/congo` directory.

```
module github.com/jpanther/congo/v2

go 1.16
```

## Development Conventions

The project uses the Congo theme, which is a Hugo module. The theme is located in the `themes/congo` directory.

The main configuration file is `hugo.toml`, which contains the basic site configuration. The theme-specific configuration is located in the `config/_default/` directory.

The content of the website is located in the `content/` directory. The structure of this directory determines the structure of the website. Currently, the `content` directory is empty, so there is no content for the website yet.
# 0xMuler Portfolio - Deployment Guide

MLOps/ML Engineering portfolio built with Hugo and deployed to Raspberry Pi 4.

## Quick Start (Local Development)

```bash
cd my-portfolio
hugo server -D
# Visit http://localhost:1313
```

## Project Structure

```
portfolio/
├── my-portfolio/          # Hugo site
│   ├── content/          # Markdown content
│   ├── assets/css/       # Custom CSS
│   ├── hugo.toml         # Hugo configuration
│   └── themes/congo/     # Congo theme
├── Dockerfile            # Multi-stage build
├── docker-compose.yml    # Container orchestration
└── Caddyfile            # Web server config
```

## Build for Production

### Option 1: Static Files (Nginx)

```bash
cd my-portfolio
hugo --minify
# Output in public/ directory
```

Deploy to Raspberry Pi:

```bash
# Transfer to Pi
rsync -avz public/ pi@192.168.1.100:~/portfolio-public/

# On Pi: Install Nginx
sudo apt update && sudo apt install nginx -y

# Copy files to web root
sudo rm -rf /var/www/html/*
sudo cp -r ~/portfolio-public/* /var/www/html/

# Restart Nginx
sudo systemctl restart nginx

# Access at http://192.168.1.100
```

### Option 2: Docker with Caddy (Recommended)

```bash
# Build and run with Docker Compose
docker-compose up -d

# Access at http://localhost (or Pi IP)
```

**Transfer to Raspberry Pi**:

```bash
# Copy entire project to Pi
scp -r portfolio/ pi@192.168.1.100:~/

# SSH into Pi
ssh pi@192.168.1.100

# Navigate and deploy
cd ~/portfolio
docker-compose up -d
```

## Raspberry Pi Setup

### Prerequisites

1. **Raspberry Pi OS** (64-bit recommended)
2. **Docker** (for containerized deployment)

```bash
# Install Docker on Pi
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker pi

# Install Docker Compose
sudo apt install docker-compose -y
```

### Performance Tips

- **Use lightweight OS**: Raspberry Pi OS Lite
- **Disable unnecessary services**: Free up RAM
- **Add swap space**: If only 2GB RAM

```bash
# Add 2GB swap
sudo dd if=/dev/zero of=/swapfile bs=1G count=2
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

## Monitoring

### Check Container Status

```bash
docker-compose ps
docker-compose logs -f
```

### Resource Usage

```bash
# CPU/RAM monitoring
htop

# Docker stats
docker stats
```

## Updating Content

1. Edit markdown files in `my-portfolio/content/`
2. Test locally: `hugo server -D`
3. Rebuild: `docker-compose up -d --build`

## Customization

### Update Base URL

Edit `my-portfolio/hugo.toml`:

```toml
baseURL = 'http://192.168.1.100/'  # Your Pi IP
# or
baseURL = 'https://yourdomain.com/'  # Custom domain
```

### Enable HTTPS with Let's Encrypt

Edit `Caddyfile`:

```
yourdomain.com {
    root * /srv
    file_server
    encode gzip
}
```

Caddy automatically obtains SSL certificates!

## Troubleshooting

### Site not accessible

```bash
# Check if Caddy is running
docker ps

# Check logs
docker logs oxmuler-portfolio

# Verify port 80 is open
sudo netstat -tuln | grep :80
```

### Out of memory on Pi

```bash
# Check RAM usage
free -h

# Reduce resource usage
docker-compose down
# Edit docker-compose.yml, add memory limits
```

### Slow  build times

```bash
# Build on local machine, transfer public/ only
cd my-portfolio
hugo --minify
scp -r public/ pi@192.168.1.100:~/portfolio-public/
```

## Tech Stack

- **Static Site Generator**: Hugo
- **Theme**: Congo
- **Web Server**: Caddy (auto-HTTPS)
- **Containerization**: Docker + Docker Compose
- **Deployment**: Raspberry Pi 4 (2GB RAM)

## Portfolio Content

- ✅ ML/MLOps Projects (RAG, LLM fine-tuning, multi-agent)
- ✅ Core ML Engineering (Recommender, CV, Time-series)
- ✅ Full-stack Projects (Go, Python, Flask)
- ✅ Development Philosophy
- ✅ 2026 Futuristic UI (glassmorphism, dark mode)

## License

MIT License - feel free to fork and customize!

## Contact

- **GitHub**: [0xmuler](https://github.com/0xmuler)
- **Portfolio**: https://0xmuler.github.io

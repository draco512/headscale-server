# Headscale Server

Self-hosted Tailscale coordination server with web UI and automatic SSL certificates.

## Quick Start

1. **Clone and setup:**
   ```bash
   git clone <repo-url>
   cd headscale-server
   ./scripts/setup.sh
   ```

2. **Configure email:**
   ```bash
   # Edit .env file
   ACME_EMAIL=vps@draco512.de
   ```

3. **Start services:**
   ```bash
   docker-compose up -d
   ```

4. **Create first user:**
   ```bash
   ./scripts/user-management.sh create-user home-lab
   ```

## Architecture

- **Headscale**: Coordination server (port 8080)
- **Traefik**: Reverse proxy with Let's Encrypt SSL
- **headscale-admin**: Web UI for management
- **Custom DERP**: Regional relay server

## URLs

- Headscale API: `https://vps.schefenacker.net`
- Admin UI: `https://admin.vps.schefenacker.net`
- Traefik Dashboard: `https://traefik.vps.schefenacker.net`

## Management Commands

```bash
# User management
./scripts/user-management.sh create-user <username>
./scripts/user-management.sh list-users

# Node management  
./scripts/user-management.sh register-node <user> <nodekey>
./scripts/user-management.sh list-nodes

# Generate API key
./scripts/user-management.sh api-key
```

## Backup & Restore

```bash
# Backup
./scripts/backup.sh

# Restore
docker-compose down
cp backup-YYYY-MM-DD.tar.gz data/
tar -xzf backup-YYYY-MM-DD.tar.gz
docker-compose up -d
```

## Troubleshooting

- **SSL Issues**: Check DNS records point to `194.164.49.35`
- **DERP Issues**: Verify ports 443, 3478 are open
- **Database**: SQLite file at `data/headscale/db.sqlite`
#!/bin/bash
set -e

echo "🚀 Setting up Headscale server..."

# Create directories
mkdir -p data/{headscale,letsencrypt} config/{traefik,headscale}

# Generate .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Generating .env file..."
    cp .env.example .env
    
    # Generate API key
    API_KEY="hs_$(openssl rand -hex 32)"
    sed -i "s/HEADSCALE_API_KEY=.*/HEADSCALE_API_KEY=${API_KEY}/" .env
    
    echo "✅ Generated API key: ${API_KEY}"
    echo "⚠️  Please update ACME_EMAIL in .env file"
fi

# Set proper permissions
chmod 600 .env
chmod -R 755 data/
chmod -R 644 config/

echo "🔧 Starting services..."
docker-compose up -d

echo "⏳ Waiting for headscale to start..."
sleep 10

# Generate first user namespace
echo "👥 Creating default user namespace..."
docker-compose exec headscale headscale users create default

echo "✅ Setup complete!"
echo ""
echo "🌐 Access points:"
echo "   - Headscale: https://YOUR_DOMAIN"
echo "   - Admin UI: https://admin.YOUR_DOMAIN"
echo ""
echo "📋 Next steps:"
echo "   1. Check logs: docker-compose logs -f"
echo "   2. Create devices: docker-compose exec headscale headscale nodes register --user default --key <device-key>"
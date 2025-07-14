#!/bin/bash

set -e

echo "🚀 Starting Entity Caching Demo..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Build and start all services
echo "🔧 Building and starting services..."
docker-compose up --build -d

echo "⏳ Waiting for services to start..."
sleep 30

echo "🔍 Checking service status..."
docker-compose ps

echo "✅ Services started!"
echo ""
echo "🌐 Access points:"
echo "  - Apollo Router GraphQL Playground: http://localhost:4000"
echo "  - Sports Data GraphiQL: http://localhost:4001/graphiql"
echo "  - Account GraphiQL: http://localhost:4002/graphiql"
echo "  - Marketplace GraphiQL: http://localhost:4003/graphiql"
echo "  - Cache Viewer GraphiQL: http://localhost:4004/graphiql"
echo "  - Redis: localhost:6379"
echo ""
echo "📝 To view logs: docker-compose logs -f [service-name]"
echo "🛑 To stop: docker-compose down"

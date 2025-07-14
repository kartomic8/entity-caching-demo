# Entity Caching Demo

This project demonstrates Apollo Router's entity caching capabilities using Elixir Phoenix/Absinthe subgraphs and Redis.

## Architecture

The project consists of:

1. **Apollo Router** - GraphQL federation gateway with entity caching
2. **Redis** - Cache storage backend
3. **4 Elixir Subgraphs**:
   - **Sports Data** - Player and team information
   - **Account** - User accounts and favorites
   - **Marketplace** - Event cards and UI data
   - **Cache Viewer** - Redis cache inspection tools

## Quick Start

### Prerequisites

- Docker and Docker Compose
- (Optional) Elixir 1.15+ for local development

### Running the Demo

1. **Start all services:**
   ```bash
   ./start.sh
   ```

2. **Access the GraphQL Playground:**
   - Main federated API: http://localhost:4000
   - Individual subgraph GraphiQL interfaces also available on ports 4001-4004

3. **Stop services:**
   ```bash
   docker compose down
   ```

## Usage Examples

### Basic Queries

**Get upcoming events:**
```graphql
query UpcomingEvents{
  upcomingEvents {
    awayParticipant {
      ...Team
      ...Player
      __typename
    }
    homeParticipant {
      ...Team
      ...Player
      __typename
    }
  }
}

fragment Team on Team {
  resourceUri
  fullName
  abbreviation
  isFavorite
}

fragment Player on Player {
  resourceUri
  fullName
  shortName
  isFavorite
}
```

You can send a header value of `x-user-id: user_1` or `x-user-id: user_2` to simulate retrieving data for two different users. 

**Get cache entries:**
```graphql
query {
  getCacheEntries {
    key
    value
    ttl
  }
}
```

**Query with user context (add x-user-id header):**
```graphql
query {
  upcomingEvents {
    homeParticipant {
      ... on Team {
        resourceUri
        fullName
        isFavorite
      }
    }
  }
}
```

### Cache Management

**Set cache headers for different subgraphs:**
```graphql
mutation {
  updateSportsDataCacheHeader(header: "max-age=300")
  updateAccountCacheHeader(header: "max-age=60")
  updateMarketplaceCacheHeader(header: "max-age=120")
}
```

## Development

### Project Structure

```
entity-caching-demo/
├── apollo-router/          # Router configuration
├── sports-data/           # Sports data subgraph
├── account/              # Account subgraph
├── marketplace/          # Marketplace subgraph
├── cache-viewer/         # Cache viewer subgraph
├── docker-compose.yml    # Service orchestration
└── start.sh             # Quick start script
```

### Adding to the Supergraph

To generate the proper federated schema:

1. Start the individual subgraphs
2. Use Apollo's `rover` CLI to compose the supergraph:
   ```bash
   rover supergraph compose --config supergraph.yaml
   ```

### Local Development

Each subgraph can be run locally:

```bash
cd sports-data
mix deps.get
mix phx.server
```

## Testing Entity Caching

1. **Run a query** to populate the cache
2. **Check cache entries** using the cache viewer
3. **Modify cache headers** using mutations
4. **Observe caching behavior** by running the same queries

## Cache Headers

Each subgraph supports dynamic cache header configuration:

- **Sports Data**: `updateSportsDataCacheHeader(header: String)`
- **Account**: `updateAccountCacheHeader(header: String)`
- **Marketplace**: `updateMarketplaceCacheHeader(header: String)`

You can change them in batch by executing the following mutation:

```graphql
mutation UpdateCacheSettings{
  updateMarketplaceCacheHeader(header: "s-maxage=3600")
  updateAccountCacheHeader(header:"max-age=300")
  updateSportsDataCacheHeader(header: "s-maxage=3600")
}
```



These mutations allow you to experiment with different caching strategies in real-time.

## Troubleshooting

### Common Issues

1. **Port conflicts**: Ensure ports 4000-4004 and 6380 are available
2. **Docker not running**: Start Docker Desktop
3. **Services not starting**: Check logs with `docker-compose logs -f [service-name]`

### Logs

View logs for specific services:
```bash
docker-compose logs -f apollo-router
docker-compose logs -f sports-data
docker-compose logs -f redis
```

## Entity Cache Configuration

The Apollo Router is configured with:
- Redis backend on `redis://redis:6379` from within docker or `redis://localhost:6380` from your host machine
- 1-hour default TTL
- Entity caching enabled for all subgraphs

Modify `apollo-router/router.yaml` to adjust cache settings.

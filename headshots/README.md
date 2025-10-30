# Headshots Subgraph

This subgraph extends the `Player` entity with headshot URL functionality.

## Features

- Extends `Player` entity from the sports-data subgraph
- Adds `headshotUrl` field with size argument (SMALL, MEDIUM, LARGE)
- Generates URLs in format: `https://headshots.example.com/:player_id/:size`
- Supports dynamic cache header configuration via mutation

## Schema

```graphql
enum Size {
  SMALL
  MEDIUM
  LARGE
}

extend type Player @key(fields: "resourceUri") {
  resourceUri: String!
  headshotUrl(size: Size!): String
}

type Mutation {
  updateHeadshotsCacheHeader(header: String): Result
}

enum Result {
  OK
  ERROR
}
```

## Example Query

```graphql
query {
  upcomingEvents {
    homeParticipant {
      ... on Player {
        fullName
        headshotUrl(size: LARGE)
      }
    }
  }
}
```

## Local Development

```bash
cd headshots
mix deps.get
mix phx.server
```

The service will be available at http://localhost:4000/graphiql

## Docker

The subgraph runs on port 4005 externally (4000 internally) when deployed via docker-compose.

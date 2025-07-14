# Entity Caching Demo

## Background and Context

This project is intended to demonstrate the capabilities of the Apollo Router entity cache using Elixir's Phoenix and Asbinthe frameworks.  It will do this with 3 subgraphs, and a UI that allows a user to play around with cache settings, run queries, and see the resulting behavior.

## Architecture

The overall project should leverage docker and docker compose to run the various components of the solution.  These components are:

1. The Apollo Router federated graphql router configured to use redis and the entity cache
2. A redis instance to be used as the entity cache
3. 4 subgraphs implemented in Elixir using the Phoenix, Absinthe, and Absinthe Federation libraries.  The high level schemas, and capabilities of each of the subgraphs are described in the section titled Project Structure.




## Project Structure
In this project we have 4 subgraphs that implement the combined API

The subgraphs are as follows:
1. Account - Holds all user-specific data and functionality 
2. Marketplace - Serves a server-driven UI style GraphQL API to present the data from the other two subgraphs.
3. SportsData  - Serves data related to Sports Teams and Players.
4. EntityCacheViewer - Exposes queries that allow a user to see the 

There is no user interface for this project, only the subgraphs defined above.  The user will use the GraphiQL tool provided by the Apollo Router to interact with these APIs and view the different results.


## Subgraph Schema

### SportsData Subgraph Schema
```GraphQL
type Player @key(fields: "resourceUri") {
  resourceUri: String!
  fullName: String!
  shortName: String!
}

type Team @key(fields: "resourceUri") {
  resourceUri: String!
  fullName: String!
  abbreviation: String!
}

mutation Mutation {
  updateSportsDataCacheHeader: Result
}

enum Result @shareable {
   OK,
   ERROR
}


```

#### Notes

This subgraph only exposes a reference resolvers for the entities defined above.
The subgraph should include a hardcoded data source for the Player and Team types.  
The resourceUri format for a player will be /players/:player_id.  This is applicable to all subgraphs
The resourceUri format for a team will be /teams/:team_id.  This is applicable to all subgraphs
By default the subgraph should not return any caching headers.
If a null or empty value is provided for the string argument of the mutation, then the subgraph should not return any caching headers.  Otherwise, the cahe header returned by the subgraph should be the value provided in this mutation.

### Account Subgraph Schema
```GraphQL
type User @key(fields: "id") {
  id: ID!
  nickname: String!
}

type Team @key(fields: "resourceUri") {
  resourceUri: String!
  isFavorite: Boolean
}

type Player @key(fields: "resourceUri") {
  resourceUri: String!
  isFavorite: Boolean
}

type Mutation {
  updateAccountCacheHeader($header: String): Result
}

enum Result @shareable {
   OK,
   ERROR
}
```

#### Notes

This subgraph assumes the presence of an x-user-id whose value is the userid.  If the header is not present than this is an anonymous request, and the return value if requested is null.
The subgraph should provide a hardcoded list of data for 2 users, with user_ids "user_1" and "user_2"
The resource_uris in the hard coded data set should correspond to the resource_uris generated in the sports-data subgraph.
By default the subgraph should not return any caching headers.
If a null or empty value is provided for the string argument of the mutation, then the subgraph should not return any caching headers.  Otherwise, the cahe header returned by the subgraph should be the value provided in this mutation.


### Marketplace Subgraph
```GraphQL
type Player @key(fields: "resourceUri", resolvable: false) {
  resourceUri: String!
}

type Team @key(fields: "resourceUri", resolvable: false) {
  resourceUri: String!
}

union Participant = Team | Player

type EventCard {
   homeParticipant: Participant
   awayParticipant: Participant
}

type Query {
  upcomingEvents: [EventCard!]!
}

type Mutation {
  updateMarketplaceCacheHeader: Result
}

enum Result @shareable {
   OK,
   ERROR
}
```

#### Notes

This subgraph should provide a hardcoded list of event cards.  The home and away participants on each event card should be of the same type.  the resource URI values should correpond to resource_uris that have been generated in the SportsData subgraph.
By default the subgraph should not return any caching headers.
If a null or empty value is provided for the string argument of the mutation, then the subgraph should not return any caching headers.  Otherwise, the cahe header returned by the subgraph should be the value provided in this mutation.



### Cache Viewer subGraph

```graphql
type CacheEntry {
  key: String!
  value: String
  ttl: String
}

type Query {
  getCacheEntries: [CacheEntry!]!
}

```

This subgraph should connect to the redis instance that has been setup for the Entity cache, and retrieve the full list of keys and values that are contained in the redis cache.




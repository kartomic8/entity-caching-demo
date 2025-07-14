FROM elixir:1.15 AS builder

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy mix files
COPY mix.exs mix.lock ./

# Install hex and rebar
RUN mix local.hex --force && mix local.rebar --force

# Set build ENV
ENV MIX_ENV=prod

# Install dependencies
RUN mix deps.get --only prod

# Copy source code
COPY . .

# Compile the project
RUN mix compile

# Build release
RUN mix release

FROM ubuntu:22.04

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    openssl \
    libncurses6 \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create app directory
WORKDIR /app

# Copy the release from builder stage
COPY --from=builder /app/_build/prod/rel/marketplace ./

# Set environment variables
ENV HOME=/app
ENV MIX_ENV=prod

# Expose port
EXPOSE 4000

# Start the application
CMD ["./bin/marketplace", "start"]

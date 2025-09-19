# wtf-bitnami-redis

A drop-in replacement for Bitnami Redis Docker images, specifically designed for GitHub service containers and CI/CD environments. This image wraps the official Redis image and provides password authentication through environment variables.

## Why this exists

Bitnami yanked their open source Redis images, and the official Redis image requires overriding the `CMD` to set a password or any options, which is not supported by GitHub service containers. This wrapper solves that problem by providing a clean way to set Redis passwords through environment variables.

## Features

- 🔐 Password authentication via `REDIS_PASSWORD` environment variable
- 🐳 Based on official Redis Alpine image for minimal size
- 🚀 Perfect for GitHub Actions service containers
- 🏗️ Multi-architecture support (amd64, arm64)
- ⚡ Automatic CI/CD builds and tagging

## Usage

### Docker

```bash
# Run Redis without password
docker run --rm -p 6379:6379 ghcr.io/nrfta/wtf-bitnami-redis:latest

# Run Redis with password
docker run --rm -p 6379:6379 -e REDIS_PASSWORD=mypassword ghcr.io/nrfta/wtf-bitnami-redis:latest
```

### GitHub Actions Service Container

```yaml
services:
  redis:
    image: ghcr.io/nrfta/wtf-bitnami-redis:latest
    env:
      REDIS_PASSWORD: testpassword
    ports:
      - 6379:6379
    options: --health-cmd "redis-cli ping" --health-interval 10s --health-timeout 5s --health-retries 5
```

### Docker Compose

```yaml
version: '3.8'
services:
  redis:
    image: ghcr.io/nrfta/wtf-bitnami-redis:latest
    environment:
      - REDIS_PASSWORD=mypassword
    ports:
      - "6379:6379"
```

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `REDIS_PASSWORD` | Password for Redis authentication | (none) |

## Available Tags

- `latest` - Latest build from main branch
- `7` - Redis version 7.x
- Specific version tags following Redis releases

## Connecting with Password

When `REDIS_PASSWORD` is set, you'll need to authenticate:

```bash
# Using redis-cli
redis-cli -a mypassword

# Using connection string
redis://default:mypassword@localhost:6379
```

## Building Locally

```bash
git clone https://github.com/nrfta/wtf-bitnami-redis.git
cd wtf-bitnami-redis
docker build -t wtf-bitnami-redis .

# Test without password
docker run --rm -p 6379:6379 wtf-bitnami-redis

# Test with password
docker run --rm -p 6379:6379 -e REDIS_PASSWORD=test wtf-bitnami-redis
```

## License

MIT License - see [LICENSE](LICENSE) file for details.

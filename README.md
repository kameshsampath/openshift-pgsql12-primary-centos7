# OpenShift PostgreSQL Primary

This project contains the PostgreSQL Primary image for OpenShift.

## Configuration

| Property | Default | Unit | Required | Description |
|----------|---------|------|----------|-------------|
| PG_DATABASE | | | Yes | The name of the database |
| PG_USER_NAME | | | Yes | The user name |
| PG_USER_PASSWORD | | | Yes | The password for the user |
| PG_NETWORK_MASK | | | Yes | The network mask for database access |
| PG_DATABASE_ENCODING | UTF8 | | | The encoding of the database |
| PG_MAX_CONNECTIONS | 100 | | | `max_connections` setting |
| PG_SHARED_BUFFERS | 256 | MB | | `shared_buffers` setting |
| PG_WORK_MEM | 1536 | kB | | `work_mem` setting |
| PG_EFFECTIVE_IO | 128 | | | `effective_io_concurrency` setting |
| PG_EFFECTIVE_CACHE_SIZE | 1 | GB | | `effective_cache_size` setting |
| PG_MAX_WAL_SIZE | 1 | GB | | `max_wal_size` setting |
| PG_PASSWORD_ENCRYPTION | md5 | | | `password_encryption` setting |

## Volumes

| Name | Description |
|------|-------------|
| `/pgdata` | PostgreSQL data directory |
| `/pgwal` | PostgreSQL Write-Ahead Log (WAL) |

The data of each of these volumes is located within their `data` directory.

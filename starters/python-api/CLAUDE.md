# [Project Name] — Python API

## Overview
[Brief description of what this API does]

## Tech Stack
- **Framework:** FastAPI 0.100+ (or Flask 3.0+)
- **Language:** Python 3.11+
- **Database:** PostgreSQL + SQLAlchemy 2.0 (async)
- **Auth:** JWT (python-jose) + OAuth2 password bearer
- **Validation:** Pydantic v2
- **Migrations:** Alembic
- **Testing:** pytest + pytest-asyncio
- **Deployment:** Docker + Railway/Render/Fly.io

## Key Commands
```bash
# Development
python -m uvicorn app.main:app --reload      # Start dev server (localhost:8000)
python -m pytest                             # Run tests
python -m pytest --cov=app tests/            # Run tests with coverage

# Database
alembic revision --autogenerate -m "msg"     # Create migration
alembic upgrade head                         # Apply migrations
alembic downgrade -1                         # Rollback last migration

# Code Quality
black .                                      # Format code
ruff check .                                 # Lint code
mypy app/                                    # Type check

# Dependencies
poetry install                               # Install dependencies
poetry add <package>                         # Add new dependency
poetry update                                # Update dependencies
```

## Project Structure
```
app/
  main.py               # FastAPI app instance and startup
  api/
    v1/
      routes/           # Route handlers (users.py, auth.py, posts.py)
      dependencies.py   # Shared dependencies (get_db, get_current_user)
  models/               # SQLAlchemy models
  schemas/              # Pydantic request/response models
  services/             # Business logic layer
  repositories/         # Database access layer
  core/
    config.py           # Settings (Pydantic BaseSettings)
    security.py         # Auth helpers (hash, verify, create token)
    database.py         # Database session management
tests/
  test_auth.py          # Auth tests
  test_users.py         # User endpoint tests
  conftest.py           # Pytest fixtures
alembic/
  versions/             # Migration files
  env.py                # Alembic config
```

## Key Files
- `app/main.py` — FastAPI app, CORS, exception handlers, startup/shutdown events
- `app/core/config.py` — Environment-based configuration
- `app/core/security.py` — JWT token creation/validation, password hashing
- `app/api/v1/dependencies.py` — Dependency injection (get_db, get_current_user)
- `alembic/env.py` — Alembic migration configuration
- `.env` — Environment variables (gitignored)

## Environment Variables
```bash
# App
DEBUG=true
SECRET_KEY=... # Generate with: openssl rand -hex 32
API_V1_PREFIX=/api/v1

# Database
DATABASE_URL=postgresql+asyncpg://user:pass@localhost:5432/dbname

# Auth
ACCESS_TOKEN_EXPIRE_MINUTES=30
REFRESH_TOKEN_EXPIRE_DAYS=7
ALGORITHM=HS256

# Redis (optional, for caching/rate limiting)
REDIS_URL=redis://localhost:6379

# External APIs
STRIPE_API_KEY=sk_test_...
SENDGRID_API_KEY=SG...
```

## Database Schema Notes
- `users` table: id, email, hashed_password, role (user/admin), is_active, created_at, updated_at
- Use UUIDs for primary keys for better security and distribution
- All timestamps in UTC
- Soft deletes: add `deleted_at` column instead of hard deletes
- Indexes on frequently queried columns (email, created_at, status)

## Authentication Flow
1. User POSTs to `/api/v1/auth/login` with email/password
2. API validates credentials, returns access token + refresh token
3. Client includes token in `Authorization: Bearer <token>` header
4. `get_current_user` dependency validates token and loads user
5. Route handler checks user.role for authorization

## API Routes
```
POST   /api/v1/auth/register       # Create new user
POST   /api/v1/auth/login          # Get access token
POST   /api/v1/auth/refresh        # Refresh access token
GET    /api/v1/auth/me             # Get current user (requires auth)

GET    /api/v1/users               # List users (admin only)
GET    /api/v1/users/{id}          # Get user by ID
PATCH  /api/v1/users/{id}          # Update user
DELETE /api/v1/users/{id}          # Delete user (admin only)

[Add your domain-specific routes here]
```

## Request/Response Examples
```python
# POST /api/v1/auth/login
{
  "email": "user@example.com",
  "password": "SecurePass123"
}
# Response 200:
{
  "access_token": "eyJ...",
  "refresh_token": "eyJ...",
  "token_type": "bearer"
}

# GET /api/v1/users?page=1&limit=10
# Response 200:
{
  "items": [
    {"id": 1, "email": "user@example.com", "role": "user"},
    ...
  ],
  "total": 42,
  "page": 1,
  "limit": 10
}
```

## Architectural Decisions
- Async everywhere: FastAPI async routes + SQLAlchemy async sessions for better concurrency
- Service layer separates business logic from HTTP concerns (testable, reusable)
- Repository pattern abstracts database access (easier to mock, swap DB)
- Pydantic models for API contracts enforce validation at API boundary
- JWT stateless auth for scalability (no session storage)

## Common Tasks
### Add a new endpoint
1. Define Pydantic schemas in `app/schemas/resource.py`
2. Create route handler in `app/api/v1/routes/resource.py`
3. Add business logic in `app/services/resource_service.py`
4. Register router in `app/main.py`

### Add a database model
1. Create model in `app/models/resource.py`
2. Run `alembic revision --autogenerate -m "Add resource table"`
3. Review migration, then `alembic upgrade head`
4. Update repository in `app/repositories/resource_repository.py`

### Add authentication to a route
```python
from app.api.v1.dependencies import get_current_user

@router.get("/protected")
async def protected_route(
    current_user: Annotated[User, Depends(get_current_user)]
):
    return {"user_id": current_user.id}
```

### Add admin-only authorization
```python
def get_current_admin(current_user: Annotated[User, Depends(get_current_user)]):
    if current_user.role != "admin":
        raise HTTPException(status_code=403, detail="Admin access required")
    return current_user

@router.delete("/users/{user_id}")
async def delete_user(
    user_id: int,
    admin: Annotated[User, Depends(get_current_admin)],
    db: AsyncSession = Depends(get_db)
):
    # Delete user logic
```

## Deployment
- Docker: Build image with `Dockerfile`, run with `docker-compose.yml`
- Run migrations on startup: `alembic upgrade head` in entrypoint script
- Set all environment variables in hosting platform
- Use Gunicorn or Uvicorn with multiple workers: `gunicorn app.main:app -w 4 -k uvicorn.workers.UvicornWorker`
- Health check endpoint: `GET /health` returns 200 if DB connection is alive

## Notes
- SQLAlchemy async sessions must be created per request (dependency injection handles this)
- Close database connections properly (use `finally` in dependency)
- JWT tokens are stateless — revocation requires blacklist (Redis) or short expiry
- Validate all inputs with Pydantic — FastAPI does this automatically
- Use `response_model` to exclude fields from responses (e.g., hashed_password)
- Background tasks run in same process — use Celery for true async jobs

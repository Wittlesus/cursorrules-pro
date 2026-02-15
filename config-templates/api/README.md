# API Project Configuration — REST / GraphQL / Microservices

This directory contains AI coding assistant configurations optimized for backend API development with clean architecture, comprehensive validation, and production-ready patterns.

## What's Included

| File | For | Description |
|------|-----|-------------|
| `.cursorrules` | Cursor IDE | Backend API development rules |
| `CLAUDE.md` | Claude Code CLI | Detailed project instructions for APIs |
| `.windsurfrules` | Windsurf IDE | Windsurf AI configuration |
| `.github/copilot-instructions.md` | GitHub Copilot | API-specific Copilot instructions |

## Installation

Same installation steps as other configs — copy the relevant file to your project root.

## What This Configuration Covers

### Architecture Patterns
- **Clean layered architecture** — Controllers, services, repositories
- **Dependency injection** — Testable, loosely coupled components
- **Repository pattern** — Abstract database operations
- **Middleware chain** — Auth, validation, logging, rate limiting

### API Best Practices
- Proper HTTP methods and status codes
- Consistent response format for success and errors
- Resource-based URL design
- Pagination for list endpoints
- API versioning (/api/v1/, /api/v2/)

### Security Standards
- JWT authentication with access/refresh tokens
- Password hashing (bcrypt/argon2)
- Input validation and sanitization
- SQL injection prevention
- Rate limiting
- CORS configuration
- Security headers

### Database Patterns
- ORM usage (Prisma, SQLAlchemy, Drizzle)
- Migration-driven schema changes
- Transaction handling
- N+1 query prevention
- Connection pooling

### Error Handling
- Custom error classes
- Centralized error handler
- Structured logging with context
- Client-safe error messages

## Supported Tech Stacks

This config works with multiple backend stacks:

### Python FastAPI
```python
# File structure
app/
  ├── main.py
  ├── routers/
  ├── services/
  ├── models/
  └── core/
```

### Node.js Express
```javascript
// File structure
src/
  ├── routes/
  ├── controllers/
  ├── services/
  ├── models/
  └── middleware/
```

### Node.js Nest.js
```typescript
// Module-based structure
src/
  ├── users/
  │   ├── users.controller.ts
  │   ├── users.service.ts
  │   └── users.module.ts
```

### Go Fiber/Gin
```go
// File structure
cmd/
  └── api/
internal/
  ├── handlers/
  ├── services/
  └── repository/
```

## Customization Guide

### Add Your Stack Specifics

```markdown
## Our Stack
- Language: TypeScript with Node.js 20
- Framework: Express 4.x
- Database: PostgreSQL 15 with Prisma
- Auth: JWT with refresh tokens
- Cache: Redis for sessions and rate limiting
- Queue: Bull for background jobs
- Monitoring: Sentry for errors, Datadog for metrics
```

### Add Your API Conventions

```markdown
## API Standards
- Base URL: /api/v1/
- Authentication: Bearer token in Authorization header
- Pagination: ?page=1&limit=20 (default 20, max 100)
- Date format: ISO 8601
- Error codes: Use our internal error code system (see docs/error-codes.md)
- Versioning: Breaking changes require new version (/api/v2/)
```

### Add Your Testing Requirements

```markdown
## Testing Requirements
- Minimum 80% code coverage
- All endpoints must have integration tests
- Services must have unit tests
- Use test database (not dev/prod)
- Run tests in CI before merge
- Mock external API calls with MSW
```

### Add Your Deployment Specifics

```markdown
## Deployment
- Container: Docker with multi-stage builds
- Orchestration: Kubernetes on AWS EKS
- Environment: dev, staging, production
- Health check: GET /health returns 200 with status
- Graceful shutdown: Handle SIGTERM, drain connections
- Logging: Structured JSON logs to stdout
```

## Language-Specific Patterns

### Python (FastAPI)
```python
# Dependency injection with FastAPI
async def get_current_user(
    token: Annotated[str, Depends(oauth2_scheme)],
    db: Annotated[AsyncSession, Depends(get_db)]
) -> User:
    # Verify token and fetch user
    pass

# Use in route
@router.get("/profile")
async def get_profile(
    current_user: Annotated[User, Depends(get_current_user)]
):
    return {"data": current_user}
```

### TypeScript (Express)
```typescript
// Dependency injection with classes
class UserController {
  constructor(private userService: UserService) {}

  async getUser(req: Request, res: Response) {
    const user = await this.userService.findById(req.params.id);
    res.json({ data: user });
  }
}

// Wire up dependencies
const userRepo = new UserRepository(db);
const userService = new UserService(userRepo);
const userController = new UserController(userService);
```

### Go (Standard)
```go
// Dependency injection with structs
type UserHandler struct {
    userService *UserService
}

func NewUserHandler(us *UserService) *UserHandler {
    return &UserHandler{userService: us}
}

func (h *UserHandler) GetUser(c *fiber.Ctx) error {
    id := c.Params("id")
    user, err := h.userService.FindByID(id)
    if err != nil {
        return c.Status(404).JSON(fiber.Map{
            "error": fiber.Map{"message": "User not found", "code": "NOT_FOUND"},
        })
    }
    return c.JSON(fiber.Map{"data": user})
}
```

## Response Format Examples

### Success (Single Resource)
```json
{
  "data": {
    "id": "123",
    "email": "user@example.com",
    "createdAt": "2024-01-15T10:30:00Z"
  }
}
```

### Success (Collection)
```json
{
  "data": [...],
  "meta": {
    "total": 100,
    "page": 1,
    "limit": 20,
    "totalPages": 5
  }
}
```

### Error (Validation)
```json
{
  "error": {
    "message": "Validation failed",
    "code": "VALIDATION_ERROR",
    "details": {
      "email": ["Must be a valid email"],
      "age": ["Must be at least 18"]
    }
  }
}
```

### Error (Not Found)
```json
{
  "error": {
    "message": "User not found",
    "code": "NOT_FOUND"
  }
}
```

## Common Issues

### AI Puts Logic in Controllers
Strengthen the layering rule:
```
CRITICAL: Controllers are THIN. They only:
1. Parse request (body, params, query)
2. Validate with schema
3. Call service method
4. Format response
NO business logic in controllers. Extract to services.
```

### AI Skips Validation
Emphasize validation requirement:
```
MANDATORY: Every endpoint MUST validate inputs.
- Body: validate with schema
- Params: validate types and format
- Query: validate with schema
No endpoint without validation middleware/decorator.
```

### AI Returns Inconsistent Errors
Define exact error format:
```
ALL error responses must match this exact format:
{
  "error": {
    "message": string,
    "code": string,
    "details"?: object
  }
}
Never return { error: "message" } or { message: "..." }
```

## Benefits Over Generic Configs

✅ **Architecture-first** — Clean separation of concerns
✅ **Security-hardened** — Validation, auth, rate limiting built-in
✅ **Production-ready** — Error handling, logging, graceful shutdown
✅ **Framework-agnostic** — Works with FastAPI, Express, Nest, Go, Rust
✅ **Test-focused** — Clear testing strategy and patterns

## Examples

See example implementations:
- Python FastAPI: `rules/python-fastapi/` in parent directory
- Node Express: `rules/node-express/` in parent directory
- Go examples: [Awesome Go](https://github.com/avelino/awesome-go)

## Support

For questions or issues:
1. Check the main README in the parent directory
2. Review framework-specific documentation
3. Open an issue at github.com/Wittlesus/cursorrules-pro

## License

Use in any personal or commercial project. Do not redistribute this configuration collection itself.

---

**Built for backend developers who want production-grade APIs from day one.**

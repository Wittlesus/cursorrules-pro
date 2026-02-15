# GitHub Copilot Instructions — Backend API

## Project Context
This is a production-grade REST API service using clean architecture: controllers, services, repositories, with comprehensive validation and error handling.

## Code Generation Rules

### Architecture Layers
```
Request → Controller → Service → Repository → Database
            ↓             ↓           ↓
         Validate    Business    Data Access
         HTTP        Logic       Queries
```

- **Controllers**: HTTP concerns only (parse request, call service, format response)
- **Services**: Business logic (framework-agnostic, testable)
- **Repositories**: Data access (abstract database operations)

### Consistent Response Format
```typescript
// Success
{ "data": T }                    // Single object
{ "data": T[], "meta": {...} }   // List with pagination

// Error
{
  "error": {
    "message": "Description",
    "code": "ERROR_CODE",
    "details": { "field": ["errors"] }  // For validation
  }
}
```

### HTTP Status Codes
- 200: OK (successful GET, PUT, PATCH, DELETE)
- 201: Created (successful POST)
- 204: No Content (successful DELETE with no response body)
- 400: Bad Request (malformed request)
- 401: Unauthorized (missing/invalid authentication)
- 403: Forbidden (authenticated but not authorized)
- 404: Not Found (resource doesn't exist)
- 422: Unprocessable Entity (validation failed)
- 500: Internal Server Error (unexpected errors)

### Input Validation Pattern
```typescript
// Always validate at controller layer
const schema = z.object({
  email: z.string().email(),
  age: z.number().int().min(18)
});

const parsed = schema.safeParse(req.body);
if (!parsed.success) {
  return res.status(422).json({
    error: {
      message: 'Validation failed',
      code: 'VALIDATION_ERROR',
      details: parsed.error.flatten()
    }
  });
}
```

### Authentication Pattern
```typescript
// Middleware authenticates and attaches user
async function authenticate(req, res, next) {
  const token = extractBearerToken(req);
  if (!token) return unauthorized(res);

  try {
    const user = await verifyAndFetchUser(token);
    req.user = user;
    next();
  } catch {
    return unauthorized(res);
  }
}

// Use in routes
router.get('/profile', authenticate, controller.getProfile);
```

### Error Handling
```typescript
// Custom error classes
class NotFoundError extends Error {
  code = 'NOT_FOUND';
  statusCode = 404;
}

// Global error handler (last middleware)
function errorHandler(err, req, res, next) {
  logger.error(err, { requestId: req.id });

  if (err.statusCode) {
    return res.status(err.statusCode).json({
      error: { message: err.message, code: err.code }
    });
  }

  res.status(500).json({
    error: { message: 'Internal error', code: 'INTERNAL_ERROR' }
  });
}
```

### Repository Pattern
```typescript
// Abstract data access behind interfaces
interface UserRepository {
  findById(id: string): Promise<User | null>;
  create(data: CreateUserData): Promise<User>;
}

// Services use repositories, not direct DB access
class UserService {
  constructor(private repo: UserRepository) {}

  async getUser(id: string) {
    const user = await this.repo.findById(id);
    if (!user) throw new NotFoundError('User');
    return user;
  }
}
```

### Database Queries
- Use ORM/query builder (Prisma, SQLAlchemy, Drizzle)
- Prevent N+1 with eager loading: `.include()`, `.prefetch_related()`
- Use transactions for multi-table operations
- Always use parameterized queries (prevent SQL injection)

### Async Patterns
- Use `async/await` for all I/O operations
- Use `Promise.all()` for concurrent independent operations
- Handle promise rejections explicitly
- Never block event loop with synchronous I/O

### Testing Approach
```typescript
// Unit test (service layer)
describe('UserService', () => {
  it('throws NotFoundError when user missing', async () => {
    const mockRepo = { findById: jest.fn().mockResolvedValue(null) };
    const service = new UserService(mockRepo);
    await expect(service.getUser('123')).rejects.toThrow(NotFoundError);
  });
});

// Integration test (endpoint)
describe('GET /api/v1/users/:id', () => {
  it('returns user data', async () => {
    const res = await request(app).get('/api/v1/users/1');
    expect(res.status).toBe(200);
    expect(res.body.data).toHaveProperty('id', '1');
  });
});
```

### Security Requirements
- Validate ALL inputs (body, params, query)
- Hash passwords with bcrypt/argon2
- Use JWT for authentication
- Implement rate limiting
- Set security headers (CORS, CSP)
- Never expose stack traces to clients
- Store secrets in environment variables

### Performance Best Practices
- Implement pagination (default 20, max 100)
- Use database indexes on frequently queried fields
- Cache frequently accessed data with Redis
- Use connection pooling
- Enable response compression

### Code Style
- Use dependency injection for testability
- Extract magic numbers to named constants
- Use meaningful variable names
- Keep functions small and single-purpose
- Add JSDoc/docstrings for exported functions

## Common Mistakes to Avoid
- ❌ Don't put business logic in controllers
- ❌ Don't skip input validation
- ❌ Don't use global mutable state
- ❌ Don't expose error details in production
- ❌ Don't use blocking I/O in async code
- ❌ Don't hardcode secrets
- ❌ Don't skip database migrations

## When Generating Code
1. Validate all inputs with schema validation
2. Return consistent response format
3. Use proper HTTP status codes
4. Implement layered architecture (controller → service → repository)
5. Handle errors with custom error classes
6. Add authentication/authorization middleware
7. Include comprehensive error handling
8. Write unit and integration tests

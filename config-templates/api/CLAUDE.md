# Backend API Project

## Overview
This is a production-grade backend API service built with modern patterns: clean architecture, dependency injection, comprehensive validation, and robust error handling.

## Tech Stack
**Language**: (specify: Python 3.11+, Node.js 20+, Go 1.22+, Rust)
**Framework**: (specify: FastAPI, Express, Nest.js, Fiber, Actix)
**Database**: (specify: PostgreSQL, MySQL, MongoDB)
**ORM**: (specify: Prisma, SQLAlchemy, Drizzle, GORM)
**Auth**: JWT with access/refresh tokens
**Validation**: (specify: Zod, Pydantic, Joi)
**Testing**: (specify: Pytest, Vitest, Go testing, Jest)

## Project Structure
```
src/
  ├── routes/          # HTTP route definitions
  ├── controllers/     # Request/response handlers
  ├── services/        # Business logic layer
  ├── models/          # Database models/schemas
  ├── middleware/      # Auth, logging, validation
  ├── repositories/    # Data access layer
  └── utils/          # Shared utilities
tests/
  ├── unit/           # Unit tests
  └── integration/    # API endpoint tests
```

## Key Commands
```bash
npm run dev          # Start dev server with hot reload
npm run build        # Build for production
npm run test         # Run all tests
npm run test:watch   # Watch mode for tests
npm run migrate      # Run database migrations
npm run db:studio    # Open database GUI
```

## Development Rules

### Layered Architecture
```
Routes → Controllers → Services → Repositories → Database
  ↓           ↓            ↓            ↓
Request    Validation   Business    Data Access
Response   Error Map     Logic       Queries
```

**Controllers** (thin layer):
- Parse request (body, params, query)
- Validate with schema
- Call service layer
- Format response
- Handle HTTP concerns only

**Services** (business logic):
- Framework-agnostic
- Implement domain rules
- Orchestrate repository calls
- Return domain objects or errors

**Repositories** (data access):
- Database operations only
- Abstract SQL/query details
- Return models/entities
- Handle transactions

### API Response Format
```typescript
// Success responses
{
  "data": T,                    // Single object
  "data": T[],                  // List
  "meta": {                     // Pagination metadata
    "total": 100,
    "page": 1,
    "limit": 20
  }
}

// Error responses
{
  "error": {
    "message": "Validation failed",
    "code": "VALIDATION_ERROR",
    "details": {
      "email": ["Must be valid email"],
      "age": ["Must be at least 18"]
    }
  }
}
```

### Authentication Pattern
```typescript
// Middleware authenticates and attaches user
async function authenticate(req, res, next) {
  const token = extractBearerToken(req);
  if (!token) return res.status(401).json({ error: { message: 'No token', code: 'UNAUTHORIZED' } });

  try {
    const payload = await verifyJWT(token);
    req.user = await userService.findById(payload.userId);
    next();
  } catch (err) {
    return res.status(401).json({ error: { message: 'Invalid token', code: 'UNAUTHORIZED' } });
  }
}

// Protected route uses middleware
router.get('/profile', authenticate, profileController.get);
```

### Validation Pattern
```typescript
// Define schema
const createUserSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  age: z.number().int().min(18)
});

// Validate in controller
async function createUser(req, res) {
  const parsed = createUserSchema.safeParse(req.body);
  if (!parsed.success) {
    return res.status(422).json({
      error: {
        message: 'Validation failed',
        code: 'VALIDATION_ERROR',
        details: parsed.error.flatten()
      }
    });
  }

  const user = await userService.create(parsed.data);
  return res.status(201).json({ data: user });
}
```

### Error Handling Pattern
```typescript
// Custom error classes
class AppError extends Error {
  constructor(message, code, statusCode = 500) {
    super(message);
    this.code = code;
    this.statusCode = statusCode;
  }
}

class NotFoundError extends AppError {
  constructor(resource) {
    super(`${resource} not found`, 'NOT_FOUND', 404);
  }
}

// Global error handler (last middleware)
function errorHandler(err, req, res, next) {
  logger.error(err, { requestId: req.id, userId: req.user?.id });

  if (err instanceof AppError) {
    return res.status(err.statusCode).json({
      error: { message: err.message, code: err.code }
    });
  }

  // Unknown error — don't leak details
  res.status(500).json({
    error: { message: 'Internal server error', code: 'INTERNAL_ERROR' }
  });
}
```

### Database Repository Pattern
```typescript
// Repository interface
interface UserRepository {
  findById(id: string): Promise<User | null>;
  findByEmail(email: string): Promise<User | null>;
  create(data: CreateUserData): Promise<User>;
  update(id: string, data: UpdateUserData): Promise<User>;
}

// Implementation with Prisma
class PrismaUserRepository implements UserRepository {
  constructor(private db: PrismaClient) {}

  async findById(id: string) {
    return this.db.user.findUnique({ where: { id } });
  }

  async create(data: CreateUserData) {
    return this.db.user.create({ data });
  }
}

// Service uses repository (not direct DB access)
class UserService {
  constructor(private userRepo: UserRepository) {}

  async getUser(id: string) {
    const user = await this.userRepo.findById(id);
    if (!user) throw new NotFoundError('User');
    return user;
  }
}
```

### Testing Strategy
```typescript
// Unit test (service layer)
describe('UserService', () => {
  it('should throw NotFoundError when user does not exist', async () => {
    const mockRepo = { findById: jest.fn().mockResolvedValue(null) };
    const service = new UserService(mockRepo);

    await expect(service.getUser('123')).rejects.toThrow(NotFoundError);
  });
});

// Integration test (API endpoint)
describe('POST /api/v1/users', () => {
  it('should create user with valid data', async () => {
    const res = await request(app)
      .post('/api/v1/users')
      .send({ email: 'test@example.com', password: 'securepass123', age: 25 });

    expect(res.status).toBe(201);
    expect(res.body.data).toHaveProperty('id');
    expect(res.body.data.email).toBe('test@example.com');
  });

  it('should return 422 for invalid email', async () => {
    const res = await request(app)
      .post('/api/v1/users')
      .send({ email: 'invalid', password: 'securepass123', age: 25 });

    expect(res.status).toBe(422);
    expect(res.body.error.code).toBe('VALIDATION_ERROR');
  });
});
```

## Environment Variables
```bash
NODE_ENV=development
PORT=3000
DATABASE_URL=postgresql://user:pass@localhost:5432/dbname
JWT_SECRET=your-secret-key-change-in-production
JWT_ACCESS_EXPIRY=15m
JWT_REFRESH_EXPIRY=7d
REDIS_URL=redis://localhost:6379
LOG_LEVEL=debug
CORS_ORIGIN=http://localhost:5173
```

## Database Migrations
```bash
npm run db:generate  # Generate migration from schema changes
npm run db:migrate   # Apply pending migrations
npm run db:reset     # Reset database (dev only)
npm run db:seed      # Seed initial data
```

## Performance Optimization

### Caching Strategy
- Cache frequently accessed, rarely changing data (user profiles, configs)
- Use Redis with TTL for cache entries
- Implement cache invalidation on updates
- Cache at service layer, not controller

### Query Optimization
- Use database indexes on frequently queried fields
- Implement N+1 prevention with eager loading
- Use select/projection to fetch only needed fields
- Paginate large result sets (default 20, max 100)

### Rate Limiting
```typescript
// Protect endpoints from abuse
const rateLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // 100 requests per window
  message: { error: { message: 'Too many requests', code: 'RATE_LIMIT_EXCEEDED' } }
});

app.use('/api/', rateLimiter);
```

## Security Checklist
- ✅ All inputs validated with schemas
- ✅ Passwords hashed with bcrypt/argon2
- ✅ SQL injection prevented (parameterized queries)
- ✅ CORS configured with explicit origins
- ✅ Rate limiting on public endpoints
- ✅ Security headers set (helmet middleware)
- ✅ Secrets in environment variables
- ✅ Error messages don't leak internals
- ✅ Request logging includes user context
- ✅ Database connections use SSL in production

## Logging Pattern
```typescript
// Structured logging with context
logger.info('User created', {
  requestId: req.id,
  userId: user.id,
  email: user.email,
  ip: req.ip
});

logger.error('Database query failed', {
  requestId: req.id,
  query: 'users.findById',
  error: err.message,
  stack: err.stack
});
```

## Key Reminders for AI Assistants
1. **Layer separation** — Controllers call services, services call repositories
2. **Validate everything** — No endpoint without input validation
3. **Consistent errors** — Always return { error: { message, code, details } }
4. **Repository pattern** — Abstract database behind interfaces
5. **Async properly** — Use async/await, handle rejections
6. **Test coverage** — Unit tests for services, integration for endpoints
7. **Security first** — Hash passwords, validate inputs, rate limit
8. **Log with context** — Include request ID, user ID, timestamps

## Deployment
```bash
npm run build        # Compile TypeScript/bundle code
npm run start        # Start production server
# Or use Docker for containerized deployment
docker build -t api-service .
docker run -p 3000:3000 --env-file .env api-service
```

## Troubleshooting
- **500 errors**: Check logs for stack traces, verify error handler is registered last
- **401 errors**: Verify JWT_SECRET matches, check token expiry
- **Database connection fails**: Check DATABASE_URL, verify DB is running
- **Slow queries**: Enable query logging, check for missing indexes, use EXPLAIN
- **Memory leaks**: Check for unclosed DB connections, unhandled promises

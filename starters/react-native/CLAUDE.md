# [Project Name] — React Native / Expo

## Overview
[Brief description of what this mobile app does]

## Tech Stack
- **Framework:** React Native + Expo (SDK 50+)
- **Language:** TypeScript
- **Navigation:** Expo Router (file-based routing)
- **State:** Zustand (global) + TanStack Query (server state)
- **Styling:** StyleSheet + design tokens
- **Build:** EAS Build
- **Deployment:** Expo Updates (OTA) + App Store / Play Store

## Key Commands
```bash
# Development
npx expo start                    # Start dev server with QR code
npx expo start --ios              # Start and open iOS simulator
npx expo start --android          # Start and open Android emulator
npx expo start --clear            # Start with cache cleared

# Building
eas build --profile development   # Build development version
eas build --profile preview       # Build preview for TestFlight/Internal Testing
eas build --profile production    # Build production for App Store/Play Store
eas update                        # Push OTA update to production

# Testing
npm test                          # Run Jest tests
npm run lint                      # Run ESLint
npm run type-check                # TypeScript type checking
```

## Project Structure
```
app/
  _layout.tsx           # Root layout (navigation stack)
  index.tsx             # Home screen
  (tabs)/               # Tab navigator group
    _layout.tsx         # Tab layout
    home.tsx            # Home tab
    profile.tsx         # Profile tab
  (auth)/               # Auth flow group
    login.tsx           # Login screen
    signup.tsx          # Signup screen
  posts/
    [id].tsx            # Dynamic route (post detail)
components/
  ui/                   # Reusable UI components (Button, Input, Card)
  screens/              # Screen-specific components
hooks/
  useAuth.ts            # Auth hook
  usePosts.ts           # Posts data hook (TanStack Query)
store/
  authStore.ts          # Zustand auth store
  settingsStore.ts      # Zustand settings store
lib/
  api.ts                # API client (axios instance)
  theme.ts              # Design tokens (colors, spacing, typography)
  utils.ts              # Utility functions
constants/
  queryKeys.ts          # TanStack Query keys
  config.ts             # App configuration
assets/
  images/               # Static images
  fonts/                # Custom fonts
```

## Key Files
- `app/_layout.tsx` — Root navigation setup and auth protection
- `lib/api.ts` — Axios instance with interceptors for auth tokens
- `lib/theme.ts` — Design tokens (colors, spacing, fonts)
- `store/authStore.ts` — Auth state (user, token, login, logout)
- `app.json` — Expo app configuration
- `eas.json` — EAS Build configuration

## Environment Variables
```bash
# In .env file (use expo-constants to access)
EXPO_PUBLIC_API_URL=https://api.example.com
EXPO_PUBLIC_STRIPE_KEY=pk_test_...
EXPO_PUBLIC_SENTRY_DSN=https://...
```

Access in code:
```typescript
import Constants from 'expo-constants';
const API_URL = Constants.expoConfig?.extra?.apiUrl;
```

## Navigation Structure
```
Root Stack
├─ (auth) — Auth flow (login, signup)
│  ├─ login
│  └─ signup
└─ (tabs) — Main app (protected)
   ├─ home
   ├─ search
   ├─ notifications
   └─ profile
      └─ settings (nested)
```

Auth guard in `app/_layout.tsx`:
```typescript
if (!user && !isAuthRoute) {
  return <Redirect href="/login" />;
}
```

## State Management
- **Auth state:** Zustand store (`authStore.ts`) with SecureStore persistence
- **Server data:** TanStack Query for API caching and refetching
- **Local UI state:** useState/useReducer in components
- **Form state:** react-hook-form

## API Integration
All API calls go through `lib/api.ts`:
```typescript
import api from '@/lib/api';

// GET request
const { data } = await api.get('/posts');

// POST request with auth
const { data } = await api.post('/posts', { title, content });
```

Auth token automatically added via axios interceptor:
```typescript
api.interceptors.request.use((config) => {
  const token = authStore.getState().token;
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});
```

## Authentication Flow
1. User enters credentials on `/login` screen
2. App POSTs to API `/auth/login`, receives token + user data
3. Token stored in SecureStore (encrypted), user data in Zustand
4. User redirected to `/home` (tabs)
5. All API requests include token in Authorization header
6. On logout, clear token and user data, redirect to `/login`

## Data Fetching with TanStack Query
```typescript
import { useQuery, useMutation } from '@tanstack/react-query';

// Fetch posts
const { data: posts, isLoading, error } = useQuery({
  queryKey: ['posts'],
  queryFn: () => api.get('/posts').then(res => res.data),
});

// Create post
const createPost = useMutation({
  mutationFn: (data) => api.post('/posts', data),
  onSuccess: () => queryClient.invalidateQueries(['posts']),
});
```

## Styling Conventions
Use StyleSheet.create() at bottom of file:
```typescript
const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: theme.spacing.md,
    backgroundColor: theme.colors.background,
  },
});
```

Use theme tokens for consistency:
```typescript
// lib/theme.ts
export const theme = {
  colors: {
    primary: '#007AFF',
    background: '#FFFFFF',
    text: '#000000',
  },
  spacing: {
    xs: 4, sm: 8, md: 16, lg: 24, xl: 32,
  },
  typography: {
    heading: { fontSize: 24, fontWeight: 'bold' },
    body: { fontSize: 16, lineHeight: 24 },
  },
};
```

## Platform-Specific Behavior
- **Safe areas:** Use `<SafeAreaView>` from `react-native-safe-area-context`
- **Keyboard:** Use `<KeyboardAvoidingView behavior={Platform.OS === 'ios' ? 'padding' : 'height'}>`
- **Styles:** Use `Platform.select({ ios: 10, android: 12 })` for small differences
- **Files:** Create `.ios.tsx` and `.android.tsx` for major differences

## Permissions
Request permissions before using:
```typescript
import * as Location from 'expo-location';

const { status } = await Location.requestForegroundPermissionsAsync();
if (status !== 'granted') {
  // Show explanation, link to settings
}
```

Common permissions:
- Camera: `expo-camera`
- Location: `expo-location`
- Notifications: `expo-notifications`
- Media Library: `expo-media-library`

## Push Notifications
1. Request permission: `Notifications.requestPermissionsAsync()`
2. Get push token: `Notifications.getExpoPushTokenAsync()`
3. Send token to backend for storage
4. Handle notifications:
   - Foreground: `Notifications.addNotificationReceivedListener()`
   - Tap: `Notifications.addNotificationResponseReceivedListener()`

## Build Profiles (eas.json)
- **development:** Debug build for local testing
- **preview:** Release build for TestFlight/Internal Testing
- **production:** Release build for App Store/Play Store

## Deployment Checklist
- [ ] Increment version in `app.json`
- [ ] Update `ios.buildNumber` and `android.versionCode`
- [ ] Test on physical devices (iOS + Android)
- [ ] Build with `eas build --profile production`
- [ ] Submit to TestFlight/Internal Testing
- [ ] Test beta build thoroughly
- [ ] Submit to App Store/Play Store

## Common Tasks
### Add a new screen
1. Create `app/new-screen.tsx`
2. Add link in navigation: `<Link href="/new-screen">Go</Link>`

### Add a new API endpoint
1. Add query key in `constants/queryKeys.ts`
2. Create hook in `hooks/useResource.ts` with TanStack Query
3. Use hook in screen component

### Add platform-specific code
```typescript
import { Platform } from 'react-native';

const height = Platform.select({
  ios: 50,
  android: 60,
  default: 55,
});
```

## Notes
- Expo Go app is for development only (limited native modules)
- Use Expo Development Builds for custom native code
- EAS Update only works for JS/assets, not native code changes
- Test on physical devices for camera, location, notifications
- iOS requires Info.plist permission descriptions
- Android requires AndroidManifest.xml permissions

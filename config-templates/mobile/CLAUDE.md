# React Native / Expo Mobile App Project

## Overview
This is a cross-platform mobile application built with React Native and Expo, targeting both iOS and Android with a single codebase.

## Tech Stack
- **Framework**: React Native with Expo SDK
- **Language**: TypeScript (strict mode)
- **Navigation**: Expo Router (file-based)
- **State**: Zustand (global), TanStack Query (server state)
- **Styling**: StyleSheet API
- **Testing**: Jest, React Native Testing Library, Detox/Maestro

## Project Structure
```
app/
  ├── (tabs)/         # Tab navigation
  ├── (auth)/         # Auth screens
  └── _layout.tsx     # Root layout
features/
  ├── auth/          # Auth feature (components, hooks, api)
  ├── profile/       # Profile feature
  └── home/          # Home feature
shared/
  ├── components/    # Shared UI components
  ├── hooks/         # Custom hooks
  ├── utils/         # Utility functions
  └── api/          # API client
```

## Key Commands
```bash
npx expo start              # Start dev server
npx expo start --ios        # Open iOS simulator
npx expo start --android    # Open Android emulator
npx expo prebuild           # Generate native projects
npm test                    # Run Jest tests
npm run lint                # Lint code
npm run type-check          # TypeScript check
```

## Development Rules

### Expo Router Navigation
- File-based routing in `app/` directory
- Use typed navigation:
  ```typescript
  import { router } from 'expo-router';
  router.push('/profile/123');
  ```
- Access params with `useLocalSearchParams<{ id: string }>()`
- Define layouts with `_layout.tsx` files

### Platform-Specific Code
```typescript
// Inline platform check
<View style={{
  paddingTop: Platform.OS === 'ios' ? 20 : 0
}} />

// Platform.select
const styles = StyleSheet.create({
  container: {
    ...Platform.select({
      ios: { shadowColor: '#000' },
      android: { elevation: 4 }
    })
  }
});

// Platform-specific files
// Button.ios.tsx
// Button.android.tsx
```

### List Rendering
```typescript
// ✅ Use FlatList for lists
<FlatList
  data={items}
  renderItem={({ item }) => <ItemComponent item={item} />}
  keyExtractor={item => item.id}
  onEndReached={loadMore}
  onEndReachedThreshold={0.5}
/>

// ❌ Don't use ScrollView + map
<ScrollView>
  {items.map(item => <ItemComponent key={item.id} item={item} />)}
</ScrollView>
```

### Performance Optimization
```typescript
// Memoize list items
const ItemComponent = React.memo<{ item: Item }>(({ item }) => {
  return <View>...</View>;
});

// Use useCallback for event handlers
const handlePress = useCallback(() => {
  navigation.navigate('Details');
}, [navigation]);

// Use useMemo for expensive computations
const sortedItems = useMemo(() => {
  return items.sort((a, b) => a.date - b.date);
}, [items]);
```

### State Management Pattern
```typescript
// Global state with Zustand
import { create } from 'zustand';

interface AuthState {
  user: User | null;
  setUser: (user: User | null) => void;
}

export const useAuthStore = create<AuthState>((set) => ({
  user: null,
  setUser: (user) => set({ user })
}));

// Server state with React Query
import { useQuery } from '@tanstack/react-query';

function useUserProfile(userId: string) {
  return useQuery({
    queryKey: ['user', userId],
    queryFn: () => api.getUser(userId),
    staleTime: 5 * 60 * 1000 // 5 minutes
  });
}
```

### Styling Best Practices
```typescript
// ✅ StyleSheet.create (optimized)
const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: '#fff'
  }
});

// ❌ Inline styles (poor performance)
<View style={{ flex: 1, padding: 16 }} />

// ✅ Responsive with useWindowDimensions
const { width, height } = useWindowDimensions();
const isLargeScreen = width > 768;
```

### Safe Area Handling
```typescript
import { SafeAreaView } from 'react-native-safe-area-context';

function Screen() {
  return (
    <SafeAreaView style={styles.container} edges={['top', 'bottom']}>
      {/* Content */}
    </SafeAreaView>
  );
}
```

### Native Module Usage
```typescript
// Camera with permissions
import { Camera } from 'expo-camera';

async function requestCameraPermission() {
  const { status } = await Camera.requestCameraPermissionsAsync();
  if (status !== 'granted') {
    Alert.alert('Permission denied');
    return false;
  }
  return true;
}

// Location
import * as Location from 'expo-location';

async function getCurrentLocation() {
  const { status } = await Location.requestForegroundPermissionsAsync();
  if (status !== 'granted') return null;

  const location = await Location.getCurrentPositionAsync({});
  return location;
}

// Secure storage for tokens
import * as SecureStore from 'expo-secure-store';

await SecureStore.setItemAsync('authToken', token);
const token = await SecureStore.getItemAsync('authToken');
```

### Error Handling
```typescript
// Error boundary
import { ErrorBoundary } from 'react-error-boundary';

function App() {
  return (
    <ErrorBoundary fallback={<ErrorScreen />}>
      <AppContent />
    </ErrorBoundary>
  );
}

// Network error handling
const { data, error, refetch } = useQuery({
  queryKey: ['data'],
  queryFn: fetchData,
  retry: 3,
  retryDelay: 1000
});

if (error) {
  return (
    <View>
      <Text>Failed to load data</Text>
      <Button onPress={() => refetch()} title="Retry" />
    </View>
  );
}
```

### Keyboard Handling
```typescript
import { KeyboardAvoidingView, Platform } from 'react-native';

function LoginScreen() {
  return (
    <KeyboardAvoidingView
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      style={styles.container}
    >
      <TextInput placeholder="Email" />
      <TextInput placeholder="Password" secureTextEntry />
    </KeyboardAvoidingView>
  );
}
```

## Environment Variables
Create `.env` (use expo-constants):
```bash
EXPO_PUBLIC_API_URL=https://api.example.com
EXPO_PUBLIC_SENTRY_DSN=your-sentry-dsn
```

Access in code:
```typescript
import Constants from 'expo-constants';

const API_URL = Constants.expoConfig?.extra?.apiUrl;
```

## Testing Strategy

### Unit Tests
```typescript
import { render, screen, fireEvent } from '@testing-library/react-native';

describe('LoginButton', () => {
  it('calls onPress when tapped', () => {
    const onPress = jest.fn();
    render(<LoginButton onPress={onPress} />);

    fireEvent.press(screen.getByText('Login'));
    expect(onPress).toHaveBeenCalled();
  });
});
```

### Hook Tests
```typescript
import { renderHook, act } from '@testing-library/react-hooks';

describe('useCounter', () => {
  it('increments counter', () => {
    const { result } = renderHook(() => useCounter());

    act(() => {
      result.current.increment();
    });

    expect(result.current.count).toBe(1);
  });
});
```

### E2E Tests (Maestro)
```yaml
# flow.yaml
appId: com.yourapp
---
- launchApp
- tapOn: "Login"
- inputText: "user@example.com"
- tapOn: "Submit"
- assertVisible: "Welcome"
```

## Build & Deploy

### Development Builds
```bash
eas build --profile development --platform ios
eas build --profile development --platform android
```

### Production Builds
```bash
eas build --profile production --platform all
```

### OTA Updates
```bash
eas update --branch production --message "Bug fixes"
```

## Performance Checklist
- ✅ Use FlatList for long lists (not ScrollView + map)
- ✅ Memoize list item components with React.memo
- ✅ Use useCallback for event handlers in lists
- ✅ Optimize images (WebP, proper dimensions)
- ✅ Use expo-image instead of Image component
- ✅ Minimize bridge crossings (batch state updates)
- ✅ Profile with React DevTools / Flipper before optimizing

## Security Checklist
- ✅ Use expo-secure-store for tokens/credentials
- ✅ Validate all API responses with Zod
- ✅ Request permissions before accessing device APIs
- ✅ Use SSL pinning for sensitive apps
- ✅ Obfuscate sensitive data in production builds
- ✅ Implement biometric auth for sensitive operations

## Common Issues

### App Crashes on Launch
- Check for unhandled promise rejections
- Verify all native modules are properly linked
- Test on physical device (simulator may hide issues)

### Slow List Performance
- Use FlatList instead of ScrollView
- Memoize list item components
- Reduce item complexity (remove shadows, gradients)
- Use getItemLayout for fixed-height items

### Keyboard Covers Input
- Use KeyboardAvoidingView with proper behavior
- Or use react-native-keyboard-aware-scroll-view
- Test on both iOS and Android

### White Screen / No Errors
- Check for errors in Metro bundler console
- Verify expo-splash-screen is configured correctly
- Add error boundary to catch rendering errors

## Key Reminders for AI Assistants
1. **FlatList for lists** — Never ScrollView + map for >10 items
2. **Platform testing** — Always consider iOS and Android differences
3. **Expo modules first** — Prefer expo- packages over community packages
4. **Secure storage** — Use expo-secure-store for sensitive data
5. **Permission handling** — Always request before accessing device APIs
6. **Performance** — Memoize list items, use useCallback
7. **Safe areas** — Use SafeAreaView from react-native-safe-area-context
8. **Navigation** — Use Expo Router file-based routing

## Deployment
```bash
# Build for app stores
eas build --platform all --profile production

# Submit to stores
eas submit --platform ios
eas submit --platform android

# Over-the-air updates (minor changes)
eas update --branch production
```

## Troubleshooting
- **Metro bundler errors**: Clear cache with `npx expo start -c`
- **Native module errors**: Run `npx expo prebuild --clean`
- **iOS build fails**: Check Xcode version compatibility
- **Android build fails**: Verify Android SDK and Java versions

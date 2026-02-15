# Mobile Project Configuration — React Native / Expo

This directory contains AI coding assistant configurations optimized for cross-platform mobile development with React Native and Expo.

## What's Included

| File | For | Description |
|------|-----|-------------|
| `.cursorrules` | Cursor IDE | Mobile development rules |
| `CLAUDE.md` | Claude Code CLI | Comprehensive mobile project instructions |
| `.windsurfrules` | Windsurf IDE | Windsurf AI configuration |
| `.github/copilot-instructions.md` | GitHub Copilot | Mobile-specific Copilot instructions |

## Installation

Copy the relevant file to your project root. Each AI tool will automatically detect and use its configuration file.

## What This Configuration Covers

### Cross-Platform Development
- **iOS and Android** — Platform-specific code patterns
- **Expo Router** — File-based navigation
- **Platform APIs** — Camera, location, notifications, secure storage
- **Responsive design** — Adapting to different screen sizes

### Performance Optimization
- FlatList for efficient list rendering
- React.memo for component memoization
- useCallback/useMemo for optimization
- Image optimization with expo-image
- Minimizing bridge crossings

### State Management
- Local state with useState/useReducer
- Global state with Zustand
- Server state with React Query
- Persistent state with expo-secure-store

### Native Features
- Permission handling for device APIs
- Push notifications
- Camera and image picker
- Location services
- Secure credential storage
- App state management

## Key Patterns

### List Rendering (Critical for Performance)
```typescript
// ✅ ALWAYS use FlatList for lists
<FlatList
  data={items}
  renderItem={({ item }) => <ItemRow item={item} />}
  keyExtractor={item => item.id}
/>

// Memoize list items
const ItemRow = React.memo<{ item: Item }>(({ item }) => {
  return <View><Text>{item.name}</Text></View>;
});

// ❌ NEVER use ScrollView + map for long lists
<ScrollView>
  {items.map(item => <ItemRow key={item.id} item={item} />)}
</ScrollView>
```

### Platform-Specific Code
```typescript
// Method 1: Inline
const padding = Platform.OS === 'ios' ? 20 : 10;

// Method 2: Platform.select
const styles = StyleSheet.create({
  shadow: Platform.select({
    ios: { shadowColor: '#000', shadowOpacity: 0.2 },
    android: { elevation: 4 }
  })
});

// Method 3: Separate files
// Button.ios.tsx
// Button.android.tsx
```

### Safe Area Handling
```typescript
// ✅ Use from react-native-safe-area-context
import { SafeAreaView } from 'react-native-safe-area-context';

<SafeAreaView edges={['top', 'bottom']}>
  {/* Content */}
</SafeAreaView>

// ❌ Don't use from react-native (deprecated)
```

### Secure Storage
```typescript
// ✅ For sensitive data (tokens, credentials)
import * as SecureStore from 'expo-secure-store';

await SecureStore.setItemAsync('authToken', token);
const token = await SecureStore.getItemAsync('authToken');

// ✅ For non-sensitive data
import AsyncStorage from '@react-native-async-storage/async-storage';

await AsyncStorage.setItem('theme', 'dark');
```

## Customization Guide

### Add Your Project Specifics

```markdown
## Our App
- Name: MyApp
- Bundle ID: com.company.myapp
- Minimum iOS: 14.0
- Minimum Android: API 24 (Android 7.0)
- Expo SDK: 52
- Target devices: Phone and Tablet
```

### Add Your Navigation Structure

```markdown
## Navigation
- Root: Tab navigator (Home, Search, Profile)
- Auth: Stack navigator (Login, Signup, ForgotPassword)
- Deep linking: myapp://profile/:id
- Protected routes: Redirect to /login if not authenticated
```

### Add Your State Management

```markdown
## State Management
- Auth state: Zustand store in shared/stores/auth.ts
- API data: React Query with 5min stale time
- Theme: Context API in shared/contexts/theme.tsx
- Form state: react-hook-form with Zod validation
```

### Add Your API Integration

```markdown
## API
- Base URL: process.env.EXPO_PUBLIC_API_URL
- Auth: JWT Bearer token in Authorization header
- Error handling: Show toast for API errors
- Retry: 3 attempts with exponential backoff
- Timeout: 30 seconds
```

## Platform-Specific Considerations

### iOS
- Use shadowColor, shadowOpacity, shadowRadius for shadows
- Request permissions with descriptive messages in app.json
- Test on different iPhone sizes (SE, Pro, Pro Max)
- Handle safe area insets (notch, home indicator)

### Android
- Use elevation for shadows
- Request permissions at runtime
- Test on different Android versions (7+)
- Handle different screen densities

## Common Issues

### FlatList Performance Issues
```markdown
Solution:
1. Memoize item components with React.memo
2. Use getItemLayout for fixed-height items
3. Reduce complexity of item components
4. Use windowSize prop to control rendered items
```

### Keyboard Covering Input
```markdown
Solution:
Use KeyboardAvoidingView:
<KeyboardAvoidingView
  behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
  style={{ flex: 1 }}
>
```

### App Crashes on Physical Device
```markdown
Solution:
1. Check for unhandled promise rejections
2. Verify all native modules are compatible with Expo
3. Test on Expo Go vs development build
4. Add error boundaries to catch rendering errors
```

### Image Loading Slowly
```markdown
Solution:
1. Use expo-image instead of Image
2. Specify image dimensions
3. Use appropriate contentFit (cover, contain)
4. Enable cachePolicy="memory-disk"
5. Optimize image sizes on backend
```

## Testing Strategy

### Unit Tests (Jest + RTL)
```typescript
test('renders correctly', () => {
  const { getByText } = render(<MyComponent />);
  expect(getByText('Hello')).toBeTruthy();
});
```

### E2E Tests (Maestro)
```yaml
appId: com.myapp
---
- launchApp
- tapOn: "Login"
- inputText: "user@example.com"
- tapOn: "Submit"
- assertVisible: "Welcome"
```

## Build & Deploy Checklist

### Before Building
- ✅ Update app version in app.json
- ✅ Test on both iOS and Android
- ✅ Test on physical devices
- ✅ Verify all environment variables
- ✅ Run type check and linter
- ✅ Update app store screenshots

### Build Commands
```bash
# Development builds (for testing)
eas build --profile development --platform all

# Production builds (for stores)
eas build --profile production --platform all

# Submit to stores
eas submit --platform ios
eas submit --platform android
```

## Benefits Over Generic Configs

✅ **Platform-aware** — Handles iOS/Android differences automatically
✅ **Performance-focused** — FlatList, memoization, optimization patterns
✅ **Expo-specific** — Uses Expo modules, Expo Router, EAS
✅ **Security-conscious** — Secure storage, permission handling
✅ **Production-ready** — Error boundaries, crash reporting, testing

## Examples

See example Expo apps:
- [Expo Examples](https://github.com/expo/examples)
- [React Native Directory](https://reactnative.directory/)
- [Expo Snacks](https://snack.expo.dev/)

## Support

For questions or issues:
1. Check Expo documentation: https://docs.expo.dev
2. Review React Native docs: https://reactnative.dev
3. Open an issue at github.com/Wittlesus/cursorrules-pro

## License

Use in any personal or commercial project. Do not redistribute this configuration collection itself.

---

**Built for mobile developers who want performant, production-ready apps on iOS and Android.**

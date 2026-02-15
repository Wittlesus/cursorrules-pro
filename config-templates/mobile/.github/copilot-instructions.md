# GitHub Copilot Instructions — React Native / Expo Mobile

## Project Context
This is a cross-platform mobile app built with React Native and Expo, targeting both iOS and Android with TypeScript.

## Code Generation Rules

### Component Structure
```typescript
// Functional component with TypeScript
interface Props {
  title: string;
  onPress: () => void;
}

export function CustomButton({ title, onPress }: Props) {
  return (
    <Pressable onPress={onPress} style={styles.button}>
      <Text style={styles.text}>{title}</Text>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  button: {
    padding: 16,
    backgroundColor: '#007AFF'
  },
  text: {
    color: '#fff',
    fontSize: 16
  }
});
```

### List Rendering
```typescript
// ✅ Use FlatList for lists
<FlatList
  data={items}
  renderItem={({ item }) => <ItemRow item={item} />}
  keyExtractor={item => item.id}
  onEndReached={loadMore}
/>

// Memoize list items
const ItemRow = React.memo<{ item: Item }>(({ item }) => {
  return <View>...</View>;
});

// ❌ Never use ScrollView + map for long lists
```

### Navigation with Expo Router
```typescript
import { router, useLocalSearchParams } from 'expo-router';

// Navigate
router.push('/profile/123');
router.replace('/login');
router.back();

// Get params
const { id } = useLocalSearchParams<{ id: string }>();
```

### State Management
```typescript
// Local state
const [count, setCount] = useState(0);

// Global state (Zustand)
import { create } from 'zustand';

const useStore = create<State>((set) => ({
  user: null,
  setUser: (user) => set({ user })
}));

// Server state (React Query)
import { useQuery } from '@tanstack/react-query';

const { data, isLoading } = useQuery({
  queryKey: ['user', id],
  queryFn: () => fetchUser(id)
});
```

### Platform-Specific Code
```typescript
// Inline
const padding = Platform.OS === 'ios' ? 20 : 10;

// Platform.select
const styles = StyleSheet.create({
  container: {
    ...Platform.select({
      ios: { shadowColor: '#000', shadowOpacity: 0.2 },
      android: { elevation: 4 }
    })
  }
});

// Separate files
// Button.ios.tsx
// Button.android.tsx
```

### Performance Optimization
```typescript
// useCallback for event handlers
const handlePress = useCallback(() => {
  navigation.navigate('Details');
}, [navigation]);

// useMemo for computed values
const sortedItems = useMemo(() => {
  return items.sort((a, b) => a.date - b.date);
}, [items]);

// React.memo for components
const ExpensiveComponent = React.memo<Props>(({ data }) => {
  return <View>...</View>;
});
```

### Native Modules & Permissions
```typescript
// Camera
import { Camera } from 'expo-camera';

const [permission, requestPermission] = Camera.useCameraPermissions();

if (!permission?.granted) {
  await requestPermission();
}

// Location
import * as Location from 'expo-location';

const { status } = await Location.requestForegroundPermissionsAsync();
const location = await Location.getCurrentPositionAsync();

// Secure storage
import * as SecureStore from 'expo-secure-store';

await SecureStore.setItemAsync('token', authToken);
const token = await SecureStore.getItemAsync('token');
```

### Styling Best Practices
```typescript
// ✅ Use StyleSheet.create
const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16
  }
});

// ✅ Responsive with useWindowDimensions
const { width } = useWindowDimensions();
const isTablet = width > 768;

// ✅ Safe areas
import { SafeAreaView } from 'react-native-safe-area-context';

<SafeAreaView edges={['top']} style={styles.container}>
  {/* Content */}
</SafeAreaView>
```

### Keyboard Handling
```typescript
import { KeyboardAvoidingView, Platform } from 'react-native';

<KeyboardAvoidingView
  behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
  style={styles.container}
>
  <TextInput placeholder="Email" />
</KeyboardAvoidingView>
```

### Error Handling
```typescript
// Error boundary
import { ErrorBoundary } from 'react-error-boundary';

<ErrorBoundary fallback={<ErrorScreen />}>
  <App />
</ErrorBoundary>

// Network error with retry
const { data, error, refetch } = useQuery(...);

if (error) {
  return (
    <View>
      <Text>Failed to load</Text>
      <Button onPress={() => refetch()} title="Retry" />
    </View>
  );
}
```

### Image Optimization
```typescript
// ✅ Use expo-image
import { Image } from 'expo-image';

<Image
  source={{ uri: 'https://...' }}
  style={{ width: 200, height: 200 }}
  contentFit="cover"
  cachePolicy="memory-disk"
/>

// ❌ Don't use react-native Image for new code
```

### Testing
```typescript
// Component test
import { render, fireEvent } from '@testing-library/react-native';

test('button calls onPress', () => {
  const onPress = jest.fn();
  const { getByText } = render(<Button onPress={onPress} title="Click" />);

  fireEvent.press(getByText('Click'));
  expect(onPress).toHaveBeenCalled();
});

// Hook test
import { renderHook, act } from '@testing-library/react-hooks';

test('useCounter increments', () => {
  const { result } = renderHook(() => useCounter());

  act(() => result.current.increment());
  expect(result.current.count).toBe(1);
});
```

## Common Mistakes to Avoid
- ❌ Don't use ScrollView for lists >10 items — use FlatList
- ❌ Don't hardcode dimensions — use flex or useWindowDimensions
- ❌ Don't store tokens in AsyncStorage — use expo-secure-store
- ❌ Don't skip permission requests before accessing device APIs
- ❌ Don't use inline styles — use StyleSheet.create
- ❌ Don't forget KeyboardAvoidingView on forms
- ❌ Don't use console.log in production
- ❌ Don't assume iOS/Android behave the same — test both

## When Generating Code
1. Use TypeScript with proper prop types
2. Use FlatList for any list rendering
3. Request permissions before accessing device APIs
4. Use StyleSheet.create for all styles
5. Consider platform differences (iOS vs Android)
6. Memoize list items with React.memo
7. Use useCallback for event handlers in lists
8. Handle loading and error states for data fetching
9. Use expo-secure-store for sensitive data
10. Use SafeAreaView for safe area handling

## File Naming
- Components: PascalCase (UserProfile.tsx)
- Hooks: camelCase with "use" prefix (useAuth.ts)
- Utils: camelCase (formatDate.ts)
- Platform-specific: Button.ios.tsx, Button.android.tsx
- Expo Router: +page.tsx, +layout.tsx, [id].tsx

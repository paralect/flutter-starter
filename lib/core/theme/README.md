# Theme Structure for shadcn_flutter

## Overview

This theme system is built on top of `shadcn_flutter` and provides a clean, maintainable structure for managing app theming. It replaces the previous Mix-based theming system.

## Directory Structure

```bash
lib/core/theme/
├── README.md                    # This file - documentation
├── providers/
│   ├── theme_provider.dart     # Riverpod providers for theme state
│   └── theme_provider.g.dart   # Generated code
├── themes/
│   ├── app_theme.dart          # Main theme configuration (ShadThemeData)
│   ├── color_schemes.dart      # Custom color schemes (light/dark)
│   └── typography.dart          # Typography definitions
├── tokens/
│   ├── colors.dart             # Color constants (without Mix)
│   ├── spacing.dart            # Spacing constants
│   ├── radius.dart             # Border radius constants
│   └── typography_tokens.dart  # Typography token definitions
└── extensions/
    ├── theme_extensions.dart    # Extensions for accessing theme values
    └── color_extensions.dart    # Extensions for color utilities
```

## Component Descriptions

### 1. `themes/app_theme.dart`

**Purpose**: Main theme configuration file that creates `ShadThemeData` instances.

**Structure**:

- `AppTheme.light` - Returns `ShadThemeData` for light mode
- `AppTheme.dark` - Returns `ShadThemeData` for dark mode
- Uses `ShadColorScheme` from shadcn_flutter
- Configures typography, spacing, radius through theme extensions

**Example**:

```dart
class AppTheme {
  static ShadThemeData light(BuildContext context) {
    return ShadThemeData(
      brightness: Brightness.light,
      colorScheme: AppColorSchemes.light,
      // ... other theme properties
    );
  }
  
  static ShadThemeData dark(BuildContext context) {
    return ShadThemeData(
      brightness: Brightness.dark,
      colorScheme: AppColorSchemes.dark,
      // ... other theme properties
    );
  }
}
```

### 2. `themes/color_schemes.dart`

**Purpose**: Defines custom color schemes based on shadcn/ui design tokens.

**Structure**:

- `AppColorSchemes.light` - Light color scheme
- `AppColorSchemes.dark` - Dark color scheme
- Uses `ShadColorScheme` with custom colors
- Maps current app colors to shadcn color system

**Color Mapping**:

- `primary` → shadcn primary color
- `secondary` → shadcn secondary color
- `background` → shadcn background
- `foreground` → shadcn foreground
- `muted` → shadcn muted
- `accent` → shadcn accent
- `destructive` → shadcn destructive (error)
- `success`, `warning` → custom colors via `custom` parameter

### 3. `themes/typography.dart`

**Purpose**: Defines typography styles that align with shadcn/ui design system.

**Structure**:

- Text styles for headings (h1-h4)
- Body text styles (large, base, small)
- Button, label, caption styles
- Uses `TextTheme` compatible with Material Design

### 4. `tokens/colors.dart`

**Purpose**: Color constants and utilities (replaces Mix ColorToken).

**Structure**:

- Static color constants
- Helper methods for color manipulation
- No Mix dependencies - pure Flutter `Color` objects

**Example**:

```dart
class AppColors {
  // Primary colors
  static const Color primaryLight = Color(0xFF0093B9);
  static const Color primaryDark = Color(0xFF617AFA);
  
  // Semantic colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFB3261E);
  
  // Helper methods
  static Color getPrimary(bool isDark) => isDark ? primaryDark : primaryLight;
}
```

### 5. `tokens/spacing.dart`

**Purpose**: Spacing constants (replaces Mix SpaceToken).

**Structure**:

- Static spacing values
- Consistent spacing scale (4, 8, 16, 24, 32, 48)
- Helper methods for common spacing

**Example**:

```dart
class AppSpacing {
  static const double xs = 4;
  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;
  static const double xl = 32;
  static const double xxl = 48;
}
```

### 6. `tokens/radius.dart`

**Purpose**: Border radius constants (replaces Mix RadiusToken).

**Structure**:

- Static radius values
- Consistent radius scale
- Helper methods for `BorderRadius`

**Example**:

```dart
class AppRadius {
  static const double small = 4;
  static const double medium = 8;
  static const double large = 12;
  static const double xl = 16;
  static const double full = 9999;
  
  static BorderRadius getSmall() => BorderRadius.circular(small);
  static BorderRadius getMedium() => BorderRadius.circular(medium);
  // ...
}
```

### 7. `tokens/typography_tokens.dart`

**Purpose**: Typography token definitions (replaces Mix TextStyleToken).

**Structure**:

- Enum or class for typography tokens
- Maps to `TextStyle` objects
- Used in theme configuration

### 8. `providers/theme_provider.dart`

**Purpose**: Riverpod providers for theme state management.

**Structure**:

- `appThemeModeProvider` - Manages dark/light mode state
- `appThemeProvider` - Provides current `ShadThemeData`
- `appColorSchemeProvider` - Provides current color scheme
- Methods: `toggleTheme()`, `setDarkMode()`

**Example**:

```dart
@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  bool build() => false; // false = light, true = dark
  
  void toggleTheme() => state = !state;
  void setDarkMode(bool isDark) => state = isDark;
}

@riverpod
ShadThemeData appTheme(Ref ref) {
  final isDark = ref.watch(appThemeModeProvider);
  return isDark ? AppTheme.dark : AppTheme.light;
}
```

### 9. `extensions/theme_extensions.dart`

**Purpose**: Extensions for convenient theme access.

**Structure**:

- `BuildContext` extensions for accessing theme values
- `ShadThemeData` extensions for custom properties
- Helper methods for common theme operations

**Example**:

```dart
extension ThemeExtensions on BuildContext {
  ShadThemeData get shadTheme => ShadTheme.of(this);
  ShadColorScheme get colors => shadTheme.colorScheme;
  
  // Custom colors
  Color get successColor => colors.custom['success'] ?? AppColors.success;
  Color get warningColor => colors.custom['warning'] ?? AppColors.warning;
}

extension ShadThemeDataExtensions on ShadThemeData {
  double get spacingMedium => 16.0; // Or from custom theme data
  BorderRadius get radiusMedium => BorderRadius.circular(8);
}
```

### 10. `extensions/color_extensions.dart`

**Purpose**: Color utility extensions.

**Structure**:

- Color manipulation helpers
- Color conversion utilities
- Accessibility helpers (contrast, brightness)

## Usage Examples

### Accessing Theme in Widgets

```dart
// Using extensions
final colors = context.colors;
final primaryColor = colors.primary;
final successColor = context.successColor;

// Using providers
final theme = ref.watch(appThemeProvider);
final isDark = ref.watch(appThemeModeProvider);
```

### Using Spacing and Radius

```dart
// Spacing
Container(
  padding: EdgeInsets.all(AppSpacing.medium),
  margin: EdgeInsets.symmetric(horizontal: AppSpacing.large),
)

// Radius
Container(
  decoration: BoxDecoration(
    borderRadius: AppRadius.getMedium(),
  ),
)
```

### Toggling Theme

```dart
ref.read(appThemeModeProvider.notifier).toggleTheme();
// or
ref.read(appThemeModeProvider.notifier).setDarkMode(true);
```

## Migration from Mix

### Before (Mix)

```dart
final colors = ref.watch(appColorsProvider);
final primary = colors[AppColorTokens.primary.token]!;
final spacing = ref.watch(appSpacesProvider);
final padding = spacing[AppSpaceTokens.medium.token]!;
```

### After (shadcn_flutter)

```dart
final theme = ref.watch(appThemeProvider);
final colors = theme.colorScheme;
final primary = colors.primary;
final padding = AppSpacing.medium; // Direct constant access
```

## Integration with MaterialApp

Since shadcn_flutter works inside MaterialApp, we can use both:

```dart
MaterialApp.router(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
    ),
  ),
  // shadcn components will use ShadThemeData from context
  // accessed via ShadTheme.of(context)
)
```

## Best Practices

1. **Use constants directly** for spacing and radius instead of providers
2. **Access colors** through `ShadColorScheme` from theme
3. **Custom colors** (success, warning) via `custom` parameter in color scheme
4. **Typography** through `TextTheme` in Material theme
5. **Theme state** managed via Riverpod providers
6. **Extensions** for convenient access but keep them simple

## File Organization Rules

- **One file per concern**: colors, spacing, radius, typography
- **Themes folder**: Contains theme configuration (ShadThemeData)
- **Tokens folder**: Contains constants and utilities
- **Extensions folder**: Contains helper extensions
- **Providers folder**: Contains Riverpod state management

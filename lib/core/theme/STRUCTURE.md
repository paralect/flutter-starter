# Theme Structure Diagram

## File Tree

```bash
lib/core/theme/
│
├── README.md                          # Full documentation
├── STRUCTURE.md                       # This file - visual structure
│
├── providers/                         # State Management (Riverpod)
│   ├── theme_provider.dart           # Theme mode & theme data providers
│   └── theme_provider.g.dart         # Generated code
│
├── themes/                            # Theme Configuration
│   ├── app_theme.dart                 # Main: ShadThemeData (light/dark)
│   ├── color_schemes.dart            # Custom ShadColorScheme definitions
│   └── typography.dart                # TextTheme & typography styles
│
├── tokens/                            # Design Tokens (Constants)
│   ├── colors.dart                    # Color constants (no Mix)
│   ├── spacing.dart                   # Spacing constants (4, 8, 16...)
│   ├── radius.dart                   # Border radius constants
│   └── typography_tokens.dart        # Typography token enum/class
│
└── extensions/                        # Helper Extensions
    ├── theme_extensions.dart          # BuildContext & ShadThemeData extensions
    └── color_extensions.dart          # Color utility extensions
```

## Data Flow

```bash
┌─────────────────────────────────────────────────────────────┐
│                    User Action                                │
│              (toggleTheme, setDarkMode)                      │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│              theme_provider.dart                             │
│  ┌────────────────────────────────────────────────────┐    │
│  │ appThemeModeProvider (bool: false=light, true=dark)│    │
│  └──────────────────┬─────────────────────────────────┘    │
│                     │                                        │
│  ┌──────────────────▼─────────────────────────────────┐    │
│  │ appThemeProvider (ShadThemeData)                    │    │
│  │   - Watches appThemeModeProvider                     │    │
│  │   - Returns AppTheme.light or AppTheme.dark         │    │
│  └──────────────────┬─────────────────────────────────┘    │
└─────────────────────┼──────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    app_theme.dart                             │
│  ┌────────────────────────────────────────────────────┐    │
│  │ AppTheme.light() → ShadThemeData                     │    │
│  │   ├─ Uses AppColorSchemes.light                      │    │
│  │   ├─ Uses Typography.lightTextTheme                  │    │
│  │   └─ Configures spacing, radius via extensions       │    │
│  │                                                       │    │
│  │ AppTheme.dark() → ShadThemeData                      │    │
│  │   ├─ Uses AppColorSchemes.dark                       │    │
│  │   ├─ Uses Typography.darkTextTheme                   │    │
│  │   └─ Configures spacing, radius via extensions      │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────┬──────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│              color_schemes.dart                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │ AppColorSchemes.light → ShadColorScheme             │    │
│  │   ├─ primary: Color(0xFF0093B9)                     │    │
│  │   ├─ background: Color(0xFFFAFAFA)                  │    │
│  │   ├─ foreground: Color(0xFF141C24)                   │    │
│  │   └─ custom: { success, warning }                    │    │
│  │                                                       │    │
│  │ AppColorSchemes.dark → ShadColorScheme               │    │
│  │   ├─ primary: Color(0xFF617AFA)                      │    │
│  │   ├─ background: Color(0xFF141218)                   │    │
│  │   ├─ foreground: Color(0xFFE6E1E5)                   │    │
│  │   └─ custom: { success, warning }                    │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    tokens/                                   │
│                                                              │
│  colors.dart          spacing.dart        radius.dart       │
│  ┌────────────┐      ┌────────────┐      ┌────────────┐    │
│  │ AppColors  │      │ AppSpacing│      │ AppRadius  │    │
│  │  .primary  │      │  .xs = 4   │      │  .small=4  │    │
│  │  .success  │      │  .small=8  │      │  .medium=8 │    │
│  │  .error     │      │  .medium=16│     │  .large=12 │    │
│  └────────────┘      └────────────┘      └────────────┘    │
└─────────────────────────────────────────────────────────────┘
                      │
                      │ (used directly, no providers)
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│              Widget Usage                                    │
│                                                              │
│  // Theme access                                            │
│  final theme = ref.watch(appThemeProvider);                 │
│  final colors = theme.colorScheme;                          │
│  final primary = colors.primary;                            │
│                                                              │
│  // Direct constants                                         │
│  Container(                                                  │
│    padding: EdgeInsets.all(AppSpacing.medium),             │
│    decoration: BoxDecoration(                               │
│      borderRadius: AppRadius.getMedium(),                    │
│      color: colors.background,                              │
│    ),                                                        │
│  )                                                           │
│                                                              │
│  // Via extensions                                           │
│  final successColor = context.successColor;                 │
│  final spacing = context.shadTheme.spacingMedium;           │
└─────────────────────────────────────────────────────────────┘
```

## Component Responsibilities

### 📦 Providers (`providers/`)

**Responsibility**: State management for theme mode and theme data

- Manages dark/light mode state
- Provides `ShadThemeData` based on current mode
- Exposes methods to toggle/change theme

### 🎨 Themes (`themes/`)

**Responsibility**: Theme configuration and assembly

- **app_theme.dart**: Main entry point, creates `ShadThemeData`
- **color_schemes.dart**: Defines color palettes (light/dark)
- **typography.dart**: Defines text styles and typography

### 🎯 Tokens (`tokens/`)

**Responsibility**: Design system constants

- **colors.dart**: Color constants (semantic colors)
- **spacing.dart**: Spacing scale constants
- **radius.dart**: Border radius constants
- **typography_tokens.dart**: Typography token definitions

### 🔧 Extensions (`extensions/`)

**Responsibility**: Convenience helpers

- **theme_extensions.dart**: Easy access to theme values via `BuildContext`
- **color_extensions.dart**: Color manipulation utilities

## Key Differences from Mix

| Aspect | Mix (Old) | shadcn_flutter (New) |
| **Colors** | `Map<ColorToken, Color>` via provider | `ShadColorScheme` from theme |
| **Spacing** | `Map<SpaceToken, double>` via provider | Direct constants `AppSpacing.medium` |
| **Radius** | `Map<RadiusToken, Radius>` via provider | Direct constants `AppRadius.getMedium()` |
| **Typography** | `Map<TextStyleToken, TextStyle>` via provider | `TextTheme` from Material theme |
| **Theme Data** | Custom `AppTheme` class | `ShadThemeData` from shadcn_flutter |
| **Access** | `ref.watch(appColorsProvider)[token]` | `theme.colorScheme.primary` or `context.colors.primary` |

## Migration Checklist

- [ ] Remove `mix` dependency from `pubspec.yaml` ✅
- [ ] Create `tokens/colors.dart` (replace ColorToken)
- [ ] Create `tokens/spacing.dart` (replace SpaceToken)
- [ ] Create `tokens/radius.dart` (replace RadiusToken)
- [ ] Create `tokens/typography_tokens.dart` (replace TextStyleToken)
- [ ] Create `themes/color_schemes.dart` (ShadColorScheme)
- [ ] Create `themes/typography.dart` (TextTheme)
- [ ] Update `themes/app_theme.dart` (ShadThemeData)
- [ ] Update `providers/theme_provider.dart` (remove Mix types)
- [ ] Create `extensions/theme_extensions.dart`
- [ ] Create `extensions/color_extensions.dart`
- [ ] Update `main.dart` to use shadcn theme
- [ ] Update all usages in codebase
- [ ] Remove old Mix token files

# Spendly

Personal finance tracker for iOS built with SwiftUI.

## Features

- **Home** — transaction list with category filter, add/delete transactions
- **Statistics** — income vs expenses summary, category breakdown by period
- **Goals** — savings goals with progress tracking
- **Profile** — theme (light/dark/system), language (EN/RU/UZ), habits/reminders

## Architecture

Clean Architecture with three layers per feature:

```
Features/
└── FeatureName/
    ├── Data/
    │   ├── DataSources/
    │   ├── Mappers/
    │   └── Repositories/
    ├── Domain/
    │   ├── Entities/
    │   ├── Repositories/   ← protocols
    │   └── UseCases/
    └── Presentation/
        ├── Models/
        ├── ViewModels/
        └── Views/
```

Navigation is handled via `AppRouter` (`NavigationPath`) with a typed `Route` enum.

## Tech Stack

- SwiftUI + `@Observable`
- SQLite (custom wrapper, no CoreData)
- No third-party dependencies

## Localization

Runtime in-app language switching (EN / RU / UZ) via `AppLocalizer` — an `@Observable` singleton injected through the SwiftUI environment.

## Requirements

- iOS 17+
- Xcode 16+

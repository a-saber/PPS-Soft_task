

https://github.com/user-attachments/assets/37790fcc-661d-48fa-a816-a488f314c65d






# Help Desk Ticketing System (Flutter)

A mobile Help Desk Ticketing System built with **Clean Architecture + MVVM (feature-based)**,
**Cubit** for state management, and **SQflite** for local, offline-first persistence.

## How to run

```bash
flutter pub get
flutter run
```

## How to run tests

```bash
flutter test
```

Tests live under `test/unit` (pure logic, cubit, and repository-against-real-sqflite-ffi tests)
and `test/widget` (widget rendering + form validation tests).

---

## Architecture

The project mixes **Clean Architecture** (layers: data → repository → presentation, depending on
abstractions, not concretions) with **MVVM** (Cubit acts as the ViewModel: it holds state and
exposes intent methods; the View is a pure function of that state) — organized **feature-first**
so every feature is self-contained and easy to delete/replace independently.

```
lib/
  core/                         # Nothing here knows about "tickets" as a concept
    utils/                      # enums, validators, date formatting, ticket number generator
    helper/                     # database_helper (sqflite), injector (manual DI), app_router
    shared_components/         # buttons, text fields, dropdowns, chips, dialogs, empty/loading states
    theme/                      # light/dark ThemeData (AppColors + AppTheme)
    translations/               # ar.dart / en.dart maps + AppLocalizations + context.tr(...)

  features/
    dashboard/
      presentation/
        cubit/                  # DashboardCubit — aggregates counts from TicketRepository
        views/                  # DashboardScreen
        widgets/                # SummaryCard

    tickets/
      data/
        models/                 # TicketModel, TicketHistoryModel (toMap/fromMap/toJson)
        datasources/             # TicketLocalDataSource (the only place sqflite is imported)
        repo/                    # TicketRepository (abstract) + TicketRepositoryImpl
      presentation/
        cubit/
          ticket_list/           # search / filter / sort / delete / export
          ticket_form/           # create-ticket flow
          ticket_detail/         # status changes, edits, history, delete
        views/                   # TicketListScreen, CreateTicketScreen, TicketDetailScreen
        widgets/                 # TicketCard, TicketFilterBar, CommentTile

    settings/
      presentation/cubit/        # ThemeCubit (dark mode), LocaleCubit (ar/en)
```

### Why this split?

- **`data/datasources`** is the *only* place that imports `sqflite`. If we ever swapped to Hive
  or a remote API, only this folder (plus the repository implementation) would change —
  cubits and views are untouched (Dependency Inversion).
- **`repo` (TicketRepository, abstract)** is what cubits depend on. Tests mock this interface
  instead of touching a real database.
- Each Cubit has **one reason to change** (SRP): `TicketListCubit` only knows about
  listing/searching/filtering, `TicketFormCubit` only about creating a ticket, `TicketDetailCubit`
  only about a single ticket's lifecycle.
- `core/shared_components` holds widgets with zero feature knowledge (`StatusChip`,
  `CustomButton`, `CustomDropdown<T>`, etc.) so they're reusable and Open for extension /
  Closed for modification.

---

## Functional requirements covered

- **Dashboard**: total / open / in-progress / closed counts, tap-through to the ticket list.
- **Ticket list**: search by subject, filter by status, sort by created date (newest/oldest).
- **Create ticket**: subject + description (required, validated), priority, category;
  auto-generated ticket number, creation date, and initial status `Open`.
- **Ticket details**: view all fields, change status (Open / In Progress / Closed), edit
  subject/description/priority, delete with a confirmation dialog.
- **Persistence**: SQflite (`tickets` + `ticket_history` tables) — data survives app restarts.
- **Validation**: required-field validation with friendly messages, localized (ar/en).
- **UI**: responsive `ListView`/`GridView` layouts, consistent shared components, loading and
  empty states on every list/data screen.

## Bonus features implemented

- ✅ **Dark Mode** — `ThemeCubit`, persisted via `shared_preferences`, toggle icon on the dashboard.
- ✅ **Export tickets to JSON** — `TicketRepository.exportTicketsToJson()` writes a timestamped
  `.json` file to the app's documents directory; triggered from the ticket list app bar.
- ✅ **Ticket comments/history** — every creation, edit, and status change appends a row to
  `ticket_history`, shown as a timeline on the ticket details screen.
- ✅ **Offline-first** — everything reads/writes to the local SQflite database; there is no
  network dependency at all, so the app is fully usable offline by construction.
- ✅ **Unit tests** — validators, `TicketListState` filtering/sorting logic, `DashboardCubit`
  (mocked repository via `mocktail`/`bloc_test`), and `TicketRepositoryImpl` against a real
  in-memory SQflite database (`sqflite_common_ffi`).
- ✅ **Widget tests** — `SummaryCard`/`StatusChip` rendering, `CreateTicketScreen` validation.
- ✅ **Arabic/English localization** — lightweight custom `AppLocalizations`
  (`core/translations/ar.dart` & `en.dart`), switchable at runtime via `LocaleCubit`.

## Notes / possible next steps

- Localization is intentionally a hand-rolled `Map<String,String>` lookup (not `gen-l10n`) to
  keep the focus on architecture; swapping it for codegen later only touches
  `core/translations`.
- DI is a small hand-written `Injector` singleton rather than `get_it`/`injectable` — same
  pattern (depend on abstractions, wire concretes in one place), without extra tooling for a
  project this size.

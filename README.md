# 📝 Notify Task App

A clean, offline-first task management app built with **Flutter** and **Dart**, using **Cubit (BLoC)** for state management and **SQLite** for local persistence. Tasks are organized by status (In Progress / Done) and grouped by date for a clear, intuitive experience.

<!-- Optional badges — uncomment and adjust once you have CI / license set up
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green)
-->

<!-- 
📸 Add screenshots or a GIF walkthrough here once available:

<p align="center">
  <img src="screenshots/in_progress.png" width="250" />
  <img src="screenshots/done.png" width="250" />
  <img src="screenshots/add_task.png" width="250" />
</p>
-->

---

## ✨ Features

- ➕ **Add, edit, and delete tasks** through a smooth bottom-sheet UI
- ✅ **Mark tasks as done** with a single tap
- 📅 **Tasks grouped by date** for a cleaner, more organized list view
- 📂 **Separate views** for In Progress and Done tasks
- 💾 **Fully offline** — all data is stored locally with SQLite, no internet required
- 📱 **Responsive UI** that adapts across different screen sizes
- 🎨 **Empty-state animations** powered by Lottie
- 🔔 Custom app icon generated for all platforms

---

## 🛠️ Tech Stack

| Category            | Technology |
|----------------------|------------|
| Framework            | [Flutter](https://flutter.dev) |
| Language             | [Dart](https://dart.dev) |
| State Management     | [flutter_bloc](https://pub.dev/packages/flutter_bloc) / [bloc](https://pub.dev/packages/bloc) (Cubit) |
| Local Database       | [sqflite](https://pub.dev/packages/sqflite) (SQLite) |
| Grouped Lists        | [grouped_list](https://pub.dev/packages/grouped_list) |
| Date Formatting      | [jiffy](https://pub.dev/packages/jiffy) |
| Animations           | [lottie](https://pub.dev/packages/lottie) |
| Responsive Design    | [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) |
| App Icons            | [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) |

---

## 🏗️ Architecture

The app follows a Cubit-driven architecture with a clear separation between the UI layer and business logic:

```
lib/
├── business_logic/
│   └── cubit/
│       ├── task_cubit.dart      # Handles all task-related state & DB operations
│       └── task_state.dart      # Defines all possible states
├── model/
│   └── task_model.dart          # Task data model (fromMap / toMap)
├── screens/
│   ├── in_progress_screen.dart  # In-progress tasks (grouped by date)
│   └── done_screen.dart         # Completed tasks (grouped by date)
├── widgets/
│   ├── task_widget.dart         # Reusable task card
│   ├── add_task_widget.dart     # Bottom sheet for adding a task
│   └── edit_task_widget.dart    # Bottom sheet for editing a task
├── utils/
│   └── local_database_helper.dart  # SQLite setup & query helper
└── main.dart
```

### Database Schema

```sql
CREATE TABLE tasks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  level TEXT NOT NULL,
  dateTime TEXT NOT NULL,
  is_done INTEGER NOT NULL DEFAULT 0
);
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- A connected device or emulator

### Installation

```bash
# Clone the repository
git clone https://github.com/<your-username>/notify-task-app.git
cd notify-task-app

# Install dependencies
flutter pub get

# (Optional) Regenerate app icons
dart run flutter_launcher_icons

# Run the app
flutter run
```

---

## 📚 What I Learned

This project doubled as a hands-on refresher for core Flutter concepts, with a particular focus on:

- Structuring state management cleanly with **Cubit/BLoC**
- Handling **asynchronous database initialization** safely, avoiding race conditions between opening the database and querying it
- Keeping state in sync across multiple screens that share the same Cubit instance
- Grouping and displaying data dynamically with `GroupedListView`

---

## 🙋‍♂️ Author

**Islam Ahmed Al-Sayed El-Feqi**
Flutter Developer

- GitHub: (https://github.com/islamalfeki)
- LinkedIn: (https://www.linkedin.com/in/islam-ahmed-flutter)

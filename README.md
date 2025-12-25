# Notes App

A simple **Flutter Notes App** that allows you to create, edit, and save notes locally on your device using **SQLite (sqflite)**. The app features a clean UI, note colors, and displays the creation date for each note.

---

## 📱 Features

- Add new notes with **title** and **content**
- Edit existing notes
- Save notes locally using **SQLite**
- Display notes in **reverse chronological order**
- Color-coded notes
- Cross-platform support for **Android** and **iOS**
- Easy-to-use, minimalistic UI

---

## 🛠 Tech Stack

- **Flutter** – UI framework
- **Dart** – Programming language
- **SQLite (sqflite)** – Local database
- **intl** – Date formatting

---

## 📂 Project Structure

notes_app/
├── lib/
│ ├── database/ # SQLite database helper
│ ├── screens/ # Screens like NotesScreen
│ └── widgets/ # Custom widgets like NotesDialog
├── android/
├── ios/
├── pubspec.yaml
└── README.md


---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.8.1)
- Android Studio / Emulator or a real device

### Run the App

1. Clone the repo:
```bash
git clone https://github.com/Vidya20044pps/notes_app.git
cd notes_app
flutter pub get
flutter run

# Flutter To-Do List App

A simple and efficient to-do list application built with Flutter, featuring task management and productivity statistics.

## Features

- ✅ **Task Management**
  - Add new tasks with custom titles
  - Mark tasks as complete/incomplete
  - Delete tasks with confirmation dialog
  - Clean and intuitive interface

- 📊 **Statistics Dashboard**
  - Total tasks counter
  - Completed tasks tracker
  - Remaining tasks display
  - Efficiency percentage calculation
  - Visual efficiency indicators with images

- 🎨 **Modern UI**
  - Material Design 3
  - Tab-based navigation (List & Stats)
  - Smooth animations and transitions
  - Responsive layout

## Screenshots

The app displays different efficiency images based on your productivity:
- 0-24%: Low efficiency
- 25-74%: Medium efficiency
- 75-89%: High efficiency
- 90-100%: Excellent efficiency

## Installation

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile deployment)
- An IDE (VS Code, Android Studio, or IntelliJ)

### Setup

1. Clone the repository:
```bash
git clone <your-repository-url>
cd flutter-todo-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Add efficiency images to your project:
   - Create an `assets` folder in your project root
   - Add the following images:
     - `efficiency0.jpg` (for 0-24% efficiency)
     - `efficiency25.jpg` (for 25-74% efficiency)
     - `efficiency75.jpg` (for 75-89% efficiency)
     - `efficiency100.jpg` (for 90-100% efficiency)

4. Update `pubspec.yaml` to include assets:
```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/
```

5. Run the app:
```bash
flutter run
```

## Usage

### Adding a Task
1. Tap the floating action button (+) at the bottom
2. Enter your task title in the dialog
3. Click "Add" to save or "Abolition" to cancel

### Completing a Task
- Tap the circle icon next to a task to mark it as complete
- Completed tasks will show a green checkmark and strikethrough text

### Deleting a Task
- Tap on any task item
- Confirm deletion in the dialog that appears

### Viewing Statistics
- Switch to the "Stats" tab to view:
  - Total number of tasks
  - Number of completed tasks
  - Number of remaining tasks
  - Your efficiency percentage
  - Visual efficiency indicator

## Project Structure

```
lib/
├── main.dart           # Main application file
    ├── Task            # Task data model
    ├── MyApp           # Root application widget
    ├── TabToDoList     # Main stateful widget with tab controller
    └── TodoItem        # Reusable task item widget
```

## Technologies Used

- **Flutter**: UI framework
- **Material Design 3**: Design system
- **Dart**: Programming language

## Code Highlights

### Efficiency Calculation
The app calculates efficiency as the percentage of completed tasks:
```dart
double get efficiency {
  if (_tasks.isEmpty) return 0.0;
  int doneCount = _tasks.where((t) => t.isDone).length;
  return (doneCount / _tasks.length) * 100;
}
```

### Dynamic Image Selection
Images change based on efficiency level:
```dart
String get efficiencyImage {
  if (efficiency < 25) return 'assets/efficiency0.jpg';
  else if (efficiency < 75) return 'assets/efficiency25.jpg';
  else if (efficiency < 90) return 'assets/efficiency75.jpg';
  else return 'assets/efficiency100.jpg';
}
```
## Future Improvements

- [ ] Add data persistence (SharedPreferences or SQLite)
- [ ] Implement task categories
- [ ] Enable task editing
- [ ] Implement search and filter functionality
- [ ] Add dark mode support
- [ ] Standardize language/localization

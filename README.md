# String Calculator TDD Kata - Flutter Clean Architecture

A comprehensive Flutter implementation of the String Calculator TDD Kata using Clean Architecture principles, feature-first approach, and BLoC state management.

## 🏗️ Architecture Overview

This project follows Clean Architecture principles with a feature-first approach:

```
lib/
├── core/
│   ├── di/                 # Dependency Injection
│   ├── error/              # Error handling
│   └── usecases/           # Base use case class
└── features/
    └── calculator/
        ├── data/
        │   ├── datasources/    # Data sources
        │   ├── models/         # Data models
        │   └── repositories/   # Repository implementations
        ├── domain/
        │   ├── entities/       # Domain entities
        │   ├── repositories/   # Repository contracts
        │   └── usecases/       # Business logic
        └── presentation/
            ├── bloc/           # BLoC state management
            ├── pages/          # UI pages
            └── widgets/        # Reusable UI widgets
```

## 🎯 Features Implemented

### Core String Calculator Logic
✅ **Step 1**: Basic addition with comma-separated numbers  
✅ **Step 2**: Handle any amount of numbers  
✅ **Step 3**: Support newlines between numbers  
✅ **Step 4**: Custom delimiters with `//[delimiter]\n[numbers]` format  
✅ **Step 5**: Negative number validation with detailed error messages  

### Architecture Features
- **Clean Architecture**: Separation of concerns with clear dependencies
- **Feature-First**: Organized by features rather than layers
- **BLoC Pattern**: Reactive state management with flutter_bloc
- **Dependency Injection**: Using get_it for dependency management
- **Error Handling**: Comprehensive error handling with Either pattern
- **Test Coverage**: Unit tests, widget tests, and bloc tests

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)

### Installation

1. **Create a new Flutter project:**
   ```bash
   flutter create string_calculator_kata
   cd string_calculator_kata
   ```

2. **Replace the project files** with the provided code

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Generate mock files for testing:**
   ```bash
   flutter packages pub run build_runner build
   ```

### Running the App

```bash
flutter run
```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/calculator/domain/usecases/calculate_sum_test.dart
```

## 📱 Usage Examples

The calculator supports various input formats:

- **Empty string**: `""` → `0`
- **Single number**: `"5"` → `5`
- **Multiple numbers**: `"1,2,3"` → `6`
- **With newlines**: `"1\n2,3"` → `6`
- **Custom delimiter**: `"//;\n1;2;3"` → `6`

### Error Handling
- **Negative numbers**: `"1,-2,3"` → Error: "negative numbers not allowed -2"
- **Multiple negatives**: `"1,-2,3,-4"` → Error: "negative numbers not allowed -2, -4"
- **Invalid format**: `"1,a,3"` → Error: "Invalid number format: a"

## 🧪 Testing Strategy

### Test Types
1. **Unit Tests**: Core business logic and use cases
2. **Repository Tests**: Data layer functionality
3. **BLoC Tests**: State management logic
4. **Widget Tests**: UI components and interactions

### Test Coverage Areas
- All calculator logic scenarios
- Error handling and edge cases
- BLoC state transitions
- UI widget interactions
- Repository and data source operations

## 🏛️ Clean Architecture Layers

### 1. Domain Layer
- **Entities**: Core business objects (`CalculationResult`)
- **Use Cases**: Business logic (`CalculateSum`)
- **Repositories**: Abstract contracts for data access

### 2. Data Layer
- **Models**: Data transfer objects extending domain entities
- **Data Sources**: Local data source for calculator logic
- **Repository Implementations**: Concrete implementations of domain contracts

### 3. Presentation Layer
- **BLoC**: State management for calculator functionality
- **Pages**: Main UI screens
- **Widgets**: Reusable UI components

## 📦 Dependencies

### Core Dependencies
- `flutter_bloc`: State management
- `get_it`: Dependency injection
- `dartz`: Functional programming (Either type)
- `equatable`: Value equality

### Development Dependencies
- `bloc_test`: BLoC testing utilities
- `mockito`: Mocking framework
- `build_runner`: Code generation

## 🔄 State Management

The app uses BLoC pattern with the following states:
- `CalculatorInitial`: Initial state
- `CalculatorLoading`: During calculation
- `CalculatorLoaded`: Successful calculation result
- `CalculatorError`: Error occurred during calculation

### Events
- `CalculateNumbers`: Trigger calculation
- `ClearCalculation`: Reset calculator
- `InputChanged`: Input field changed

## 🎨 UI Design

- **Material Design 3**: Modern, consistent UI
- **Responsive Layout**: Adapts to different screen sizes
- **Error Handling**: Clear visual feedback for errors
- **Loading States**: Progress indicators during calculations
- **Examples Section**: Built-in usage examples


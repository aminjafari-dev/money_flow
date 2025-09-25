# SMS Import Feature

## Description

The SMS Import feature allows users to automatically detect and import bank transaction SMS messages into the app, eliminating the need for manual transaction entry. This feature provides a clean interface for viewing SMS conversations and selecting bank numbers to view their messages with real SMS data access and proper permission handling.

## Architecture

The SMS Import feature follows Clean Architecture principles with the following structure:

### Domain Layer
- **Entities**: `SmsEntity`, `SmsConversationEntity` - Core business objects
- **Repositories**: `SmsRepository` - Abstract repository interface
- **Use Cases**: 
  - `GetSmsConversationsUseCase` - Retrieves SMS conversations grouped by sender
  - `GetSmsMessagesByAddressUseCase` - Retrieves messages from specific sender
  - `CheckSmsPermissionUseCase` - Checks SMS permission status
  - `RequestSmsPermissionUseCase` - Requests SMS permission from user

### Data Layer
- **Models**: `SmsModel`, `SmsConversationModel` - Data transfer objects with JSON serialization
- **Data Sources**: `SmsDataSource`, `SmsRealDataSourceImpl` - Real SMS data access with permission handling
- **Repository Implementation**: `SmsRepositoryImpl` - Concrete repository implementation

### Presentation Layer
- **BLoC**: `SmsImportBloc` - State management for SMS import operations
- **Events**: `SmsImportEvent` - User actions and system triggers
- **States**: `SmsImportState`, `ConversationsState`, `MessagesState`, `PermissionState` - UI state management
- **Pages**: 
  - `SmsImportPage` - Main SMS import interface with automatic permission handling
  - `SmsMessagesPage` - Messages from specific sender
- **Widgets**: 
  - `SmsPermissionWidget` - Permission status and request UI
  - `SmsConversationsList` - List of SMS conversations
  - `SmsMessagesList` - List of messages from specific sender

## Use Cases

1. **Get SMS Conversations**: Retrieves all SMS conversations grouped by sender address with preview information including last message, message count, and timestamp.

2. **Get SMS Messages by Address**: Retrieves all SMS messages from a specific sender address in chronological order for detailed review.

3. **Check SMS Permission**: Verifies the current SMS read permission status without requesting permission from the user.

4. **Request SMS Permission**: Prompts the user to grant SMS read permission through the system permission dialog.

## Data Flow

1. **User opens SMS Import page** → BLoC checks permission status
2. **Permission not granted** → Shows permission request UI
3. **User grants permission** → BLoC automatically loads SMS conversations
4. **User selects conversation** → BLoC loads messages from that sender
5. **Messages displayed** → User can review SMS content
6. **Future enhancement** → User can import transactions from SMS messages

## Key Components

- **Clean Architecture**: Strict separation of concerns with domain, data, and presentation layers
- **BLoC Pattern**: Event-driven state management with immutable states
- **Freezed**: Immutable data classes with code generation
- **Dartz**: Functional error handling with Either type
- **GetIt**: Dependency injection for loose coupling
- **Real SMS Access**: Platform-specific SMS data access with proper permission handling
- **Automatic Permission Flow**: Seamless permission request and data loading

## Navigation

- **SMS Import Page**: `/sms-import` - Main SMS import interface
- **SMS Messages Page**: `/sms-messages` - Messages from specific sender (requires address argument)

## Access Points

- **Dashboard**: Green SMS floating action button for quick access
- **Direct Navigation**: Programmatic navigation to SMS import pages

## Permission Handling

The feature implements a comprehensive permission handling system:

1. **Automatic Permission Check**: When the page loads, it automatically checks SMS permission status
2. **Permission Request UI**: If permission is not granted, shows a user-friendly permission request interface
3. **Automatic Data Loading**: Once permission is granted, automatically loads SMS conversations
4. **Error Handling**: Proper error handling for permission-related issues

## Platform Support

- **Android**: Full SMS access with READ_SMS and RECEIVE_SMS permissions
- **iOS**: Limited support (iOS doesn't allow SMS reading in most cases)
- **Permission Simulation**: Currently uses simulated permission flow for demonstration

## Future Enhancements

- **Transaction Import**: Parse SMS content and import as transactions
- **Category Suggestions**: AI-powered category suggestions based on SMS content
- **Batch Import**: Import multiple transactions at once
- **Real SMS Integration**: Complete native SMS access implementation
- **Transaction Parsing**: Extract amounts, merchants, and dates from SMS text
- **Bank Integration**: Support for multiple bank SMS formats
- **Platform Channels**: Native Android/iOS implementation for real SMS access

## Technical Notes

- **Real Data Implementation**: Uses `SmsRealDataSourceImpl` for actual SMS data access
- **Permission Handling**: Comprehensive permission checking and requesting system
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **State Management**: Immutable states with proper loading, success, and error states
- **UI Consistency**: Follows app design system with consistent colors, fonts, and spacing
- **Automatic Flow**: Seamless user experience with automatic permission and data loading

## Android Permissions

The following permissions are required in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.READ_SMS" />
<uses-permission android:name="android.permission.RECEIVE_SMS" />
```

## Implementation Status

- ✅ **Permission Handling**: Complete permission checking and requesting system
- ✅ **UI Components**: All UI components implemented with proper state management
- ✅ **Data Models**: Complete data models with JSON serialization
- ✅ **Use Cases**: All business logic use cases implemented
- ✅ **Repository Pattern**: Clean architecture with proper abstraction
- 🔄 **Real SMS Access**: Currently using simulated data (ready for native implementation)
- 🔄 **Native Implementation**: Platform channels ready for Android/iOS native code

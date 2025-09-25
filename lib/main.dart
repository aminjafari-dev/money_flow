import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/di/locator.dart';
import 'package:money_flow/core/router/page_router.dart';
import 'package:money_flow/core/router/page_name.dart';
import 'package:money_flow/core/theme/app_theme.dart';
import 'package:money_flow/core/services/localization_service.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';
import 'package:money_flow/shared/models/bank/bank_model.dart';
import 'package:money_flow/shared/models/category/category_models.dart';

/// Main entry point of the Money Flow application.
/// This function initializes the app and sets up all necessary services.
///
/// Features:
/// - Dependency injection setup
/// - Localization initialization
/// - System UI configuration
/// - Error handling setup
///
/// Usage:
/// This function is called automatically when the app starts.
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Configure system UI
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Hive for local storage
  await Hive.initFlutter();


  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  // Initialize localization service
  await LocalizationService.instance.initialize();

  // Initialize dependency injection
  await setupLocator();

  // Set up global BLoC observer
  Bloc.observer = _AppBlocObserver();

  // Run the app
  runApp(const MoneyFlowApp());
}

/// Main application widget for Money Flow.
/// This widget serves as the root of the application and configures the
/// MaterialApp with all necessary settings.
///
/// Features:
/// - Theme configuration (light and dark themes)
/// - Localization support
/// - Routing configuration
/// - BLoC observer setup
/// - Global error handling
///
/// Usage:
/// This widget is automatically created and used as the root widget.
class MoneyFlowApp extends StatelessWidget {
  /// Creates a new instance of MoneyFlowApp
  const MoneyFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Build the main MaterialApp
    return MaterialApp(
      // Set the application title
      title: 'Money Flow',

      // Configure debug banner
      debugShowCheckedModeBanner: false,

      // Set up themes
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Configure localization
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('fa', ''), // Persian
      ],
      locale: const Locale('en', ''),

      // Configure routing
      initialRoute: PageName.mainNavigation,
      onGenerateRoute: PageRouter.onGenerateRoute,
      routes: PageRouter.routes,

      // Set up global error handling
      builder: (context, child) {
        return MediaQuery(
          // Ensure text scaling doesn't break the layout
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.of(context).textScaler.scale(1.0).clamp(0.8, 1.2),
            ),
          ),
          child: child!,
        );
      },

      // Configure navigation observer for analytics/tracking
      navigatorObservers: [_AppNavigatorObserver()],
    );
  }
}

/// Global BLoC observer for debugging and monitoring.
/// This observer helps track BLoC events and state changes during development.
///
/// Features:
/// - Logs BLoC events and state changes
/// - Monitors for errors in BLoC operations
/// - Provides debugging information
///
/// Usage:
/// This observer is automatically set up in the main app widget.
class _AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('BLoC Created: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('BLoC Change: ${bloc.runtimeType} - $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('BLoC Error: ${bloc.runtimeType} - $error');
    debugPrint('Stack Trace: $stackTrace');

    // TODO: Send error to crash reporting service
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('BLoC Closed: ${bloc.runtimeType}');
  }
}

/// Global navigation observer for monitoring navigation events.
/// This observer helps track user navigation patterns and potential issues.
///
/// Features:
/// - Logs navigation events
/// - Monitors for navigation errors
/// - Provides analytics data
///
/// Usage:
/// This observer is automatically set up in the main app widget.
class _AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint('Navigator: Pushed ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint('Navigator: Popped ${route.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    debugPrint('Navigator: Removed ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint(
      'Navigator: Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}',
    );
  }
}

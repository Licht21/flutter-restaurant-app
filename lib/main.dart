import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/setting/settings.dart';
import 'package:restaurant_app/provider/favorite/favorite_list_provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_provider.dart';
import 'package:restaurant_app/provider/home/index_nav_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/home/theme_provider.dart';
import 'package:restaurant_app/provider/local_notification/local_notification_provider.dart';
import 'package:restaurant_app/provider/shared_preferences/shared_preferences_provider.dart';
import 'package:restaurant_app/screen/detail/restaurant_detail_screen.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/services/local_notification_services.dart';
import 'package:restaurant_app/services/shared_preferences_services.dart';
import 'package:restaurant_app/services/sqflite_services.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ApiServices()),
        Provider(create: (context) => SqfliteServices()),
        Provider(create: (context) => SharedPreferencesServices(prefs)),
        Provider(
          create: (context) => LocalNotificationServices()
            ..init()
            ..configureLocalTimeZone(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(
          create: (context) =>
              FavoriteListProvider(context.read<SqfliteServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) => SharedPreferencesProvider(
            context.read<SharedPreferencesServices>(),
            Settings(isDefaultTheme: true, isNotificationEnabled: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationServices>()..requestPermissions(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _scheduleDailyTenAMNotification() async {
    context.read<SharedPreferencesProvider>().setting.isNotificationEnabled
        ? context
              .read<LocalNotificationProvider>()
              .scheduleDailyElevenAMNotification()
        : context.read<LocalNotificationProvider>().cancelAllNotification();
  }

  @override
  void initState() {
    super.initState();
    context.read<FavoriteListProvider>().getRestaurantFavorite();
    Future.microtask(() async {
      if (!mounted) return;
      context.read<SharedPreferencesProvider>().getSettingValue();
      _scheduleDailyTenAMNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode:
          context.watch<SharedPreferencesProvider>().setting.isDefaultTheme
          ? ThemeMode.light
          : ThemeMode.dark,
      initialRoute: NavigationRoute.homeRoute.name,
      routes: {
        NavigationRoute.homeRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => RestaurantDetailScreen(
          restaurantId: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}

import 'package:asset_management_module/home/view.dart';
import 'package:asset_management_module/landing/view.dart';
import 'package:asset_management_module/splash_screen/view.dart';
import 'package:asset_management_module/utils/data/nav_key.dart';
import 'package:asset_management_module/utils/localization/key.dart';
import 'package:asset_management_module/utils/themes/dart.dart';
import 'package:asset_management_module/utils/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await initializeDateFormatting('id_ID', null);
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: NavKey.navKey,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      translations: Messages(),
      locale: const Locale('id', 'ID'),
      // initialRoute: '/home',
      getPages: [
        // GetPage(name: '/', page: () => const LandingPage()),
        GetPage(name: '/', page: () => const SplashScreenPage()),
        GetPage(name: '/home', page: () => const HomePage()),
      ],
      routingCallback: (value) {
        final uriData = Uri.parse(value!.current);
        final data = uriData.queryParameters['data'];
        if(data != null) {
          NavKey.data = data;
        }
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker/controllers/auth_controller.dart';
import 'package:money_tracker/controllers/budget_controller.dart';
import 'package:money_tracker/controllers/theme_controller.dart';
import 'package:money_tracker/data/db_helper.dart';
import 'package:money_tracker/theme.dart';
import 'package:money_tracker/views/auth/start_page.dart';
import 'package:money_tracker/controllers/transaction_controller.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive
    await Hive.initFlutter();

    // Initialize the database
    await DBHelper.init();

    // Initialize TransactionController globally
    Get.put(AuthController());
    Get.put(TransactionController());
    Get.put(BudgetController());
    Get.put(ThemeController());

    // Run the application
    runApp(MyApp());
  } catch (e) {
    // Handle any initialization errors
    print('Initialization error: $e');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Tracker',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _getThemeMode(),
      home: StartPage(),
    );
  }

  // Helper method to determine the theme mode
  ThemeMode _getThemeMode() {
    final settingsBox = Hive.box('settings');
    final isDarkMode = settingsBox.get('darkMode', defaultValue: false);
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/customer/presentation/customer_dashboard.dart';
import 'features/technician/presentation/technician_dashboard.dart';

void main() {
  runApp(
    DevicePreview(
      // Show the phone frame on web in any mode; keep it on for desktop too.
      enabled: kIsWeb ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.linux,
      builder: (_) => const TelecomApp(),
    ),
  );
}

class TelecomApp extends StatelessWidget {
  const TelecomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telecom OSS/BSS',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.customerHome: (_) => const CustomerDashboard(),
        AppRoutes.technicianHome: (_) => const TechnicianDashboard(),
      },
    );
  }
}

class AppRoutes {
  AppRoutes._();
  static const String login = '/';
  static const String customerHome = '/customer';
  static const String technicianHome = '/technician';
}

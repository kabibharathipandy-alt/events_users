import 'package:flutter/material.dart';
import 'utils/app_router.dart';
import 'widgets/app_string.dart';
import 'widgets/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppString.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
        scaffoldBackgroundColor: AppColor.background,
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

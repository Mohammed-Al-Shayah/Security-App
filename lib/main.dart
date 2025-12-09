
import 'package:flutter/material.dart';
import 'package:security_app/core/di/service_locator.dart';
import 'package:security_app/core/routing/app_router.dart';
import 'package:security_app/security_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(SecurityApp(appRouter: AppRouter()));
}

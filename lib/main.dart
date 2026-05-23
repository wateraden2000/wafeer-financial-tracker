import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/transaction_provider.dart';
import 'theme/app_theme.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: const FinancialTrackerApp(),
    ),
  );
}

class FinancialTrackerApp extends StatelessWidget {
  const FinancialTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme, // Modern Dark theme as primary
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const DashboardScreen(),
    );
  }
}

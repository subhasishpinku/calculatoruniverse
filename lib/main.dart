
import 'package:calculatoruniverse/InterestCalculator/InterestCalculator.dart';
import 'package:calculatoruniverse/Investment%20Calculator/InvestmentCalculator.dart';
import 'package:calculatoruniverse/PaymentCalculator/paymentCalculator.dart';
import 'package:calculatoruniverse/RetirementCalculator/RetirementCalculator.dart';
import 'package:calculatoruniverse/amortizationCalculator/amortizationCalculator.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:calculatoruniverse/screens/LoanCalculator/loan_calculator.dart';
import 'package:calculatoruniverse/screens/LoginScreens/login_screen.dart';
import 'package:calculatoruniverse/screens/dashboard/dashboard_provider.dart';
import 'package:calculatoruniverse/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/AutoLoan/autoloan.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(),
        ),
        // ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColor.primaryColor, // Explicitly set the primary color
        focusColor: AppColor.primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primaryColor,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontFamily: "Helvetica Neue"),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: createWhiteSwatch(),
        ).copyWith(
          secondary: AppColor.primaryColor,
        ),
      ),
      home: const DashboardScreen(),
    );
  }

  MaterialColor createWhiteSwatch() {
    const int whiteValue = 0xFFFFFFFF;
    Map<int, Color> swatch = {
      50: const Color(whiteValue),
      100: const Color(whiteValue),
      200: const Color(whiteValue),
      300: const Color(whiteValue),
      400: const Color(whiteValue),
      500: const Color(whiteValue),
      600: const Color(whiteValue),
      700: const Color(whiteValue),
      800: const Color(whiteValue),
      900: const Color(whiteValue),
    };
    return MaterialColor(whiteValue, swatch);
  }
}

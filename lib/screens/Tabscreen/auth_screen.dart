import 'package:calculatoruniverse/constants/colors.dart';
import 'package:calculatoruniverse/screens/LoginScreens/login_screen.dart';
import 'package:calculatoruniverse/screens/registrationscreen/registrationscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          // title: const Text(
          //   "Authentication",
          //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          // ),
          bottom: const TabBar(
            labelColor: AppColor.defaultBlack,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "Login"),
              Tab(text: "Register"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
          //  LoginScreen(), // Reuse the LoginScreen widget
            RegistrationScreen(), // Create a new RegistrationScreen widget
          ],
        ),
      ),
    );
  }
}
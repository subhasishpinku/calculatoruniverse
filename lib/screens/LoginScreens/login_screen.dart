import 'package:calculatoruniverse/component/createdTextField.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:calculatoruniverse/screens/dashboard/dashboard_screen.dart';
import 'package:calculatoruniverse/screens/LoginScreens/login_screen.dart';
import 'package:calculatoruniverse/screens/registrationscreen/registrationscreen.dart';
import 'package:calculatoruniverse/screens/tabscreen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}
class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  String _username = "";
  String usernames = "";
  String _password = "";
  String passwords = "";
  bool hidePassword = true;
  void _toggle() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  late TabController _tabController;
  bool _isChecked = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void keyusernames(String usernames) {
    setState(() {
      usernames = usernames;
    });
  }

  
  void keypasswords(String passwords) {
    setState(() {
      passwords = passwords;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildUsername() => Column(
        children: [
          Container(
            child: createdTextField(
              prefixIcon: FontAwesomeIcons.user,

              // image: 'images/email.svg',
              obscureText: false,
              label: 'Username',
              keyonValidate: usernames,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  usernames = "Username can't be empty.";
                  keyusernames(usernames);
                  return "Username can't be empty";
                }
                if (value.length < 3) {
                  usernames = "Must be more than 2 characters.";
                  keyusernames(usernames);
                  return 'Must be more than 2 characters';
                }
                return null;
              },
              onSaved: (value) {
                _username = value;
              },
            ),
          ),
        ],
      );

  Widget buildPassword() => Column(
        children: [
          Container(
            child: createdTextField(
              prefixIcon: FontAwesomeIcons.lock,
              suffixIcon: IconButton(
                splashColor: Colors.transparent,
                onPressed: _toggle,
                icon: FaIcon(
                  hidePassword
                      ? FontAwesomeIcons.eyeSlash
                      : FontAwesomeIcons.eye,
                  size: 15,
                  color: AppColor.defaultBlack.withOpacity(0.7),
                ),
              ),
              obscureText: hidePassword,
              label: 'Password',
              keyonValidate: passwords,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  passwords = "Password can't be empty.";
                  keypasswords(passwords);
                  return "Password can't be empty";
                }
                if (value.length < 6) {
                  passwords = "Password must at least 6 characters.";
                  keypasswords(passwords);
                  return 'Password must at least 6 characters';
                }
                return null;
              },
              onSaved: (value) {
                _password = value;
              },
            ),
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.defaultWhite,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: AppColor.defaultWhite,
      body: SafeArea(
        child: _loginUISetup(context),
      ),
    );
  }

  Widget _loginUISetup(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Center(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: loginFormKey,
                    child: _loginUI(context),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ]),
    );
  }

  Widget _loginUI(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 80, bottom: 15, top: 100),
          child: Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 0), // Adds space above the text
                    Stack(
                      children: [
                        // Underline with custom thickness and color
                        Positioned(
                          bottom:
                              0, // Ensures the underline aligns with the text
                          child: Container(
                            height: 4, // Adjust thickness of the underline
                            width: 60, // Adjust width of the underline
                            color: AppColor.primaryColor, // Underline color
                          ),
                        ),
                        const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "/",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => RegistrationScreen(),
                    ),
                  );
                },
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "REGISTRATION",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
        ),
        _logintext(context)
      ],
    );
  }
    Widget _logintext(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        buildUsername(),
        const SizedBox(
          height: 5,
        ),
        buildPassword(),
        const SizedBox(
          height: 5,
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            CheckboxListTile(
              title: const Text('Remember password'),
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity
                  .leading, // Places checkbox on the left
            ),
            GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.only(left: 200),
                child: Text(
                  "Forget password",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primaryColor),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () async {
            onClickSubmitButton();
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(100.0, 10.0, 100.0, 10.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColor.primaryColor, AppColor.primaryColor],
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Text(
              "Sign In",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
        const SizedBox(
          height: 0,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SvgPicture.asset(
            'assets/images/bottom_banner.svg',
            fit: BoxFit.cover, // Adjust fit as needed
            width: MediaQuery.of(context).size.width, // Full width
          ),
        ),
      ],
    );
  }


  void onClickSubmitButton() async {
    // Trigger `onSaved` for all form fields
    loginFormKey.currentState!.save();
    // Validate the form fields
    if (loginFormKey.currentState!.validate()) {
      Fluttertoast.showToast(
        msg: "Login successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: AppColor.primaryColor,
        textColor: AppColor.defaultWhite,
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const DashboardScreen(),
        ),
      );
    } else {
      // Handle individual error cases
      if (_username.trim().isEmpty) {
        Fluttertoast.showToast(
          msg: usernames,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: AppColor.black,
          textColor: AppColor.defaultWhite,
        );
      }  else if (_password.trim().isEmpty) {
        Fluttertoast.showToast(
          msg: passwords,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: AppColor.black,
          textColor: AppColor.defaultWhite,
        );
      } else if (_password.trim().length < 6) {
        Fluttertoast.showToast(
          msg: passwords,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: AppColor.black,
          textColor: AppColor.defaultWhite,
        );
      }
    }
  }
}

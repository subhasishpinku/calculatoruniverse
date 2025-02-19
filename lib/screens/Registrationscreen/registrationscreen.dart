import 'package:calculatoruniverse/component/createdTextField.dart';
import 'package:calculatoruniverse/constants/colors.dart';
import 'package:calculatoruniverse/screens/LoginScreens/login_screen.dart';
import 'package:calculatoruniverse/screens/Registrationscreen/registrationscreen.dart';
import 'package:calculatoruniverse/screens/tabscreen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  String _username = "";
  String usernames = "";
  String _email = "";
  String emails = "";
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

  void keyemails(String emails) {
    setState(() {
      emails = emails;
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
  Widget buildEmail() => Column(
        children: [
          Container(
            child: createdTextField(
              prefixIcon: FontAwesomeIcons.envelope,
              obscureText: false,
              label: 'Email',
              keyonValidate: emails,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  emails = "Email can't be empty.";
                  keyemails(emails);
                  return "Email can't be empty";
                }
                if (!value.contains('@')) {
                  emails = "Invalid email address.";
                  keyemails(emails);
                  return 'Invalid email address';
                }
                return null;
              },
              onSaved: (value) {
                _email = value;
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
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0), // Adds space above the text
                      Stack(
                        children: [
                          // Underline with custom thickness and color
                          Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColor.defaultBlack),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "/",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => {},
                  //   ),
                  // );
                },
                child: Align(
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
                              width: 150, // Adjust width of the underline
                              color: AppColor.primaryColor, // Underline color
                            ),
                          ),
                          const Text(
                            "REGISTRATION",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColor.primaryColor),
                          ),
                        ],
                      ),
                    ],
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
        buildEmail(),
        const SizedBox(
          height: 5,
        ),
        buildPassword(),
        const SizedBox(
          height: 15,
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
              "Sign Up",
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
        msg: "Registration successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: AppColor.primaryColor,
        textColor: AppColor.defaultWhite,
      );
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => const LoginScreen(),
      //   ),
      // );
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
      } else if (_email.trim().isEmpty) {
        Fluttertoast.showToast(
          msg: emails,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: AppColor.black,
          textColor: AppColor.defaultWhite,
        );
      } else if (!_email.trim().contains('@')) {
        Fluttertoast.showToast(
          msg: emails,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: AppColor.defaultWhite,
        );
      } else if (_password.trim().isEmpty) {
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

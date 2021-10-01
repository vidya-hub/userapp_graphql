import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:userapp/components/signin/components.dart';
import 'package:userapp/screens/signin.dart';
import 'package:userapp/service/API/apiservice.dart';
import 'package:userapp/service/AuthService.dart';
import 'package:userapp/utils/shared_pref.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _contactController = TextEditingController();
  @override
  void initState() {
    setState(() {
      _passwordVisible = false;
      _confirmPasswordVisible = false;
    });
  }

  void showToast(String msgs) {
    Fluttertoast.showToast(
        msg: msgs,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }

  ApiService apiService = ApiService();

  // bool passwordValidate(String value) {
  //   String pattern =
  //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  //   RegExp regExp = new RegExp(pattern);
  //   return regExp.hasMatch(value);
  // }
  bool passwordValidate(String password, [int minLength = 8]) {
    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;

    return hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength;
  }

  @override
  Widget build(BuildContext context) {
    var _pheight = MediaQuery.of(context).size.height;
    var _pwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: _pheight * 0.008),
              mainLogo(),
              SizedBox(
                height: _pheight * 0.01,
              ),
              headtext("Sign Up"),
              SizedBox(height: _pheight * 0.003),
              nameField(_pwidth, _pheight, _nameController),
              SizedBox(height: _pheight * 0.003),
              contactField(_pwidth, _pheight, _contactController),
              SizedBox(height: _pheight * 0.003),
              emailField(_pwidth, _pheight, _emailController),
              SizedBox(height: _pheight * 0.003),
              Container(
                width: _pwidth * 0.8,
                height: _pheight * 0.08,
                child: TextField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                        // print(_passwordVisible);
                      },
                      child: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    labelText: "Password",
                  ),
                ),
              ),
              SizedBox(height: _pheight * 0.01),
              Container(
                width: _pwidth * 0.8,
                height: _pheight * 0.08,
                child: TextField(
                  controller: _confirmPasswordController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_confirmPasswordVisible,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                        // print(_passwordVisible);
                      },
                      child: Icon(_confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    labelText: "Confirm Password",
                  ),
                ),
              ),
              SizedBox(
                height: _pheight * 0.002,
              ),
              SizedBox(height: _pheight * 0.006),
              GestureDetector(
                onTap: () async {
                  if (_nameController.text == null ||
                      _nameController.text == "") {
                    showToast("Please enter Your Name.");
                    return;
                  }
                  if (_contactController.text == null ||
                      _contactController.text == "") {
                    showToast("Please enter Phone number");
                    return;
                  } else if (((_contactController.text.toString().length <
                      10))) {
                    showToast("Please enter 10 digit Phone No.");
                    return;
                  }

                  if (_emailController.text == null ||
                      _emailController.text == "") {
                    showToast("Please enter Email.");
                    return;
                  } else if (!emailValidation(_emailController.text)) {
                    showToast("Please enter valid Email.");
                    return;
                  }

                  if (_passwordController.text == null ||
                      _passwordController.text == "") {
                    showToast("Please enter Password.");
                    return;
                  }
                  if (_passwordController.text.toString().length < 8) {
                    showToast(
                        "Please enter Password not less than 8 charecters.");
                    return;
                  }
                  if (_confirmPasswordController.text == null ||
                      _confirmPasswordController.text == "") {
                    showToast("Please enter Confirm Password.");
                    return;
                  }
                  if (_confirmPasswordController.text !=
                      _passwordController.text) {
                    showToast("Password and confirm Password must be same.");
                    return;
                  }

                  // else if (!passwordValidate(
                  //     _passwordController.text.trim())) {
                  //   showToast("Please Enter valid Password.");
                  //   showToast(
                  //       "Password should contain at least One special character,One UpperCase,One Number and 8 characters in length");
                  //   return;
                  // }
                  print("Done");
                  /* Map<String, String> body = {
                    "name": _nameController.text.trim(),
                    "email": _emailController.text.trim(),
                    "phone": _contactController.text.trim(),
                    "password": _passwordController.text.trim(),
                    "Referral_code_used": "active50"
                  };
                  var resPonse = await apiService.register(body);
                  if (resPonse["is_active"] != null &&
                      resPonse["is_active"] == true) {
                    showToast("User Successfully Registered");
                    showToast("Please Login With your Credentials");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogInPage(),
                        ));
                  } else {
                    showToast("User Email or PhoneNo already Registered");
                  } */
                  // print(resPonse["is_active"]);
                  // print(resPonse);

                  QueryResult response = await AuthService.createUser(
                    _passwordController.text.trim(),
                    _nameController.text.trim(),
                    _emailController.text.trim(),
                    _contactController.text.trim(),
                  );
                  var result = jsonDecode(jsonEncode(response.data));
                  print(result);
                  // print(jsonDecode(result));
                  if (result["createUser"] != null) {
                    result["createUser"]["success"] == true
                        ? showToast("Successfully Registered")
                        : showToast("User Not Successfully Registered");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogInPage(),
                        ));
                  } else {
                    showToast("User Not Successfully Registered");
                  }
                },
                child: loginButton(_pwidth, _pheight),
              ),
              SizedBox(height: _pheight * 0.001),
              Container(
                child: Text("OR",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(height: _pheight * 0.001),
              GestureDetector(
                onTap: () async {
                  await SharedPref.getUserData().then(
                    (value) {
                      print(value);
                    },
                  );
                  // print();
                },
                child: googleButton(_pwidth, _pheight),
              ),
              SizedBox(height: _pheight * 0.001),
              fbButton(_pwidth, _pheight),
              SizedBox(height: _pheight * 0.001),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Existing User?",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(width: _pwidth * 0.01),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogInPage(),
                          ));
                    },
                    child: Container(
                      child: Text("Sign IN",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool emailValidation(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(
      pattern.toString(),
    );
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  Widget loginButton(double _pwidth, double _pheight) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding:
          EdgeInsets.only(left: 24.0, right: 24.0, top: 10.0, bottom: 12.0),
      child: Container(
        // onPressed:
        width: _pwidth * 0.1,
        height: _pheight * 0.06,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
        // color: Constants.buttonBackgroundColor,
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordField(double _pwidth, double _pheight,
      TextEditingController _passwordController, bool _passwordVisible) {
    return Container(
      width: _pwidth * 0.8,
      height: _pheight * 0.08,
      child: TextField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.visiblePassword,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              print(_passwordVisible);
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            child: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off),
          ),
          labelText: "Password",
        ),
      ),
    );
  }

  Widget emailField(
      double _pwidth, double _pheight, TextEditingController _emailController) {
    return Container(
      width: _pwidth * 0.8,
      height: _pheight * 0.08,
      child: TextField(
        controller: _emailController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email",
        ),
      ),
    );
  }

  Widget nameField(
      double _pwidth, double _pheight, TextEditingController _nameController) {
    return Container(
      width: _pwidth * 0.8,
      height: _pheight * 0.08,
      child: TextField(
        controller: _nameController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Name",
        ),
      ),
    );
  }

  Widget contactField(double _pwidth, double _pheight,
      TextEditingController _contactController) {
    return Container(
      width: _pwidth * 0.8,
      height: _pheight * 0.08,
      child: TextField(
        controller: _contactController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: "Contact No",
        ),
      ),
    );
  }
}

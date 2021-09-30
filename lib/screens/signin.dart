import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:userapp/components/signin/components.dart';
import 'package:userapp/screens/signUp.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late bool _passwordVisible = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    setState(() {
      _passwordVisible = false;
    });
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
              SizedBox(height: _pheight * 0.05),
              mainLogo(),
              SizedBox(
                height: _pheight * 0.02,
              ),
              headtext("Sign In"),
              SizedBox(height: _pheight * 0.01),
              emailField(_pwidth, _pheight, _emailController),
              SizedBox(height: _pheight * 0.01),
              Container(
                width: _pwidth * 0.8,
                height: _pheight * 0.1,
                child: TextField(
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
              SizedBox(
                height: _pheight * 0.002,
              ),
              forgotPassword(_pwidth),
              SizedBox(height: _pheight * 0.01),
              GestureDetector(
                onTap: () {},
                child: loginButton(_pwidth, _pheight),
              ),
              SizedBox(height: _pheight * 0.01),
              Container(
                child: Text("OR",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(height: _pheight * 0.01),
              GestureDetector(
                onTap: () {},
                child: googleButton(_pwidth, _pheight),
              ),
              SizedBox(height: _pheight * 0.01),
              fbButton(_pwidth, _pheight),
              SizedBox(height: _pheight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("New User?",
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
                            builder: (context) => RegistrationPage(),
                          ));
                    },
                    child: Container(
                      child: Text("Sign UP",
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
      height: _pheight * 0.1,
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
      height: _pheight * 0.1,
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
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Container headtext(String text) {
  return Container(
    child: Text(text,
        style: TextStyle(
          color: Colors.black45,
          fontSize: 30,
        )),
  );
}

Container mainLogo() {
  return Container(
    child: Image.asset("assets/images/logo.png"),
  );
}

Container fbButton(double _pwidth, double _pheight) {
  return Container(
    width: _pwidth,
    padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 10.0, bottom: 12.0),
    child: Container(
      // onPressed:
      width: _pwidth * 0.1,
      height: _pheight * 0.06,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color.fromRGBO(91, 0, 159, 1),
          borderRadius: BorderRadius.circular(10)),
      // color: Constants.buttonBackgroundColor,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: SvgPicture.asset(
                "assets/images/facebook.svg",
                height: 20,
                width: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(width: _pwidth * 0.03),
            Text(
              'Login with facebook',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Container googleButton(double _pwidth, double _pheight) {
  return Container(
    width: _pwidth,
    padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 10.0, bottom: 12.0),
    child: Container(
      // onPressed:
      width: _pwidth * 0.1,
      height: _pheight * 0.06,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color.fromRGBO(242, 0, 0, 1),
          borderRadius: BorderRadius.circular(10)),
      // color: Constants.buttonBackgroundColor,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: SvgPicture.asset(
                "assets/images/google-plus.svg",
                color: Colors.white,
                height: 20,
                width: 20,
              ),
            ),
            SizedBox(width: _pwidth * 0.03),
            Text(
              'Login with google',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Padding forgotPassword(double _pwidth) {
  return Padding(
    padding: EdgeInsets.only(left: _pwidth * 0.5),
    child: Container(
      child: Text("Forgot password?",
          style: TextStyle(
            color: Colors.black45,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          )),
    ),
  );
}

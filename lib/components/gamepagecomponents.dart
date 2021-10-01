import 'package:flutter/material.dart';

class GamePageWidgets {
  static Container jumpButton(double _height, double _width) {
    return Container(
      height: _height * 0.07,
      width: _width * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.blue),
      child: Center(
        child: Text(
          "Jump",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static Align gameObject() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 100,
        width: 100,
        child:
            CircleAvatar(backgroundImage: AssetImage("assets/images/ball.png")),
      ),
    );
  }
}

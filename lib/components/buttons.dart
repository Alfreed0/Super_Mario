import 'dart:ffi';

import 'package:flutter/material.dart';

typedef void IntCallback(int running);

class Buttons extends StatelessWidget {
  final functionUp;
  final functionLeft;
  final functionRight;
  final IntCallback onRunningChanged;
  static bool holdingButtonDown = false;


  Buttons({required this.onRunningChanged, this.functionUp, this.functionLeft, this.functionRight});

  bool isHoldingButtonDown() {
    return holdingButtonDown;
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTapDown: (details) {
            holdingButtonDown = true;
            functionLeft();
          },
          onTapUp: (details) {
            holdingButtonDown = false;
            onRunningChanged(0);
          },
          child: Container(
            height: 75,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown[300],
                border: Border.all(color: Colors.brown)),
            child: LayoutBuilder(builder: (context, constraints) {
              return Icon(
                Icons.keyboard_arrow_left_rounded,
                color: Colors.white,
                size: constraints.biggest.height,
              );
            }),
          ),
        ),
        GestureDetector(
          onTap: functionUp,
          child: Container(
            height: 75,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown[300],
                border: Border.all(color: Colors.brown)),
            child: LayoutBuilder(builder: (context, constraints) {
              return Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.white,
                size: constraints.biggest.height,
              );
            }),
          ),
        ),
        GestureDetector(
          onTapDown: (details) {
            holdingButtonDown = true;
            functionRight();
          },
          onTapUp: (details) {
            holdingButtonDown = false;
            onRunningChanged(0);
          },
          child: Container(
            height: 75,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown[300],
                border: Border.all(color: Colors.brown)),
            child: LayoutBuilder(builder: (context, constraints) {
              return Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.white,
                size: constraints.biggest.height,
              );
            }),
          ),
        )
      ],
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class JumpingMario extends StatelessWidget {
  final direction;
  final form;

  JumpingMario({this.direction, this.form});

  @override
  Widget build(BuildContext context) {
    if (direction == 'right') {
      return Container(
        height: 100,
        child: Image.asset('assets/imgs/' + form + '_mario_jumping.gif'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          height: 100,
          child: Image.asset('assets/imgs/' + form + '_mario_jumping.gif'),
        ),
      );
    }
  }
}

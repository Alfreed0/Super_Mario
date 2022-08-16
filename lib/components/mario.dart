import 'dart:math';

import 'package:flutter/material.dart';
import 'package:super_mario/components/movements.dart';

class Mario extends StatelessWidget {
  final direction;
  final run;

  Mario({this.direction, this.run});

  @override
  Widget build(BuildContext context) {
    if (direction == 'right') {
      return Container(
        height: 100,
        child: Movement(
          run: run,
        )
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          height: 100,
          child: Movement(
            run: run,
          )
        ),
      );
    }
  }
}
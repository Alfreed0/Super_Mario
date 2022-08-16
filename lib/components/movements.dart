import 'package:flutter/material.dart';

class Movement extends StatelessWidget {
  final run;
  final form;

  Movement({this.run, this.form});


  @override
  Widget build(BuildContext context) {
    if (run == 0) {
      return Image.asset(
              'assets/imgs/' + form + '_mario_standing.gif'
            );
    } else if (run == 1) {
      return Image.asset(
              'assets/imgs/' + form + '_mario_running_01.gif'
              
            );
    } else if (run == 2) {
      return Image.asset(
              'assets/imgs/' + form + '_mario_running_02.gif'
            );
    } else {
      return Image.asset(
              'assets/imgs/' + form + '_mario_running_03.gif'
            );
    }
  }
}
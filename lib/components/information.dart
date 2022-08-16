import 'dart:ffi';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';

class InformationBar extends StatelessWidget {
  final lives;
  final timer;
  final points;
  var font = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 20
    )
  );

  InformationBar({this.lives, this.timer, this.points});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'LIVES',
                  textAlign: TextAlign.center,
                  style: font,
                ),
                SizedBox(height: 10,),
                Text(
                  lives.toString(),
                  textAlign: TextAlign.center,
                  style: font,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'POINTS',
                  textAlign: TextAlign.center,
                  style: font,
                ),
                SizedBox(height: 10,),
                Text(
                  points.toString(),
                  textAlign: TextAlign.center,
                  style: font,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'TIME',
                  textAlign: TextAlign.center,
                  style: font,
                ),
                SizedBox(height: 10,),
                Text(
                  timer.toString(),
                  textAlign: TextAlign.center,
                  style: font,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
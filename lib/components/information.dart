import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationBar extends StatelessWidget {
  final lives;
  final timer;
  var font = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 20
    )
  );

  InformationBar({this.lives, this.timer});

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
                  'MARIO',
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
                  'WORLD',
                  textAlign: TextAlign.center,
                  style: font,
                ),
                SizedBox(height: 10,),
                Text(
                  '1-1',
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
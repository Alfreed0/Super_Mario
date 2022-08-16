import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
import 'package:super_mario/components/information.dart';
import 'package:super_mario/components/jump.dart';
import 'package:super_mario/components/mushroom.dart';
import 'dart:async';

import '../components/buttons.dart';
import '../components/mario.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1.12;
  static double shortY = 1.12;
  static double grownY = 1.065;
  static double currentY = shortY;
  static double mushX = 0.75;
  static double mushY = 1;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = 'right';
  String form = 'short';
  int run = 0;
  int lives = 3;
  int countDown = 999;
  int points = 0;
  int jumps = 0;
  bool gameOver = false;
  bool jumping = false;
  var font = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, fontSize: 40));

  void eatMushroom() {
    if ((marioX - mushX).abs() < 0.15 && (marioY - mushY).abs() < 0.15) {
      setState(() {
        mushX = 2;
        form = 'grown';
        currentY = grownY;
        marioY = currentY;
      });
    }
  }

  void countDownTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (countDown == 0) {
        timer.cancel();
        setState(() {
          gameOver = true;
        });
      } else {
        setState(() {
          countDown -= 1;
        });
      }
    });
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    if (jumping == false) {
      jumping = true;
      preJump();
      jumps += 1;

      if (pointsCounter()) {
        setState(() {
          points += 1;
        });
      }

      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialHeight - height > 1) {
          setState(() {
            marioY = currentY;
            jumping = false;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }

  void moveLeft() {
    direction = 'left';

    Timer.periodic(Duration(milliseconds: 100), (timer) {
      eatMushroom();
      if (Buttons(
            onRunningChanged: (running) {
              isRunning(running);
            },
          ).isHoldingButtonDown() ==
          true && marioX - 0.02 > -1) {
        setState(() {
          marioX -= 0.02;
          if (run < 4) {
            run += 1;
          } else {
            run = 1;
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveRight() {
    direction = 'right';

    Timer.periodic(Duration(milliseconds: 100), (timer) {
      eatMushroom();
      if (Buttons(
            onRunningChanged: (running) {
              isRunning(running);
            },
          ).isHoldingButtonDown() ==
          true && marioX + 0.02 < 1) {
        setState(() {
          marioX += 0.02;
          if (run < 4) {
            run += 1;
          } else {
            run = 1;
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  void isRunning(int running) {
    setState(() {
      run = running;
    });
  }

  bool pointsCounter() {
    if (jumps > 0 && jumps % 2 == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      countDownTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(children: [
              Container(
                color: Colors.blue[200],
                child: AnimatedContainer(
                  alignment: Alignment(marioX, marioY),
                  duration: Duration(milliseconds: 0),
                  child: jumping
                      ? JumpingMario(
                          direction: direction,
                          form: form,
                        )
                      : Mario(
                          direction: direction,
                          run: run,
                          form: form,
                        ),
                ),
              ),
              InformationBar(
                timer: countDown,
                lives: lives,
                points: points,
              ),
              gameOver
                  ? Center(
                      child: Text(
                        'GameOver',
                        style: font,
                      ),
                    )
                  : Text(''),
              Container(alignment: Alignment(mushX, mushY), child: Mushroom())
            ]),
          ),
          Container(
            height: 10,
            color: Colors.green[700],
          ),
          Expanded(
            child: Container(
                color: Colors.brown[700],
                child: Buttons(
                  onRunningChanged: (running) {
                    isRunning(running);
                  },
                  functionUp: jump,
                  functionLeft: moveLeft,
                  functionRight: moveRight,
                )),
          )
        ],
      ),
    );
  }
}

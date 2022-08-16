import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_mario/components/information.dart';
import 'package:super_mario/components/jump.dart';
import 'dart:async';

import '../components/buttons.dart';
import '../components/mario.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1.065;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = 'right';
  int run = 0;
  int lives = 3;
  int countDown = 10;
  bool gameOver = false;
  bool jumping = false;
  var font = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 40
    )
  );

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
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialHeight - height > 1) {
          setState(() {
            marioY = 1.065;
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
      if (Buttons(
            onRunningChanged: (running) {
              isRunning(running);
            },
          ).isHoldingButtonDown() ==
          true) {
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
      if (Buttons(
            onRunningChanged: (running) {
              isRunning(running);
            },
          ).isHoldingButtonDown() ==
          true) {
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
                        )
                      : Mario(
                          direction: direction,
                          run: run,
                        ),
                ),
              ),
              InformationBar(
                timer: countDown,
                lives: lives,
              ),
              gameOver
              ? Center(
                child: Text(
                  'GameOver',
                  style: font,
                ),
              )
              : Text('')
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

import 'dart:async';
import 'dart:math';

import 'package:brain_champs/details/values.dart';
import 'package:flutter/material.dart';

class BouncingBall extends StatefulWidget {
  @override
  _BouncingBallState createState() => _BouncingBallState();
}

class _BouncingBallState extends State<BouncingBall> with TickerProviderStateMixin{

  Timer _timer = new Timer(Duration(seconds: 0), (){});
  Timer sample = new Timer(Duration(seconds: 0), (){});
  int maxValue, maxNum;

  Color ballColor = Colors.green;
  Color numColor = Colors.red;

  int ball1, ball2, ball3, ball4, ball5;

  AnimationController controller1, controller2, controller3, controller4, controller5, timerController;
  Animation b1, b2, b3, b4, b5, timerAnimation;

  bool gameCompleted = false, start = false, pause = false;

  bool clicked = false;
  bool findMax;

  int time = 11, score=0;

  var random = new Random();

  void stopControllers(){
    controller1.stop();
    controller2.stop();
    controller3.stop();
    controller4.stop();
    controller5.stop();
    timerController.stop();
  }

  void showAlertDialog(BuildContext context){

    gameCompleted = true;

    stopControllers();

    //Buttons
    Widget playAgainButton = FlatButton(
        onPressed: (){
          Navigator.pop(context);       //To pop out from alert box
          Navigator.pushReplacementNamed(context, '/BouncingBall');
        },
        child: Text('Play Again')
    );

    Widget backButton = FlatButton(
        onPressed: (){
          Navigator.popUntil(context, ModalRoute.withName('/Eyes'));
        },
        child: Text('Back')
    );

    //Alert Contents
    AlertDialog alert = AlertDialog(
      title: (score > 0)? Text('Congrats'): Text('OOPS'),
      content: (score > 0)? Text('Your Score: $score'): Text('Your Score: 0'),
      actions: [
        playAgainButton,
        backButton
      ],
    );

    //Showing Alert
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return alert;
        }
    );

  }

  void result(int num){
    if(gameCompleted){

    }else{
      if(maxNum == num){
        score += 10;
        print('Awesome $score');
        // showAlertDialog(context, true);
        startRound();
      }else{
        score -= 15;
        print('Ahh $score');
        // showAlertDialog(context, false);
        startRound();
      }
    }

  }

  void startTimer(){
    _timer = new Timer(Duration(seconds: 1), (){
      start = true;
    });

    _timer = new Timer.periodic(Duration(seconds: 1),(timer){
      setState(() {
        if(!pause){
          time--;
        }
      });
      if(time<=0){
        _timer.cancel();
        showAlertDialog(context);
      }
      // print(time);
    });
  }

  void startRound(){
    pause = true; //For managing timer
    if(start){
      stopControllers();
    }

    if(random.nextInt(2) == 0){
      findMax = true;
    }else{
      findMax = false;
    }

    ball1 = random.nextInt(200);
    maxValue = 300-ball1;
    maxNum = 1;
    ball2 = random.nextInt(200);
    if(findMax){
      if(300-ball2 > maxValue){
        maxValue = 300-ball2;
        maxNum = 2;
      }
    }else{
      if(300-ball2 < maxValue){
        maxValue = 300-ball2;
        maxNum = 2;
      }
    }

    ball3 = random.nextInt(200);
    if(findMax){
      if(300-ball3 > maxValue){
        maxValue = 300-ball3;
        maxNum = 3;
      }
    }else{
      if(300-ball3 < maxValue){
        maxValue = 300-ball3;
        maxNum = 3;
      }
    }

    ball4 = random.nextInt(200);
    if(findMax){
      if(300-ball4 > maxValue){
        maxValue = 300-ball4;
        maxNum = 4;
      }
    }else{
      if(300-ball4 < maxValue){
        maxValue = 300-ball4;
        maxNum = 4;
      }
    }

    ball5 = random.nextInt(200);
    if(findMax){
      if(300-ball5 > maxValue){
        maxValue = 300-ball5;
        maxNum = 5;
      }
    }else{
      if(300-ball5 < maxValue){
        maxValue = 300-ball5;
        maxNum = 5;
      }
    }

    // print(random.nextDouble());
    // print("Ball1: ${300-ball1}");
    // print("Ball2: ${300-ball2}");
    // print("Ball3: ${300-ball3}");
    // print("Ball4: ${300-ball4}");
    // print("Ball5: ${300-ball5}");

    int time1, time2, time3, time4, time5;    //For dynamic timer
    do{
      time1 = random.nextInt(1000);
    }while(time1 < 100);
    do{
      time2 = random.nextInt(1000);
    }while(time2 < 100);
    do{
      time3 = random.nextInt(1000);
    }while(time3 < 100);
    do{
      time4 = random.nextInt(1000);
    }while(time4 < 100);
    do{
      time5 = random.nextInt(1000);
    }while(time5 < 100);

    controller1 = new AnimationController(
        duration: Duration(milliseconds: time1),
        vsync: this
    );
    controller2 = new AnimationController(
        duration: Duration(milliseconds: time2),
        vsync: this
    );
    controller3 = new AnimationController(
        duration: Duration(milliseconds: time3),
        vsync: this
    );
    controller4 = new AnimationController(
        duration: Duration(milliseconds: time4),
        vsync: this
    );
    controller5 = new AnimationController(
        duration: Duration(milliseconds: time5),
        vsync: this
    );

    b1 = Tween<double>(begin: 300, end: ball1.toDouble()).animate(controller1);
    b2 = Tween<double>(begin: 300, end: ball2.toDouble()).animate(controller2);
    b3 = Tween<double>(begin: 300, end: ball3.toDouble()).animate(controller3);
    b4 = Tween<double>(begin: 300, end: ball4.toDouble()).animate(controller4);
    b5 = Tween<double>(begin: 300, end: ball5.toDouble()).animate(controller5);

    controller1.repeat(reverse: true);
    controller2.repeat(reverse: true);
    controller3.repeat(reverse: true);
    controller4.repeat(reverse: true);
    controller5.repeat(reverse: true);

    if(!start){
      startTimer();
    }
    pause = false;
    timerController.forward();

    sample = Timer(Duration(milliseconds: 500), (){
      clicked = false;
    });
  }

  @override
  void initState() {

    timerController = new AnimationController(
        vsync: this,
      duration: Duration(seconds: 10),
    );

    timerAnimation = Tween<double>(begin: Values.width, end: 0).animate(timerController);

    startRound();

    super.initState();
  }

  @override
  void dispose() {
    timerController.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();

    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bouncing Ball'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // AnimatedContainer(
            //   width: (start)? 0: MediaQuery.of(context).size.width,
            //   height: 10.0,
            //   duration: Duration(seconds: 7),
            //   child: Container(
            //     color: (time < 2)? Colors.redAccent: Colors.green,
            //   ),
            // ),
            AnimatedBuilder(
                animation: timerController,
                builder: (context, child){
                  return Container(
                    width: timerAnimation.value,
                    height: 10.0,
                    child: Container(
                      color: (time < 4)? Colors.redAccent: Colors.green,
                    ),
                  );
                }
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              (findMax)? 'Which ball is bouncing higher?': 'Which ball is bouncing lower?'
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.9,  //400
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedBuilder(
                    animation: controller1,
                    builder: (context, child){
                      return Container(
                          margin: EdgeInsets.only(top: b1.value),
                          child: Number(num: 1, color: ballColor, callback: (){})
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: controller2,
                    builder: (context, child){
                      return Container(
                          margin: EdgeInsets.only(top: b2.value),
                          child: Number(num: 2, color: ballColor, callback: (){})
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: controller3,
                    builder: (context, child){
                      return Container(
                          margin: EdgeInsets.only(top: b3.value),
                          child: Number(num: 3, color: ballColor, callback: (){})
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: controller4,
                    builder: (context, child){
                      return Container(
                          margin: EdgeInsets.only(top: b4.value),
                          child: Number(num: 4, color: ballColor, callback: (){})
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: controller5,
                    builder: (context, child){
                      return Container(
                          margin: EdgeInsets.only(top: b5.value),
                          child: Number(num: 5, color: ballColor, callback: (){})
                      );
                    },
                  ),
                ],
              ),

            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Number(num: 1, color: numColor, callback: (){
                  if(!clicked){
                    clicked = true;
                    result(1);
                  }
                  // print(clicked);
                }),
                Number(num: 2, color: numColor, callback: (){
                  if(!clicked){
                    clicked = true;
                    result(2);
                  }
                  // print(clicked);
                }),
                Number(num: 3, color: numColor, callback: (){
                  if(!clicked){
                    clicked = true;
                    result(3);
                  }
                  // print(clicked);
                }),
                Number(num: 4, color: numColor, callback: (){
                  if(!clicked){
                    clicked = true;
                    result(4);
                  }
                  // print(clicked);
                }),
                Number(num: 5, color: numColor, callback: (){
                  if(!clicked){
                    clicked = true;
                    result(5);
                  }
                  // print(clicked);
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Number extends StatelessWidget {
  int num;
  Color color;
  VoidCallback callback;
  Number({this.num, this.color, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ClipOval(
          child: Material(
            color: color,
            child: SizedBox(
              width: 50,
              height: 50,
              child: InkWell(
                splashColor: Colors.orange,
                child: Center(
                  child: Text('$num'),
                ),
                onTap: callback,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'dart:async';
import 'dart:math';

import 'package:analog_clock/analog_clock_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockDifference extends StatefulWidget {
  @override
  _ClockDifferenceState createState() => _ClockDifferenceState();
}

class _ClockDifferenceState extends State<ClockDifference> with TickerProviderStateMixin{

  int min1, min2;
  int answer;

  int score = 0;

  AnimationController _controller;
  Animation rotate1, rotate2;

  Timer _timer = new Timer(Duration(seconds: 0), (){});

  Random random = new Random();

  int time = 10;
  bool start = false, gameCompleted = false;

  Widget clock(int min){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width/1.96, //200
        height: MediaQuery.of(context).size.width/1.96,  //same as width
        decoration: BoxDecoration(
          color: Colors.lightGreenAccent,
            border: Border.all(width: 2.0, color: Colors.black, style: BorderStyle.solid),
            shape: BoxShape.circle
        ),
        child: CustomPaint(
          painter: AnalogClockPainter(
              datetime: DateTime(2020, 1, 1, 0, min),
              showSecondHand: false,
              showDigitalClock: false,
              hourHandColor: Colors.transparent,
              showAllNumbers: true,
            numberColor: Colors.deepOrangeAccent
          ),
          child: Center(

          ),
        ),

      ),
    );
  }

  void initialTime(){
    min1 = random.nextInt(60);
    min2 = random.nextInt(60);

    int diff;
    if(min2 < min1){
      diff = 60+min2 - min1;
    }else{
      diff = min2 - min1;
    }

    answer = diff ~/ 5;
  }

  void startTimer(){
    _timer = new Timer(Duration(seconds: 1), (){
      setState(() {
        start = true;
      });
    });

    _timer = new Timer.periodic(Duration(seconds: 1), (e){
      setState(() {
        time--;
      });

      if(time==0){
        _timer.cancel();
        showAlertDialog(context);
      }
    });
  }

  void showAlertDialog(BuildContext context){
    gameCompleted = true;

    _controller.stop();
    _timer.cancel();

    //Buttons
    Widget playAgainButton = FlatButton(
        onPressed: (){
          Navigator.pop(context);       //To pop out from alert box
          Navigator.pushReplacementNamed(context, '/ClockDifference');
        },
        child: Text('Play Again')
    );

    Widget backButton = FlatButton(
        onPressed: (){
          Navigator.popUntil(context, ModalRoute.withName('/Logical'));
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

  void result(int n){
    if(!gameCompleted){
      print(answer);
      _controller.stop();
      _controller.dispose();
      if(n == answer){
        // showAlertDialog(context, true);
        // print('YES');
        score += 10;
        startRound();
      }else{
        // showAlertDialog(context, false);
        // print('NO');
        score -= 15;
        startRound();
      }
    }
  }

  void startRound(){
    _controller = new AnimationController(
        vsync: this,
        duration: Duration(seconds: 3)
    );

    initialTime();

    rotate1 = IntTween(begin: min1, end: 60+min1).animate(_controller);
    rotate2 = IntTween(begin: min2, end: 60+min2).animate(_controller);

    _controller.repeat();
  }

  @override
  void initState() {
    startRound();
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clock Difference'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Center(
          child: Column(
            children: [
              AnimatedContainer(
                width: (start)? 0: MediaQuery.of(context).size.width,
                height: 10.0,
                duration: Duration(seconds: 9),
                child: Container(
                  color: (time < 3)? Colors.redAccent: Colors.green,
                ),
              ),
              AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child){
                    return clock(rotate1.value);
                  }
              ),
              AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child){
                    return clock(rotate2.value);
                  }
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Number(num: 0, callback: (){
                    result(0);
                  }),
                  Number(num: 1, callback: (){
                    result(1);
                  }),
                  Number(num: 2, callback: (){
                    result(2);
                  }),
                  Number(num: 3, callback: (){
                    result(3);
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Number(num: 4, callback: (){
                    result(4);
                  }),
                  Number(num: 5, callback: (){
                    result(5);
                  }),
                  Number(num: 6, callback: (){
                    result(6);
                  }),
                  Number(num: 7, callback: (){
                    result(7);
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Number(num: 8, callback: (){
                    result(8);
                  }),
                  Number(num: 9, callback: (){
                    result(9);
                  }),
                  Number(num: 10, callback: (){
                    result(10);
                  }),
                  Number(num: 11, callback: (){
                    result(11);
                  }),
                ],
              ),
            ],

          ),
        ),
      ),
    );
  }
}

class Number extends StatelessWidget {
  int num;
  VoidCallback callback;
  Number({this.num, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ClipOval(
          child: Material(
            color: Colors.yellow,
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
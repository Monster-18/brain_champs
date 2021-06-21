import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:brain_champs/details/canvas/4Stars.dart';
import 'package:brain_champs/details/canvas/3Stars.dart';
import 'package:brain_champs/details/canvas/5Stars.dart';

class Stars extends StatefulWidget {
  @override
  _StarsState createState() => _StarsState();
}

class _StarsState extends State<Stars> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Timer _timer = new Timer(Duration(seconds: 0), (){});
  Timer _unWanted = new Timer(Duration(seconds: 0), (){});

  //Stars Count - 3
  int count;

  Random random = new Random();

  bool start=false, gameCompleted = false;

  int time = 7;
  int score = 0;

  void showAlertDialog(BuildContext context, bool won){

    _unWanted.cancel();
    _timer.cancel();
    _controller.stop();
    gameCompleted = true;

    //Buttons
    Widget playAgainButton = FlatButton(
        onPressed: (){
          Navigator.pop(context);       //To pop out from alert box
          Navigator.pushReplacementNamed(context, '/Stars');
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
        builder: (BuildContext context){
          return alert;
        }
    );

  }

  void result(int num){
    if(!gameCompleted){
      if(num == count){
        // print('WOW');
        // showAlertDialog(context, true);
        score += 10;
      }else{
        // print('OOPS');
        // showAlertDialog(context, false);
        score -= 15;
      }
      newRound();
    }
  }

  void newRound(){
    _controller.stop();

    _unWanted = Timer(Duration(milliseconds: 300), (){
      count = random.nextInt(3) + 3;

      _controller.repeat();
    });

  }

  @override
  void initState() {

    _controller = new AnimationController(
        vsync: this,
      duration: Duration(milliseconds: 700)
    );

    newRound();

    _timer = new Timer(Duration(milliseconds: 500), (){
      start = true;
    });
    _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time--;
      });
      if(time <= 0){
        _timer.cancel();
        showAlertDialog(context, false);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _unWanted.cancel();
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Stars'),
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
            AnimatedContainer(
              width: (start)? 0: MediaQuery.of(context).size.width,
              height: 10.0,
              duration: Duration(seconds: 6),
              child: Container(
                color: (time < 3)? Colors.redAccent: Colors.green,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
                'Count of Stars'
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.9,   //400
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
              ),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width/2.06, //190
                  height: MediaQuery.of(context).size.height/4.11,  //190
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child){
                      return Transform.rotate(
                        child: (count == 3)?
                                  Star3():
                              (count == 4)?
                                  Star4():
                                  Star5(),
                        angle: _controller.value * 6.3,
                      );
                    },
                  ),
                ),
              ),

            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Number(num: 1, callback: (){
                  result(1);
                  // print(clicked);
                }),
                Number(num: 2, callback: (){
                  result(2);
                  // print(clicked);
                }),
                Number(num: 3, callback: (){
                  result(3);
                  // print(clicked);
                }),
                Number(num: 4, callback: (){
                  result(4);
                  // print(clicked);
                }),
                Number(num: 5, callback: (){
                  result(5);
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
  VoidCallback callback;
  Number({this.num, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ClipOval(
          child: Material(
            color: Colors.red,
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

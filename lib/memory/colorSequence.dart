import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:brain_champs/details/values.dart';

class ColorSequence extends StatefulWidget {

  @override
  _ColorSequenceState createState() => _ColorSequenceState();
}

class _ColorSequenceState extends State<ColorSequence> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation animateTimer;

  //For disposing timer if the user exit while any timer is working
  Timer _timer = new Timer(Duration(seconds: 0), (){});
  Timer _gameTimer = new Timer(Duration(seconds: 0), (){});
  bool timerStarts= false;

  //For showing images one by one
  bool img1 = false;
  bool img2 = false;
  bool img3 = false;

  //Sources of images in the sequence
  Color src1;
  Color src2;
  Color src3;

  //Used to block everything till the sequence showed
  bool gameStarts = false;
  bool gameEnded = false;
  bool start = false;

  bool timeStarts = true;   //For showing time starts message

  int time = 9;

  //Images clicked by User
  Color first;
  Color second;
  Color last;

  int status = 0;

  int score=0;

  Widget displayColor(Color imgName){
    return Container(
      width: MediaQuery.of(context).size.width/4.909090909,        //80
      height: MediaQuery.of(context).size.height/9.763636364,       //80
      decoration: BoxDecoration(
        color: imgName,
          border: Border.all(
              color: Colors.black,
              width: 2
          )
      ),
    );
  }

  Widget emptyContainer(){
    return Container(
      width: MediaQuery.of(context).size.width/4.909090909,    //80
      height: MediaQuery.of(context).size.height/9.763636364,   //80
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black,
              width: 2
          )
      ),
    );
  }

  Widget clickColor(Color imgName){
    return GestureDetector(
      onTap: (){
        if(!gameEnded){
          if(gameStarts){

            //Level 1 to 3
            if(status == 0){
              setState(() {
                first = imgName;
              });
            }else if(status == 1){
              setState(() {
                second = imgName;
              });
            }else if(status == 2){
              setState(() {
                last = imgName;
              });

              if(src1 == first && src2 == second && src3 == last){
                print('Won');
                score += 10;
                _timer = Timer(Duration(milliseconds: 500), (){
                  startGame();
                  // showAlertDialog(context, true);
                });
              }else{
                print('Lost');
                score -= 15;
                _timer = Timer(Duration(milliseconds: 500), (){
                  if(gameStarts){
                    startGame();
                  }
                  // showAlertDialog(context, false);
                });
              }
            }

            status++;
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width/4.909090909,   //80
        height: MediaQuery.of(context).size.height/9.763636364,   //80
        decoration: BoxDecoration(
          color: imgName,
            border: Border.all(
                color: Colors.black,
                width: 2
            )
        ),
      ),
    );
  }

  void startTimer(){
    _gameTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
      if(time == 0){
        timer.cancel();
        showAlertDialog(context);
        setState(() {
          gameStarts = false;
        });
      }else{
        setState(() {
          if(!timeStarts){
            time--;
          }
        });
      }
    });
  }

  void endGame(){
    _timer.cancel();
    _gameTimer.cancel();
  }

  void showAlertDialog(BuildContext context){

    gameStarts = false;
    gameEnded = true;
    endGame();
    // time = -1;

    //Buttons
    Widget playAgainButton = FlatButton(
        onPressed: (){
          Navigator.pop(context);       //To pop out from alert box
          Navigator.pushReplacementNamed(context, '/ColorSequence');
        },
        child: Text('Play Again')
    );

    Widget backButton = FlatButton(
        onPressed: (){
          Navigator.popUntil(context, ModalRoute.withName('/Memory'));
        },
        child: Text('Back')
    );

    //Alert Contents
    AlertDialog alert = AlertDialog(
      title: (score < 10)? Text('Oops'): Text('Congrats'),
      content: (score < 10)? Text('Your Score: 0'): Text('Your Score: $score'),
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

  void startGame(){
    if(!gameEnded){
      gameStarts = false;
      timeStarts = true;
      start = false;
      _controller.stop();
      first = second = last = null;
      status = 0;

      var random = new Random();
      var sourceIndex = [0,1,2,3,0];

      //Level 1 to 3
      for(var i=0; i<3; i++){
        sourceIndex[i] = random.nextInt(4);
      }

      src1 = Values.colors[sourceIndex[0]];
      src2 = Values.colors[sourceIndex[1]];
      src3 = Values.colors[sourceIndex[2]];

      _timer = new Timer(Duration(seconds: 3), (){
        _timer = Timer(Duration(seconds: 1), (){
          if(!mounted) return;    //Not allow setState() to work if the page is not mounted
          setState(() {
            img1 = true;
          });
        });
        _timer = Timer(Duration(seconds: 2), (){
          if(!mounted) return;    //Not allow setState() to work if the page is not mounted
          setState(() {
            img2 = true;
          });
        });
        _timer = Timer(Duration(seconds: 3), (){
          if(!mounted) return;    //Not allow setState() to work if the page is not mounted
          setState(() {
            img3 = true;
          });
        });
        _timer = Timer(Duration(seconds: 5), (){
          if(!mounted) return;    //Not allow setState() to work if the page is not mounted
          setState(() {
            img1 = img2 = img3 = false;
            gameStarts = true;
            start = true;
            _timer = Timer(Duration(seconds: 1), (){
              if(!mounted) return;    //Not allow setState() to work if the page is not mounted
              setState(() {
                timeStarts = false;
                _controller.forward();
              });
              if(!timerStarts){
                startTimer();
                timerStarts = true;
              }
            });
          });
        });
      });
    }
  }

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 9)
    );

    animateTimer = Tween<double>(begin: Values.width, end: 0).animate(_controller);

    startGame();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    _gameTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //Widgets List
    List<Widget> sequenceList = [
                                  (img1)?
                                  displayColor(src1):
                                  emptyContainer(),
                                  (img2)?
                                  displayColor(src2):
                                  emptyContainer(),
                                  (img3)?
                                  displayColor(src3):
                                  emptyContainer(),
                                ];

    List<Widget> inputList = [
                              (first.toString().isNotEmpty)?
                              displayColor(first):
                              emptyContainer(),
                              (second.toString().isNotEmpty)?
                              displayColor(second):
                              emptyContainer(),
                              (last.toString().isNotEmpty)?
                              displayColor(last):
                              emptyContainer(),
                            ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Find the Sequence'),
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
            //   duration: Duration(seconds: 12),
            //   child: Container(
            //     color: (time < 5)? Colors.redAccent: Colors.green,
            //   ),
            // ),
            AnimatedBuilder(
                animation: _controller,
                builder: (context, child){
                  return Container(
                    width: animateTimer.value,
                    height: 10.0,
                    child: Container(
                      color: (time < 3)? Colors.redAccent: Colors.green,
                    ),
                  );
                }
            ),
            Container(
              height: MediaQuery.of(context).size.height - 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      (!gameStarts)?
                      Text('Remember this sequence'):
                      (timeStarts)?
                      Text('Your time starts now!!!'):
                      Text(''),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/15.62181818,   //50
                      ),
                      (!gameStarts)?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: sequenceList,
                      ):
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: inputList,
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          clickColor(Values.colors[0]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          clickColor(Values.colors[1]),
                          clickColor(Values.colors[2]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          clickColor(Values.colors[3]),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

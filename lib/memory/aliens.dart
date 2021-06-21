import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:brain_champs/details/values.dart';

//Canvas
import 'package:brain_champs/details/canvas/ufo.dart';
import 'package:brain_champs/details/canvas/person.dart';

class Aliens extends StatefulWidget {
  @override
  _AliensState createState() => _AliensState();
}

class _AliensState extends State<Aliens> with SingleTickerProviderStateMixin{

  TextEditingController aliensController = new TextEditingController();

  Timer _timer = new Timer(Duration(seconds: 0), (){});

  //For Opacity
  bool startO;

  //Animation Done
  bool done = false;

  //Enable User Input
  bool enable = true;

  AnimationController _controller;
  Animation slideLeft, slideTop, slideDown, slideRight;

  CurvedAnimation curveLeft, curveTop, curveDown, curveRight;

  bool left = true, top = false, down = false, right= false;

  bool startOut = false;

  int input, output, count=0;

  var random = new Random();

  void showAlertDialog(BuildContext context, bool won){

    //Buttons
    Widget playAgainButton = FlatButton(
        onPressed: (){
          Navigator.pop(context);       //To pop out from alert box
          Navigator.pushReplacementNamed(context, '/Aliens');
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
      title: (won)? Text('Congrats'): Text('OOPS'),
      content: (won)? Text('You Won'): Text('You Lost'),
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

  void inAndOut(){
    setState(() {
      startO = false;
    });
    startOut = false;
    print(count);
    // print('After Displaying Count');
    if(count > 10){
      setState(() {
        done = true;
        _controller.stop();
      });
    }else{
      // print('Entered Else');
      _controller.reset();
      do{
        input = random.nextInt(4);
      }while(input == 0);

      // do{
      //   output = random.nextInt(input);
      // }while(output == 0 || output == 1);

      // input = random.nextInt(8);
      output = random.nextInt(input);

      count += input - output;
      // print('Before Reset');
      _timer = Timer(Duration(seconds: 1), (){

        _controller.forward();
        setState(() {
          startO = true;
        });

      });
    }
  }

  void settingAnimations(){
    curveLeft = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0, 0.2,
        curve: Curves.ease,
      ),
    );

    curveTop = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.2, 0.5,
        curve: Curves.ease,
      ),
    );

    curveDown = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.5, 0.8,
        curve: Curves.ease,
      ),
    );

    curveRight = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.8, 1.0,
        curve: Curves.ease,
      ),
    );

    slideLeft = Tween<double>(begin: 0, end: 150).animate(curveLeft);
    slideTop = Tween<double>(begin: 100, end: 0).animate(curveTop);
    slideDown = Tween<double>(begin: 0, end: 100).animate(curveDown);
    slideRight = Tween<double>(begin: 150, end: 260).animate(curveRight);

    slideLeft.addListener(() {
      if(slideLeft.value > 0){
        left = true;
        right = false;
        top = false;
        down = false;
      }
    });

    slideTop.addListener(() {
      if(slideTop.value < 100){
        left = false;
        right = false;
        top = true;
        down = false;
      }
    });

    slideDown.addListener(() {
      if(slideDown.value > 0){
        startOut = true;
        left = false;
        right = false;
        top = false;
        down = true;
      }
    });

    slideRight.addListener(() {
      if(slideRight.value > 150){
        left = false;
        right = true;
        top = false;
        down = false;
      }
    });

    inAndOut();


  }

  @override
  void initState() {

    _controller = new AnimationController(
        vsync: this,
      duration: Duration(seconds: 5)
    );

    settingAnimations();

    _controller.addListener(() {
      if(_controller.isCompleted){
        inAndOut();
      }

      if(_controller.isDismissed){
        // print('Reset');
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Aliens'),
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
          child: (count > 10 && done)?
              Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        enabled: enable,
                        controller: aliensController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Count of People inside UFO',
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        onPressed: (){
                          // print(aliensController.text);
                          setState(() {
                            enable = false;
                          });

                          if(aliensController.text.compareTo(count.toString()) == 0){
                            // print('Good');
                            showAlertDialog(context, true);
                          }else{
                            // print('Lose');
                            showAlertDialog(context, false);
                          }
                        },
                        color: Colors.blue,
                        child: Text('OK'),
                      ),
                    ],
                  ),
                ),
              ):
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child){
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 300,
                    height:200,
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       image:AssetImage(
                    //         'assets/Aliens.png'
                    //       ),
                    //       fit: BoxFit.cover,
                    //     )
                    // ),
                    child: Center(
                      child: SizedBox(
                        child: UFO(),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Opacity(
                        opacity: (!startO)? 0:
                                  (top)? slideTop.value/100: (down)? slideDown.value/100:
                                  1,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: (left || right)? 100:
                                    (top)? slideTop.value:
                                    slideDown.value,
                              left: (top || down)? 150:
                                    (left)? slideLeft.value:
                                        slideRight.value
                          ),
                          width: 100,
                          height: 100,
                          // decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //       image:AssetImage(
                          //           (startOut)?
                          //           'assets/${Values.aliens[output]}.png':
                          //           'assets/${Values.aliens[input]}.png'
                          //       ),
                          //       fit: BoxFit.cover,
                          //     )
                          // ),
                          child: (startOut)?
                                  Person(count: output+1):
                                  Person(count: input+1),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(top: slideTop.value, left: 150),
                      //   width: 100,
                      //   height: 100,
                      //   color: Colors.blue,
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(top: slideDown.value, left: 150),
                      //   width: 100,
                      //   height: 100,
                      //   color: Colors.blue,
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 100, left: slideRight.value),
                      //   width: 100,
                      //   height: 100,
                      //   color: Colors.blue,
                      // ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}





















// import 'dart:async';
// import 'dart:math';
//
// import 'package:brain_champs/details/values.dart';
// import 'package:flutter/material.dart';
//
// class Aliens extends StatefulWidget {
//   @override
//   _AliensState createState() => _AliensState();
// }
//
// class _AliensState extends State<Aliens> {
//
//   Timer _timer = new Timer(Duration(seconds: 0), (){});
//   Timer _timerMain = new Timer(Duration(seconds: 0), (){});
//
//   double top = 100;
//   double left = 0;
//   double right = 300;
//   int count, alien;
//
//   int iterate = 0;
//
//   bool start = false;
//
//   var random = new Random();
//
//   void animate2(){
//     _timer = Timer.periodic(Duration(milliseconds: 500), (timer){
//       if(top == 0){
//         _timer.cancel();
//         animate3();
//       }else{
//         setState(() {
//           top -= 50;
//         });
//       }
//     });
//   }
//
//   void animate3(){
//     alien = random.nextInt(alien);
//     count -= alien;
//     _timer = Timer.periodic(Duration(milliseconds: 500), (timer){
//       if(top == 100){
//         _timer.cancel();
//         animate4();
//       }else{
//         setState(() {
//           top += 50;
//         });
//       }
//     });
//   }
//
//   void animate4(){
//     _timer = Timer.periodic(Duration(milliseconds: 500), (timer){
//       if(left == 300){
//         _timer.cancel();
//         print(count);
//         start = false;
//       }else{
//         setState(() {
//           left += 100;
//         });
//       }
//     });
//   }
//
//   void animate(){
//     count = 0;
//     setState(() {
//       top = 100;
//       left = 0;
//       right = 300;
//       do{
//         alien = random.nextInt(4);
//       }while(alien == 0);
//       start = true;
//     });
//     count += alien;
//     _timer = Timer.periodic(Duration(milliseconds: 500), (timer){
//       if(right == 0){
//         _timer.cancel();
//         animate2();
//       }else{
//         setState(() {
//           right -= 100;
//         });
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _timerMain = Timer.periodic(Duration(seconds: 2), (timer) {
//       if(!start){
//         if(iterate == 4){
//           _timerMain.cancel();
//         }
//         animate();
//         iterate++;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Aliens'),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 150.0,
//                   height: 150.0,
//                   color: Colors.red,
//                 ),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.all(2.0),
//               child: (start)? AnimatedContainer(
//                 margin: EdgeInsets.only(top: top, left: left, right: right),
//                 // color: (top == 0 || left == 300)? Colors.transparent: Colors.blue,
//                 width: 50,
//                 height: 50,
//                 duration: (start)? Duration(seconds: 1): Duration(seconds: 0),
//                 child: (top == 0 || left == 300)?
//                 Container():
//                 Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage('assets/${Values.fruits[alien]}.png')
//                     ),
//                   ),
//                 ),
//               ): Container(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
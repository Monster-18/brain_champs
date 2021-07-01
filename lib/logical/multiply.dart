import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Multiply extends StatefulWidget {
  @override
  _MultiplyState createState() => _MultiplyState();
}

class _MultiplyState extends State<Multiply> {

  TextEditingController mulController = new TextEditingController();
  Timer _timer = new Timer(Duration(seconds: 0), (){});

  //Multiply Numbers
  int x, y, answer;

  //Enable TextField
  bool enable = true;

  bool start = false;

  //No. of Correct Answers
  int count=0;
  int score = 0;

  int time = 15;

  Random random = new Random();

  void showAlertDialog(BuildContext context){

    //Buttons
    Widget playAgainButton = FlatButton(
        onPressed: (){
          Navigator.pop(context);       //To pop out from alert box
          Navigator.pushReplacementNamed(context, '/Multiply');
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
      title: (score <= 0)? Text('OOPS'): Text('Congrats'),
      content: (score <= 0)? Text('Your Score: 0'): Text("Your Score: $score"),
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

  void randomMultiply(){
    x = random.nextInt(20);
    y = random.nextInt(20);

    answer = x*y;
  }

  void startTimer(){
    _timer = new Timer(Duration(seconds: 1), (){
      setState(() {
        start = true;
      });
    });

    _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      time--;
      if(time<=0){
        _timer.cancel();
        setState(() {
          enable = false;
        });
        print(count);
        showAlertDialog(context);
      }
    });
  }

  @override
  void initState() {
    randomMultiply();
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiply'),
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
              duration: Duration(seconds: 14),
              child: Container(
                color: (time < 3)? Colors.redAccent: Colors.green,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/7.1,    //110
            ),
            Text(
              '$x x $y',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60.0
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/13,  //60
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      enabled: enable,
                      controller: mulController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Result',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: (){

                        if(time > 0){
                          if(mulController.text.isNotEmpty){
                            if(int.parse(mulController.text) == answer){
                              // count++;
                              score += 10;
                              // print('Great');
                            }else{
                              // print('Wrong');
                              score -= 15;
                            }
                          }else{
                            // print('Enter the answer');
                            score -= 15;
                          }

                          randomMultiply();
                          setState(() {
                            mulController.text = '';
                          });
                        }

                      },
                      child: Text(
                          'Next',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

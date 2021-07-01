import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:brain_champs/details/values.dart';

class MatchPairs extends StatefulWidget {
  @override
  _MatchPairsState createState() => _MatchPairsState();
}

class _MatchPairsState extends State<MatchPairs> {

  Timer _timer = new Timer(Duration(seconds: 0), (){});

  List cards = [
    {'num': 1, 'selected': false},
    {'num': 2, 'selected': false},
    {'num': 3, 'selected': false},
    {'num': 4, 'selected': false},
    {'num': 5, 'selected': false},
    {'num': 6, 'selected': false},
    {'num': 7, 'selected': false},
    {'num': 8, 'selected': false},
    {'num': 1, 'selected': false},
    {'num': 2, 'selected': false},
    {'num': 3, 'selected': false},
    {'num': 4, 'selected': false},
    {'num': 5, 'selected': false},
    {'num': 6, 'selected': false},
    {'num': 7, 'selected': false},
    {'num': 8, 'selected': false},
  ];

  bool start = false, stop = false;

  int count = 0;
  int time = 20;
  int score = 20; //MaxScore 400 = 20*20-->Time

  int selectedIndex;
  bool selected = false;

  void startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(time == 0){
        _timer.cancel();
        stop = true;
        showAlertDialog(context, false);
      }else{
        setState((){
          time--;
        });
      }
    });
  }

  void showAlertDialog(BuildContext context, bool won){

    if(won){
      score = score*time;
    }

    //Buttons
    Widget playAgainButton = FlatButton(
        onPressed: (){
          Navigator.pop(context);       //To pop out from alert box
          Navigator.pushReplacementNamed(context, '/MatchPairs');
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
      content: (won)? Text('Your Score: $score'): Text('Your Score: 0'),
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
  
  Widget card(int index){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: (){
          if(!start){
            start = true;
            startTimer();
          }
          if(!stop){
            if(cards[index]['selected'] == false){
              if(selected){
                setState(() {
                  cards[index]['selected'] = true;
                  selected = false;
                });

                if(selectedIndex != index){
                  if(cards[selectedIndex]['num'] == cards[index]['num']){
                    count += 2;
                  }else{
                    Timer(Duration(milliseconds: 500), (){
                      setState(() {
                        cards[index]['selected'] = false;
                        cards[selectedIndex]['selected'] = false;
                      });
                    });
                  }
                }else{
                  setState(() {
                    cards[index]['selected'] = false;
                  });
                }
              }else{
                setState(() {
                  selected = true;
                  selectedIndex = index;
                  cards[index]['selected'] = true;
                });
              }
            }
          }

          if(count == 16){
            print('End');
            _timer.cancel();      //Stop Timer
            stop = true;
            showAlertDialog(context, true);
          }
          // print(index);
        },
        child: Container(
          width: MediaQuery.of(context).size.width/4.9,    //80
          height: MediaQuery.of(context).size.width/4.9,   //Same as width
          decoration: (cards[index]['selected'])?
                      BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
                          image: DecorationImage(
                            image:AssetImage(
                                'assets/${Values.fruits[cards[index]['num']-1]}.png'
                            ),
                            fit: BoxFit.cover,
                          )
                      ):
                      BoxDecoration(
                        color: Colors.lightBlueAccent,
                        border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
                        image: DecorationImage(
                          image:AssetImage('assets/question.png'),
                          fit: BoxFit.contain,
                        )
                      ),
          child: Center(
            // child: (cards[index]['selected'])?
            //         Text(
            //             '${cards[index]['num']-1}',
            //           style: TextStyle(
            //             fontSize: 24.0,
            //             fontWeight: FontWeight.bold
            //           ),
            //         ):
            //         Text(''),
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var list = [];
    var random = new Random();
    for(int i=1; i<=7; i++){
      bool flag = false;
      int index1, index2;
      do{
        index1 = random.nextInt(16);
        if(list.contains(index1)){
          flag = true;
        }else{
          flag = false;
          list.add(index1);
        }
      }while(flag);

      flag = false;
      do{
        index2 = random.nextInt(16);
        if(list.contains(index2)){
          flag = true;
        }else{
          flag = false;
          list.add(index2);
        }
      }while(flag);

      cards[index1]['num'] = i;
      cards[index2]['num'] = i;

    }

    int count = 0;
    for(int j=0; j<16; j++){
      if(list.contains(j)){

      }else{
        cards[j]['num'] = 8;
        count++;
      }
      if(count == 2){
        break;
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Match The Pairs'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimatedContainer(
              width: (start)? 0: MediaQuery.of(context).size.width,
              height: 10.0,
              duration: Duration(seconds: 20),
              child: Container(
                color: (time < 6)? Colors.redAccent: Colors.green,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      card(0),
                      card(1),
                      card(2),
                      card(3)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      card(4),
                      card(5),
                      card(6),
                      card(7)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      card(8),
                      card(9),
                      card(10),
                      card(11)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      card(12),
                      card(13),
                      card(14),
                      card(15)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

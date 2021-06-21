import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:brain_champs/details/values.dart';

class CorrectImage extends StatefulWidget {
  @override
  _CorrectImageState createState() => _CorrectImageState();
}

class _CorrectImageState extends State<CorrectImage> {

  // var list = [
  //   [1, 2, 3],
  //   [4, 9, 8],
  //   [7, 6, 5]
  // ];
  var list;

  Timer _timer = new Timer(Duration(seconds: 0), (){});

  int time = 20;

  bool selected =false;
  int selectedRow=-1, selectedCol=-1;

  bool start = false;
  bool gameCompleted = false;

  Random random = new Random();

  void suffledImage(){
    int n = random.nextInt(4);
    switch(n){
      case 0:
        list = [
          [1, 2, 3],
          [4, 9, 8],
          [7, 6, 5]
        ];
        break;
      case 1:
        list = [
          [2, 4, 3],
          [1, 5, 6],
          [7, 8, 9]
        ];
        break;
      case 2:
        list = [
          [1, 5, 2],
          [4, 9, 3],
          [7, 8, 6]
        ];
        break;
      case 3:
        list = [
          [9, 1, 3],
          [4, 2, 5],
          [7, 8, 6]
        ];
        break;
    }
  }

  void showAlertDialogBox(BuildContext context, bool win){
    gameCompleted = true;

    Widget playAgain = FlatButton(
        onPressed: (){
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/CorrectImage');
        },
        child: Text(
          'Play Again'
        )
    );

    Widget backBtn = FlatButton(
        onPressed: (){
          Navigator.popUntil(context, ModalRoute.withName('/Logical'));
        },
        child: Text(
            'Back'
        )
    );

    AlertDialog alert = AlertDialog(
      title: (win)? Text('Congrats'): Text('Oops'),
      content: (win)? Text('You Won'): Text('You Lost'),
      actions: [
        playAgain,
        backBtn
      ],
    );

    showDialog(
      context: context,
      builder: (context){
        return alert;
      }
    );
  }

  void result(){
    int num = 1;
    bool won = true;

    for(int i=0; i<3; i++){
      for(int j=0; j<3; j++){
        if(list[i][j] != num){
          won = false;
          break;
        }
        num++;
      }

      if(!won){
        break;
      }
    }

    if(won){
      // print('Won');
      _timer.cancel();
      showAlertDialogBox(context, true);
    }
  }

  void reset(){
    selected = false;
    selectedRow = -1;
    selectedCol = -1;

    setState(() {});
  }

  Widget sampleContainer(int n){
    return Container(
      width: MediaQuery.of(context).size.width/7.8,  //50
      height: MediaQuery.of(context).size.width/7.8, //Same as width
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/${Values.fruits[n-1]}.png'),
            fit: BoxFit.cover
        )
      ),
    );
  }

  void startTimer(){
    setState(() {
      start = true;
    });

    _timer = new Timer.periodic(Duration(seconds: 1), (e){
      time--;
      if(time == 0){
        showAlertDialogBox(context, false);
        _timer.cancel();
      }
    });
  }

  Widget container(int n, int row, int col){
    return GestureDetector(
      onTap: (){
        if(!gameCompleted){
          //Start the game
          if(!start){
            startTimer();
          }

          if(!selected){
            selected = true;
            selectedRow = row;
            selectedCol = col;

            setState(() {});
          }else{
            if(list[row][col] != 9 && list[selectedRow][selectedCol] != 9){
              reset();
            }else{
              int diffRow = (row > selectedRow)? row - selectedRow: selectedRow - row;
              int diffCol = (col > selectedCol)? col - selectedCol: selectedCol - col;

              if(!(diffCol == 1 && diffRow == 1) && (diffCol == 1 || diffRow == 1)){
                int temp = list[selectedRow][selectedCol];
                list[selectedRow][selectedCol] = list[row][col];
                list[row][col] = temp;

                result();
              }

              reset();
            }
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width/3.92, //100
        height: MediaQuery.of(context).size.width/3.92,  //Same as Width
        decoration: (n < 9)? BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/${Values.fruits[n-1]}.png'),
            fit: BoxFit.cover
          ),
          border: (selected)?
          (selectedRow == row && selectedCol == col)?
          Border.all(color: Colors.red, width: 2.0, style: BorderStyle.solid):
          Border.all(color: Colors.transparent, width: 1.0, style: BorderStyle.solid):
          Border.all(color: Colors.transparent, width: 1.0, style: BorderStyle.solid),
        ):
        BoxDecoration(
          color: Colors.white,
          border: (selected)?
          (selectedRow == row && selectedCol == col)?
          Border.all(color: Colors.red, width: 2.0, style: BorderStyle.solid):
          Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid):
          Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
        ),
      ),
    );
  }

  @override
  void initState() {
    suffledImage();
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
        title: Text('Correct the Image'),
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
              duration: Duration(seconds: 20),
              child: Container(
                color: (time < 3)? Colors.redAccent: Colors.green,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sampleContainer(1),
                      sampleContainer(2),
                      sampleContainer(3),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sampleContainer(4),
                      sampleContainer(5),
                      sampleContainer(6),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sampleContainer(7),
                      sampleContainer(8),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    container(list[0][0], 0, 0),
                    container(list[0][1], 0, 1),
                    container(list[0][2], 0, 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    container(list[1][0], 1, 0),
                    container(list[1][1], 1, 1),
                    container(list[1][2], 1, 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    container(list[2][0], 2, 0),
                    container(list[2][1], 2, 1),
                    container(list[2][2], 2, 2),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
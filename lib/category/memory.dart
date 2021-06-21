import 'package:flutter/material.dart';

class Memory extends StatefulWidget {
  @override
  _MemoryState createState() => _MemoryState();
}

class _MemoryState extends State<Memory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Memory'),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Category(txt1: 'Match', txt2: 'Pairs',),
                Category(txt1: 'Aliens', txt2: '',),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width/6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Category(txt1: 'Color', txt2: 'Sequence',),
                // Category(txt1: 'idk1', txt2: '',),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class Category extends StatefulWidget {

  String txt1, txt2;

  Category({this.txt1, this.txt2});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  //Handles click event
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: GestureDetector(
          onTapDown: (TapDownDetails details){
            setState(() {
              pressed = true;
            });
          },
          onTapUp: (TapUpDetails details){
            setState(() {
              pressed = false;
            });
          },
          onTap: (){
            Navigator.pushNamed(context, '/${widget.txt1 + widget.txt2}');
          },
          child: Container(
            width: MediaQuery.of(context).size.width/2.8,
            height: MediaQuery.of(context).size.width/2.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  //Background
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3.0,3.0),
                      blurRadius: (pressed)? 0: 10.0,
                      spreadRadius: (pressed)? 0: 2.0
                  ),
                  //Foreground
                  BoxShadow(
                      color: Colors.white,
                      offset: (pressed)? Offset(3.0,3.0): Offset(0.0,0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0
                  ),
                ],
                image: DecorationImage(
                  image: (widget.txt1 == 'idk1')? AssetImage("assets/idk.png"):AssetImage("assets/${widget.txt1}.png"),
                  fit: BoxFit.cover,
                )
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.txt1,
                    style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 26.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    widget.txt2,
                    style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

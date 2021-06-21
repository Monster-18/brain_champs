import 'package:flutter/material.dart';

class Logical extends StatefulWidget {
  @override
  _LogicalState createState() => _LogicalState();
}

class _LogicalState extends State<Logical> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Logical'),
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
                Category(txt1: 'Multiply', txt2: '',),
                Category(txt1: 'Clock', txt2: 'Difference',),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width/6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Category(txt1: 'Correct', txt2: 'Image',),
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
                  //Front
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
                        color: Colors.pinkAccent,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    widget.txt2,
                    style: TextStyle(
                        color: Colors.pinkAccent,
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

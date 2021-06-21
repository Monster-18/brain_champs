import 'package:flutter/material.dart';

//Values
import 'package:brain_champs/details/values.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    Values.width = MediaQuery.of(context).size.width;
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Category'),
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
                Category(text: 'Eyes'),
                Category(text: 'Memory'),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width/6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Category(text: 'idk'),
                Category(text: 'Logical'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class Category extends StatefulWidget {

  String text;

  Category({this.text});

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
            Navigator.pushNamed(context, '/${widget.text}');
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
                image: AssetImage("assets/${widget.text}.png"),
                fit: BoxFit.cover,
              )
            ),
            child: Center(
                child: Text(
                    widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}

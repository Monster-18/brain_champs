import 'package:flutter/material.dart';

//Pages
import 'package:brain_champs/home.dart';

//Category
import 'package:brain_champs/category/eyes.dart';
import 'package:brain_champs/category/memory.dart';
import 'package:brain_champs/category/idk.dart';
import 'package:brain_champs/category/logical.dart';

//Memory
import 'package:brain_champs/memory/matchPairs.dart';
import 'package:brain_champs/memory/aliens.dart';
import 'package:brain_champs/memory/colorSequence.dart';
import 'package:brain_champs/memory/idk1.dart';

//Eyes
import 'package:brain_champs/eyes/bouncingBall.dart';
import 'package:brain_champs/eyes/stars.dart';

//Logical
import 'package:brain_champs/logical/multiply.dart';
import 'package:brain_champs/logical/correctImage.dart';
import 'package:brain_champs/logical/clockDifference.dart';

//UFO
import 'package:brain_champs/details/canvas/person.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Brain Champs',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),

        '/Eyes': (context) => Eyes(),
        '/Memory': (context) => Memory(),
        '/idk': (context) => idk(),
        '/Logical': (context) => Logical(),

        //Memory
        '/MatchPairs': (context) => MatchPairs(),
        '/Aliens': (context) => Aliens(),
        '/ColorSequence': (context) => ColorSequence(),
        // '/idk1': (context) => idk1(),

        //Eyes
        '/BouncingBall': (context) => BouncingBall(),
        '/Stars': (context) => Stars(),

        //Logical
        '/Multiply': (context) => Multiply(),
        '/CorrectImage': (context) => CorrectImage(),
        '/ClockDifference': (context) => ClockDifference(),

        //Canvas
        // '/Person': (context) => Person(),
      },
    )
  );
}

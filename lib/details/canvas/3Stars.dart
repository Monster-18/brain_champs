import 'package:flutter/material.dart';

class Star3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: MyPainter(),
      child: Container(
        // color: Colors.red,
      ),
    );
  }
}

class MyPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.yellow
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    var paintLine = new Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    double x = 40, y = 40;
    canvas.drawLine(
        Offset(x, y),
        Offset(x+2, y-5),
        paint
    );

    canvas.drawLine(
        Offset(x+2, y-5),
        Offset(x+4, y),
        paint
    );

    canvas.drawLine(
        Offset(x+4, y),
        Offset(x+10, y+2),
        paint
    );

    canvas.drawLine(
        Offset(x+10, y+2),
        Offset(x+4, y+4),
        paint
    );

    canvas.drawLine(
        Offset(x+4, y+4),
        Offset(x+2, y+10),
        paint
    );

    canvas.drawLine(
        Offset(x+2, y+10),
        Offset(x, y+4),
        paint
    );

    canvas.drawLine(
        Offset(x, y+4),
        Offset(x-6, y+2),
        paint
    );

    canvas.drawLine(
        Offset(x-6, y+2),
        Offset(x, y),
        paint
    );


    //Connect
    canvas.drawLine(            //x = 130, y=210;
        Offset(x+14, y+2),       //144, 212
        Offset(x+112, y+2),       //242, 212
        paintLine
    );

    //Another
    x = x + 120;        //x = 250
    y = y;        //y = 210
    canvas.drawLine(
        Offset(x, y),
        Offset(x+2, y-5),
        paint
    );

    canvas.drawLine(
        Offset(x+2, y-5),
        Offset(x+4, y),
        paint
    );

    canvas.drawLine(
        Offset(x+4, y),
        Offset(x+10, y+2),
        paint
    );

    canvas.drawLine(
        Offset(x+10, y+2),
        Offset(x+4, y+4),
        paint
    );

    canvas.drawLine(
        Offset(x+4, y+4),
        Offset(x+2, y+10),
        paint
    );

    canvas.drawLine(
        Offset(x+2, y+10),
        Offset(x, y+4),
        paint
    );

    canvas.drawLine(
        Offset(x, y+4),
        Offset(x-6, y+2),
        paint
    );

    canvas.drawLine(
        Offset(x-6, y+2),
        Offset(x, y),
        paint
    );

    //Connect
    canvas.drawLine(            //x = 250, y = 210
        Offset(x+2, y+14),       //252, 222
        Offset(x-46, y+102),       //252, 308
        paintLine
    );

    //Another
    x = x-60;          //x = 130
    y = y+100;          //y = 310
    canvas.drawLine(
        Offset(x, y),
        Offset(x+2, y-5),
        paint
    );

    canvas.drawLine(
        Offset(x+2, y-5),
        Offset(x+4, y),
        paint
    );

    canvas.drawLine(
        Offset(x+4, y),
        Offset(x+10, y+2),
        paint
    );

    canvas.drawLine(
        Offset(x+10, y+2),
        Offset(x+4, y+4),
        paint
    );

    canvas.drawLine(
        Offset(x+4, y+4),
        Offset(x+2, y+10),
        paint
    );

    canvas.drawLine(
        Offset(x+2, y+10),
        Offset(x, y+4),
        paint
    );

    canvas.drawLine(
        Offset(x, y+4),
        Offset(x-6, y+2),
        paint
    );

    canvas.drawLine(
        Offset(x-6, y+2),
        Offset(x, y),
        paint
    );

    //Connect
    canvas.drawLine(            //x = 130, y = 310
        Offset(x-10, y+2),       //142, 312
        Offset(x-58, y-86),       //246, 312
        paintLine
    );

    // //Another
    // x = x+120;        //x = 250
    // y = y;        //y = 310
    // canvas.drawLine(
    //     Offset(x, y),
    //     Offset(x+2, y-5),
    //     paint
    // );
    //
    // canvas.drawLine(
    //     Offset(x+2, y-5),
    //     Offset(x+4, y),
    //     paint
    // );
    //
    // canvas.drawLine(
    //     Offset(x+4, y),
    //     Offset(x+10, y+2),
    //     paint
    // );
    //
    // canvas.drawLine(
    //     Offset(x+10, y+2),
    //     Offset(x+4, y+4),
    //     paint
    // );
    //
    // canvas.drawLine(
    //     Offset(x+4, y+4),
    //     Offset(x+2, y+10),
    //     paint
    // );
    //
    // canvas.drawLine(
    //     Offset(x+2, y+10),
    //     Offset(x, y+4),
    //     paint
    // );
    //
    // canvas.drawLine(
    //     Offset(x, y+4),
    //     Offset(x-6, y+2),
    //     paint
    // );
    //
    // canvas.drawLine(
    //     Offset(x-6, y+2),
    //     Offset(x, y),
    //     paint
    // );
    //
    // //Connect
    // canvas.drawLine(        //x = 250, y = 310
    //     Offset(x-118, y-88),     //132, 222
    //     Offset(x-118, y-8),     //132, 302
    //     paintLine
    // );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}
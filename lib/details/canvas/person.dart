import 'package:flutter/material.dart';

class Person extends StatelessWidget {
  final int count;
  Person({this.count});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        foregroundPainter: MyPainter(count: count),
        child: Container(),
      ),
    );
  }
}

class MyPainter extends CustomPainter{
  int count;
  MyPainter({this.count});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint()
        ..color = Colors.black
        ..strokeWidth = 3.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

    int divisions = 6;  //Count+2
    // var width = size.width / divisions;
    // double width = 0;
    double width = size.width/2  - ((count-1)/2 * 30) ;
    while(count-- > 0) {
      //Head
      var path = new Path();
      path.addOval(Rect.fromCircle(
          center: Offset(width, size.height / 3),
          radius: 10.0
      ));
      canvas.drawPath(path, paint);

      //Body
      path = new Path();
      paint.style = PaintingStyle.stroke;
      path.moveTo(width, size.height / 3 + 10);
      path.lineTo(width, size.height / 3 + 50);
      canvas.drawPath(path, paint);

      //Right Hand
      path.moveTo(width, size.height / 3 + 20);
      path.lineTo(width + 15, size.height / 3 + 10);
      //Left Hand
      path.moveTo(width, size.height / 3 + 20);
      path.lineTo(width - 15, size.height / 3 + 10);
      canvas.drawPath(path, paint);

      //Right Leg
      path.moveTo(width, size.height / 3 + 30);
      path.lineTo(width + 15, size.height / 3 + 50);
      //Left Leg
      path.moveTo(width, size.height / 3 + 30);
      path.lineTo(width - 15, size.height / 3 + 50);
      canvas.drawPath(path, paint);
      width += 30;
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UFO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: MyPainter(),
      child: Container(),
    );
  }
}

class MyPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint()
        ..strokeWidth = 3.0
        ..color = Colors.green
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round;

    //Body Part
    var path = new Path();
    paint.color = Colors.red;
    path.moveTo(size.width/2, size.height/2);
    path.addOval(Rect.fromCenter(center: Offset(size.width/2, size.height/2), width: 250, height: 100));
    canvas.drawPath(path, paint);

    //Head Part
    path = new Path();
    paint.color = Colors.yellow;
    path.moveTo(size.width/2 - 60, size.height/2 - 43);
    path.arcToPoint(Offset(size.width/2 + 60, size.height/2 - 43), radius: Radius.circular(2.0));
    canvas.drawPath(path, paint);

    //Center rectangle
    path = new Path();
    path.moveTo(size.width/2 - 125, size.height/2);
    path.addRect(Rect.fromCenter(
        center: Offset(size.width/2, size.height/2), width: 250, height: 10
    ));
    paint.color = Colors.black;
    paint.style = PaintingStyle.fill;
    canvas.drawPath(path, paint);

    //Bottom Lines
    path = new Path();
    paint.style = PaintingStyle.fill;
    paint.color = Colors.blueGrey;
    // path.moveTo(size.width/2 - 30, size.height/2 + 48);
    // path.lineTo(size.width/2 - 50, size.height/2 + 123);

    path.moveTo(size.width/2 + 30, size.height/2 + 48);
    path.lineTo(size.width/2 + 80, size.height/2 + 263);
    path.arcToPoint(Offset(size.width/2 - 80, size.height/2 + 263), radius: Radius.elliptical(3, 1));
    path.lineTo(size.width/2 - 30, size.height/2 + 48);
    path.close();
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

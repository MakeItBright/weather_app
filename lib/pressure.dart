import 'package:flutter/material.dart';
import 'dart:math' as math;

class PressureGauge extends StatelessWidget {
  final double pressureInHpa;

  const PressureGauge({Key? key, required this.pressureInHpa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Переводим давление из гПа в мм рт. ст.
    final pressureInMmHg = (pressureInHpa * 0.750062).round();
    return CustomPaint(
      painter: PressureGaugePainter(pressureInMmHg),
      size: Size(MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.width / 4),
    );
  }
}

class PressureGaugePainter extends CustomPainter {
  final int pressureInMmHg;

  PressureGaugePainter(this.pressureInMmHg);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    // Рисуем дугу шкалы
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      math.pi,
      math.pi,
      false,
      paint,
    );

    // Рисуем указатель давления
    final pressureAngle = (math.pi / 180) * (pressureInMmHg - 720); // Примерное преобразование давления в угол
    final pressurePointerPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final center = Offset(size.width / 2, size.height);
    final pressurePointerEnd = center + Offset(math.cos(pressureAngle) * size.width / 2, -math.sin(pressureAngle) * size.width / 2);
    canvas.drawLine(center, pressurePointerEnd, pressurePointerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

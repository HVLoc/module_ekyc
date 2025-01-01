import 'package:module_ekyc/core/core.src.dart';
import 'package:flutter/material.dart';

class CustomShapePainterLiveNess extends CustomPainter {
  int heightCenter;

  CustomShapePainterLiveNess({this.heightCenter = 30});

  @override
  void paint(Canvas canvas, Size size) {
    // Vẽ các khối màu vào canvas
    Paint paint = Paint();

    // Tạo một Path đại diện cho phần bên ngoài của hình tròn
    double radius = size.width / 2 - 30; // Bán kính của hình tròn
    Offset center =
        Offset(size.width / 2, size.height / 2.5); // Tâm của hình tròn
    Path clipPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    clipPath.fillType = PathFillType.evenOdd;

    // Cắt bỏ phần bên trong của các khối theo hình tròn
    canvas.clipPath(clipPath);

    // Vẽ các khối màu đã được cắt bỏ

    // Vẽ khối màu 1
    paint.color = AppColors.basicWhite;
    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width * 0.5, size.height * 0.5), paint);

    // Vẽ khối màu 2
    paint.color = AppColors.basicWhite;
    canvas.drawRect(
        Rect.fromLTRB(size.width * 0.5, 0, size.width, size.height * 0.5),
        paint);

    // Vẽ khối màu 3
    paint.color = AppColors.basicWhite;
    canvas.drawRect(
        Rect.fromLTRB(0, size.height * 0.5, size.width * 0.5, size.height),
        paint);

    // Vẽ khối màu 4
    paint.color = AppColors.basicWhite;
    canvas.drawRect(
        Rect.fromLTRB(
            size.width * 0.5, size.height * 0.5, size.width, size.height),
        paint);

    // Vẽ viền nét đứt xung quanh hình tròn
    final borderPaint = Paint()
      ..color = AppColors.primaryNavy // Màu của viền
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0; // Độ rộng của viền

    const dashWidth = 15.0; // Độ rộng của mỗi đoạn trong viền đứt
    const dashSpace = 0.0; // Khoảng cách giữa các đoạn trong viền đứt

    // Tạo đường tròn để vẽ viền
    final path = Path();
    path.addOval(
      Rect.fromCircle(center: center, radius: radius),
    );

    // Vẽ viền nét đứt
    drawDashedPath(canvas, path, borderPaint, dashWidth, dashSpace);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void drawDashedPath(Canvas canvas, Path path, Paint paint, double dashWidth,
      double dashSpace) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double start = 0.0;
      while (start < metric.length) {
        final end = start + dashWidth;
        canvas.drawPath(
          metric.extractPath(start, end),
          paint,
        );
        start = end + dashSpace;
      }
    }
  }
}

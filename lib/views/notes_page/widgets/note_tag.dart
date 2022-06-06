import 'package:flutter/cupertino.dart';

class NoteTagWidget extends StatelessWidget {
  const NoteTagWidget({Key? key, required this.size, required this.child})
      : super(key: key);
  final Size size;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TagPainter(),
      child: SizedBox(
          height: size.height, width: size.width, child: Center(child: child)),
    );
  }
}

class TagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.style = PaintingStyle.fill;
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.7);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height * 0.7);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

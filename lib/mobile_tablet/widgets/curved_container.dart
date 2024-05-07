import 'package:flutter/material.dart';

class CurvedContainer extends StatelessWidget {
  final Color color;

  const CurvedContainer({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..scale(-1.0, -1.0, 1.0),
      child: ClipPath(
        clipper: CurvedTopClipper(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: color,
        ),
      ),
    );
  }
}

class CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50); // Adjust curve height
    path.quadraticBezierTo(
        size.width / 2, size.height + 50, size.width, size.height - 50); // Reverse curve direction
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

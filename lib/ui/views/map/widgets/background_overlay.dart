import 'package:flutter/material.dart';

class BackgroundOverlay extends StatelessWidget {
  final VoidCallback onTap;

  const BackgroundOverlay({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.black.withAlpha(100),
      ),
    );
  }
}

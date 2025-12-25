import 'package:flutter/material.dart';

class ShakingIcon extends StatefulWidget {
  const ShakingIcon({
    super.key,
    required this.icon,
    required this.color,
    this.size
  });

  final IconData icon;
  final Color color;
  final double? size;

  @override
  State<ShakingIcon> createState() => _ShakingIconState();
}

class _ShakingIconState extends State<ShakingIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> rotationAnimation = Tween<double>(
      begin: -0.05,
      end: 0.05,
    ).animate(_controller);

    return RotationTransition(
      turns: rotationAnimation,
      child: Icon(
        widget.icon,
        size: widget.size,
        color: widget.color,
      ),
    );
  }
}
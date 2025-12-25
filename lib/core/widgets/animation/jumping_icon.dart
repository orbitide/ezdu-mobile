import 'package:flutter/material.dart';

class JumpingIcon extends StatefulWidget {
  const JumpingIcon({super.key, required this.icon, required this.color, this.size});

  final IconData icon;
  final Color color;
  final double? size;

  @override
  State<JumpingIcon> createState() => _JumpingIconState();
}

class _JumpingIconState extends State<JumpingIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 1. Setup the AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600), // Speed of the jump
      vsync: this,
    )..repeat(reverse: true); // Make it loop continuously back and forth

    // 2. Setup the Animation (Tween)
    _animation = Tween<double>(begin: 0.0, end: -10.0).animate(
      // Use a curved animation for a natural jump effect
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3. Apply the Animation using Transform.translate
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          // Uses the animation value for the Y offset (negative for upward movement)
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      // The actual Icon widget is the child that gets translated
      child: Icon(
        widget.icon,
        size: widget.size,
        color: widget.color,
      ),
    );
  }
}
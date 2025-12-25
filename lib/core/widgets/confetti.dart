import 'package:flutter/material.dart';

class ConfettiWidget extends StatelessWidget {
  final AnimationController controller;

  const ConfettiWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: List.generate(20, (index) {
            final angle = (index / 20) * 2 * 3.14159;
            final distance = 200.0;
            final dx = distance * controller.value * (0.5 - 0.5);
            final dy = distance * controller.value * 0.5;

            return Positioned(
              left:
              MediaQuery.of(context).size.width / 2 +
                  dx * (index.isEven ? 1 : -1),
              top: MediaQuery.of(context).size.height / 4 + dy,
              child: Opacity(
                opacity: 1 - controller.value,
                child: Transform.rotate(
                  angle: angle + controller.value * 10,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: [
                        Colors.blue,
                        Colors.green,
                        Colors.pink,
                        Colors.yellow,
                        Colors.purple,
                      ][index % 5],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
